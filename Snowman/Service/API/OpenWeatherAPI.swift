import Foundation

final class OpenWeatherAPI: APIServiceProtocol {

    // MARK: - Private Properties

    private let apiKey: String
    private let baseURL = "https://api.openweathermap.org/data/2.5"
    private let decoder: JSONDecoder
    private let geocoder: GeocoderServiceProtocol
    private let networking: NetworkingServiceProtocol

    // MARK: - Init

    init(key: String, networking: NetworkingServiceProtocol, geocoder: GeocoderServiceProtocol = GeocoderService()) {
        self.apiKey = key
        self.networking = networking
        self.geocoder = geocoder

        self.decoder = JSONDecoder()
        self.decoder.dateDecodingStrategy = .secondsSince1970
    }

    // MARK: - APIServiceProtocol

    func getForecast(for location: Location, in units: Preferences.Units, completion: @escaping (Result<WeatherForecast, SnowmanError>) -> ()) {
        networking.get(url(for: location, in: units)) { result in
            switch result {
            case .success(let data):
                completion(self.parse(data, in: units))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func searchLocations(_ query: String, completion: @escaping (Result<[Location], SnowmanError>) -> Void) {
        geocoder.locations(for: query) { completion($0) }
    }

    // MARK: - Private

    private func url(for location: Location, in unitsSystem: Preferences.Units) -> String {
        let latitude = location.geoData.latitude
        let longitude = location.geoData.longitude
        let units = unitsString(for: unitsSystem)
        return "\(baseURL)/onecall?lat=\(latitude)&lon=\(longitude)&units=\(units)&appid=\(apiKey)"
    }

    private func parse(_ data: Data, in units: Preferences.Units) -> Result<WeatherForecast, SnowmanError> {
        guard let response = try? decoder.decode(OpenWeatherResponse.self, from: data) else {
            return .failure(.apiDataDecoding)
        }

        let currently: WeatherForecast.HourlyData
        var hourly = [WeatherForecast.HourlyData]()
        var daily = [WeatherForecast.DailyData]()

        // MARK: Currently
        let currentSunrise = response.current.sunrise
        let currentSunset = response.current.sunset
        let currrentlyDaytime = isDaytime(response.current.dt, sunrise: currentSunrise, sunset: currentSunset)

        guard let currentWeather = response.current.weather.first,
            let currentIcon = weatherStatus(for: currentWeather.id, isDaytime: currrentlyDaytime),
            let timezone = TimeZone(identifier: response.timezone) else {
            return .failure(.apiDataParsing)
        }

        currently = .init(date: response.current.dt,
                          timezone: timezone,
                          units: units,
                          temperature: response.current.temp,
                          apparentTemperature: response.current.feels_like,
                          icon: currentIcon,
                          precipProbability: response.hourly.first?.pop ?? precipProbability(for: currentIcon))

        // MARK: Hourly
        for hour in response.hourly {
            let daytime = isDaytime(hour.dt, sunrise: currentSunrise, sunset: currentSunset)

            guard let weather = hour.weather.first,
                let icon = weatherStatus(for: weather.id, isDaytime: daytime) else {
                return .failure(.apiDataParsing)
            }

            hourly.append(.init(date: hour.dt,
                                timezone: timezone,
                                units: units,
                                temperature: hour.temp,
                                apparentTemperature: hour.feels_like,
                                icon: icon,
                                precipProbability: hour.pop))
        }

        // MARK: Daily
        for day in response.daily {
            let daytime = isDaytime(day.dt, sunrise: day.sunrise, sunset: day.sunset)

            guard let weather = day.weather.first,
                let icon = weatherStatus(for: weather.id, isDaytime: daytime) else {
                return .failure(.apiDataParsing)
            }

            daily.append(.init(date: day.dt,
                               timezone: timezone,
                               units: units,
                               temperatureHigh: day.temp.max,
                               temperatureLow: day.temp.min,
                               icon: icon,
                               precipProbability: day.pop))
        }

        return .success(WeatherForecast(currently: currently, hourly: hourly, daily: daily))
    }

    private func unitsString(for units: Preferences.Units) -> String {
        switch units {
        case .si:
            return "metric"
        case .us:
            return "imperial"
        }
    }

    private func weatherStatus(for weatherCondition: Int, isDaytime: Bool) -> WeatherStatus? {
        // https://openweathermap.org/weather-conditions
        switch weatherCondition {
        case (200...232):
            return .init(description: .thunderstorm, daytime: isDaytime)
        case (300...321), (500...531):
            return .init(description: .rain, daytime: isDaytime)
        case (600...602), (615...622):
            return .init(description: .snow, daytime: isDaytime)
        case (611...613):
            return .init(description: .sleet, daytime: isDaytime)
        case (701...781):
            return .init(description: .fog, daytime: isDaytime)
        case 800:
            return .init(description: .clearSky, daytime: isDaytime)
        case (801...803):
            return .init(description: .partlyCloudy, daytime: isDaytime)
        case 804:
            return .init(description: .cloudy, daytime: isDaytime)
        default:
            return nil
        }
    }

    private func isDaytime(_ date: Date, sunrise: Date, sunset: Date) -> Bool {
        (sunrise...sunset).contains(date)
    }

    private func precipProbability(for status: WeatherStatus) -> Double {
        [.rain, .thunderstorm, .sleet].contains(status.description) ? 1.0 : 0.0
    }

}

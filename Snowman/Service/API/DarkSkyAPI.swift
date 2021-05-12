import Foundation

final class DarkSkyAPI: APIServiceProtocol {

    // MARK: - Properties
    
    var dataSourceName: String?
    
    private let apiKey: String
    private let decoder: JSONDecoder
    private let geocoder: GeocoderServiceProtocol
    private let networking: NetworkingServiceProtocol

    // MARK: - Init

    init(key: String,
         networking: NetworkingServiceProtocol = NetworkingService(),
         geocoder: GeocoderServiceProtocol = GeocoderService()) {
        self.apiKey = key
        self.networking = networking
        self.geocoder = geocoder
        self.dataSourceName = "DarkSky"

        self.decoder = JSONDecoder()
        self.decoder.dateDecodingStrategy = .secondsSince1970
    }

    // MARK: - APIServiceProtocol

    func getForecast(for location: Location, in units: Preferences.Units, completion: @escaping (Result<WeatherForecast, SnowmanError>) -> Void) {
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
        let units = string(for: unitsSystem)
        return "https://api.darksky.net/forecast/\(apiKey)/\(latitude),\(longitude)?units=\(units)"
    }
    
    private func parse(_ data: Data, in units: Preferences.Units) -> Result<WeatherForecast, SnowmanError> {
        guard let response = try? decoder.decode(DarkSkyResponse.self, from: data) else {
            return .failure(.apiDataDecoding)
        }

        var currently: WeatherForecast.HourlyData
        var hourly = [WeatherForecast.HourlyData]()
        var daily = [WeatherForecast.DailyData]()

        // MARK: Currently
        guard let currentlyData = response.currently,
            let temperature = currentlyData.temperature,
            let apparentTemperature = currentlyData.apparentTemperature,
            let icon = currentlyData.icon,
            let precipProbability = currentlyData.precipProbability,
            let sunrise = response.daily?.data.first?.sunriseTime,
            let sunset = response.daily?.data.first?.sunsetTime,
            let status = weatherStatus(for: icon, isDaytime: isDaytime(currentlyData.time, sunrise: sunrise, sunset: sunset)),
            let timezone = TimeZone(identifier: response.timezone) else {
                return .failure(.apiDataParsing)
        }

        currently = WeatherForecast.HourlyData(date: currentlyData.time,
                                               timezone: timezone,
                                               units: units,
                                               temperature: temperature,
                                               apparentTemperature: apparentTemperature,
                                               icon: status,
                                               precipProbability: precipProbability)

        // MARK: Hourly
        guard let hourlyData = response.hourly?.data else {
            return .failure(.apiDataParsing)
        }

        for hour in hourlyData {
            guard let temperature = hour.temperature,
                let apparentTemperature = hour.apparentTemperature,
                let icon = hour.icon,
                let precipProbability = hour.precipProbability,
                let sunrise = response.daily?.data.first?.sunriseTime,
                let sunset = response.daily?.data.first?.sunsetTime,
                let status = weatherStatus(for: icon, isDaytime: isDaytime(hour.time, sunrise: sunrise, sunset: sunset)) else {
                    return .failure(.apiDataParsing)
            }

            hourly.append(WeatherForecast.HourlyData(date: hour.time,
                                                     timezone: timezone,
                                                     units: units,
                                                     temperature: temperature,
                                                     apparentTemperature: apparentTemperature,
                                                     icon: status,
                                                     precipProbability: precipProbability))
        }

        // MARK: Daily
        guard let dailyData = response.daily?.data else {
            return .failure(.apiDataParsing)
        }

        for day in dailyData {
            guard let temperatureMax = day.temperatureMax,
                let temperatureMin = day.temperatureMin,
                let icon = day.icon,
                let precipProbability = day.precipProbability,
                let status = weatherStatus(for: icon, isDaytime: true) else {
                    return .failure(.apiDataParsing)
            }

            daily.append(WeatherForecast.DailyData(date: day.time,
                                                   timezone: timezone,
                                                   units: units,
                                                   temperatureHigh: temperatureMax,
                                                   temperatureLow: temperatureMin,
                                                   icon: status,
                                                   precipProbability: precipProbability))
        }

        return .success(WeatherForecast(currently: currently, hourly: hourly, daily: daily))
    }

    private func string(for units: Preferences.Units) -> String {
        switch units {
        case .si:
            return "si"
        case .us:
            return "us"
        }
    }

    private func weatherStatus(for weatherCondition: String, isDaytime: Bool) -> WeatherStatus? {
        switch weatherCondition {
        case "rain":
            return .init(description: .rain, daytime: isDaytime)
        case "snow":
            return .init(description: .snow, daytime: isDaytime)
        case "sleet":
            return .init(description: .sleet, daytime: isDaytime)
        case "fog":
            return .init(description: .fog, daytime: isDaytime)
        case "wind":
            return .init(description: .wind, daytime: isDaytime)
        case "clear-day", "clear-night":
            return .init(description: .clearSky, daytime: isDaytime)
        case "partly-cloudy-day", "partly-cloudy-night":
            return .init(description: .partlyCloudy, daytime: isDaytime)
        case "cloudy":
            return .init(description: .cloudy, daytime: isDaytime)
        default:
            return nil
        }
    }

    private func isDaytime(_ date: Date, sunrise: Date, sunset: Date) -> Bool {
        (sunrise...sunset).contains(date)
    }
    
}

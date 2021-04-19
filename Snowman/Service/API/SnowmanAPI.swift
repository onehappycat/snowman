import Foundation

final class SnowmanAPI: APIServiceProtocol {

    // MARK: - Properties
    
    var dataSourceName: String?

    private let baseURL: String
    private let decoder: JSONDecoder
    private let geocoder: GeocoderServiceProtocol
    private let networking: NetworkingServiceProtocol

    // MARK: - Init

    init(url: String, networking: NetworkingServiceProtocol, geocoder: GeocoderServiceProtocol = GeocoderService()) {
        self.baseURL = url.dropTrailingSlashIfPresent()
        self.networking = networking
        self.geocoder = geocoder

        self.decoder = JSONDecoder()
        self.decoder.dateDecodingStrategy = .secondsSince1970
    }

    init(hostname: String, networking: NetworkingServiceProtocol, geocoder: GeocoderServiceProtocol = GeocoderService()) {
        self.baseURL = "https://\(hostname.dropTrailingSlashIfPresent())/api/v1/forecast"
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
        let units = unitsSystem.rawValue
        return "\(baseURL)/\(latitude),\(longitude)?units=\(units)"
    }

    private func parse(_ data: Data, in units: Preferences.Units) -> Result<WeatherForecast, SnowmanError> {
        guard let response = try? decoder.decode(SnowmanResponse.self, from: data) else {
            return .failure(.apiDataDecoding)
        }

        dataSourceName = response.dataSourceName.rawValue
        return .success(response.forecast)
    }

}

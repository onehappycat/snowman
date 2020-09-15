import Foundation
import CoreLocation

final class GeocoderService: GeocoderServiceProtocol {

    private let geocoder = CLGeocoder()

    // MARK: - GeocoderServiceProtocol

    func locations(for query: String, completion: @escaping (Result<[Location], SnowmanError>) -> Void) {
        geocoder.geocodeAddressString(query) { placemarks, error in
            if let placemarks = placemarks {

                let locations = placemarks.compactMap { self.parse($0, fallbackName: query) }
                completion(.success(locations))

            } else if let error = error {

                switch error {
                case CLError.geocodeFoundNoResult:
                    completion(.success([]))
                default:
                    completion(.failure(.unknown))
                }

            } else {
                completion(.failure(.unknown))
            }
        }
    }

    // MARK: - Private

    private func parse(_ placemark: CLPlacemark, fallbackName query: String) -> Location? {
        if let coordinate = placemark.location?.coordinate {
            let fallbackName = placemark.name ?? query.capitalized
            let name = placemark.locality ?? fallbackName

            let location = Location(geoData: .init(latitude: coordinate.latitude,
                                                   longitude: coordinate.longitude,
                                                   name: name,
                                                   area: placemark.administrativeArea,
                                                   country: placemark.country))
            return location
        } else {
            return nil
        }
    }

}

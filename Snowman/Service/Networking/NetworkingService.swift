import Foundation

final class NetworkingService: NetworkingServiceProtocol {

    // MARK: - NetworkingServiceProtocol

    func get(_ url: String, completion: @escaping (Result<Data, SnowmanError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.networkInvalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(.failure(.networkRequestFailed))
                return
            }

            switch response.statusCode {
            case 200 ..< 300:
                completion(.success(data))
            case 400:
                completion(.failure(.responseBadRequest))
            case 401:
                completion(.failure(.responseUnauthorized))
            default:
                completion(.failure(.responseUnknownError))
            }
        }.resume()
    }
    
}

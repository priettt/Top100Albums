//
// Created by Francisco Prieto on 04/02/2021.
//

import Foundation

struct URLSessionClient {
    func call(endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(NetworkError.urlError))
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NetworkError.dataResponseError))
            }
        }.resume()
    }
}

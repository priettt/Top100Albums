//
// Created by Francisco Prieto on 04/02/2021.
//

import UIKit

protocol AlbumImageServiceContract {
    func getAlbumImage(url: URL, completion: @escaping (Result<UIImage, Error>) -> Void)
}

class AlbumImageService: AlbumImageServiceContract {
    private let client: URLSessionClient

    init(client: URLSessionClient) {
        self.client = client
    }

    func getAlbumImage(url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        client.call(endpoint: GetAlbumImageEndpoint(url: url)) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(.failure(GetImageError.imageCreationError))
                    return
                }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct GetAlbumImageEndpoint: Endpoint {
    var url: URL?
}
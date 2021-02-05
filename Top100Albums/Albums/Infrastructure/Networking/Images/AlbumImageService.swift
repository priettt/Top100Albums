//
// Created by Francisco Prieto on 04/02/2021.
//

import UIKit

protocol AlbumImageServiceContract {
    func getAlbumImage(url: URL, completion: @escaping (Result<UIImage, Error>) -> Void)
}

class AlbumImageService: AlbumImageServiceContract {
    private let client: URLSessionClientContract
    private let imageDataMapper: ImageDataMapperContract

    init(client: URLSessionClientContract, imageDataMapper: ImageDataMapperContract) {
        self.client = client
        self.imageDataMapper = imageDataMapper
    }

    func getAlbumImage(url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        client.call(endpoint: GetAlbumImageEndpoint(url: url)) { [weak self] result in
            switch result {
            case .success(let data):
                guard let image = self?.imageDataMapper.getImage(data: data) else {
                    completion(.failure(GetImageError.imageMappingError))
                    return
                }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
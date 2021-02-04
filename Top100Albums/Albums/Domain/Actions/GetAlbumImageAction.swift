//
// Created by Francisco Prieto on 03/02/2021.
//

import UIKit

class GetAlbumImageAction {
    let albumImageService: AlbumImageServiceContract
    let albumImageStorage: AlbumImageStorage

    init(albumImageService: AlbumImageServiceContract, albumImageStorage: AlbumImageStorage) {
        self.albumImageService = albumImageService
        self.albumImageStorage = albumImageStorage
    }

    func getAlbumImage(imageUrl: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let storageImage = albumImageStorage.getAlbumImage(with: imageUrl.absoluteString) {
            completion(.success(storageImage))
        } else {
            albumImageService.getAlbumImage(url: imageUrl) { [weak self] result in
                guard let self = self else {
                    completion(.failure(GetImageError.selfInstanceError))
                    return
                }

                switch result {
                case .success(let image):
                    self.albumImageStorage.saveAlbumImage(image: image, key: imageUrl.absoluteString)
                    completion(.success(image))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

//
// Created by Francisco Prieto on 02/02/2021.
//

import Foundation

class FetchAlbumsAction {

    let albumsStorage: AlbumsStorage
    let albumsService: AlbumsServiceContract

    init(albumsStorage: AlbumsStorage, albumsService: AlbumsServiceContract) {
        self.albumsStorage = albumsStorage
        self.albumsService = albumsService
    }

    func fetch(completion: @escaping (Bool) -> Void) {
        albumsService.getAlbums { [weak self] result in
            guard let self = self else {
                completion(false)
                return
            }
            switch result {
            case .success(let albums):
                self.albumsStorage.saveAlbums(albums: albums)
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
}
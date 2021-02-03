//
// Created by Francisco Prieto on 02/02/2021.
//

import Foundation

class GetAlbumsCountAction {

    let albumsStorage: AlbumsStorage

    init(albumsStorage: AlbumsStorage) {
        self.albumsStorage = albumsStorage
    }

    func getAlbumsCount() -> Int {
        return albumsStorage.getAlbumsCount()
    }
}

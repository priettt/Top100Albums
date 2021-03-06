//
// Created by Francisco Prieto on 02/02/2021.
//

import Foundation

class GetAlbumAction: GetAlbumActionContract {

    let albumsStorage: AlbumsStorage

    init(albumsStorage: AlbumsStorage) {
        self.albumsStorage = albumsStorage
    }

    func getAlbum(at index: Int) -> Album {
        return albumsStorage.getAlbum(at: index)
    }
}

protocol GetAlbumActionContract {
    func getAlbum(at index: Int) -> Album
}
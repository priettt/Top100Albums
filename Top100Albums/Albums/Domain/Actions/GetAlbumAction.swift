//
// Created by Francisco Prieto on 02/02/2021.
//

import Foundation

class GetAlbumAction {

    let albumsStorage: AlbumsStorage

    init(albumsStorage: AlbumsStorage) {
        self.albumsStorage = albumsStorage
    }

    func getAlbum(at index: Int) -> AlbumCellData {
        return albumsStorage.getAlbum(at: index)
    }
}

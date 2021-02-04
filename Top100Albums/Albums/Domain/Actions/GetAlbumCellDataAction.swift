//
// Created by Francisco Prieto on 02/02/2021.
//

import Foundation

class GetAlbumCellDataAction {

    let albumsStorage: AlbumsStorage
    let mapper: AlbumMapper

    init(albumsStorage: AlbumsStorage, mapper: AlbumMapper) {
        self.albumsStorage = albumsStorage
        self.mapper = mapper
    }

    func getAlbumCellData(at index: Int) -> AlbumCellData {
        let album = albumsStorage.getAlbum(at: index)
        return mapper.getAlbumCellData(album: album)
    }
}

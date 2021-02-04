//
// Created by Francisco Prieto on 02/02/2021.
//

import Foundation

class GetAlbumAction {

    let albumsStorage: AlbumsStorage
    let mapper: AlbumMapper

    init(albumsStorage: AlbumsStorage, mapper: AlbumMapper) {
        self.albumsStorage = albumsStorage
        self.mapper = mapper
    }

    func getAlbum(at index: Int) -> AlbumCellData {
        let album = albumsStorage.getAlbum(at: index)
        return mapper.getAlbumCellData(album: album)
    }
}

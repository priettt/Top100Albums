//
// Created by Francisco Prieto on 03/02/2021.
//

import Foundation

class AlbumMapper: AlbumMapperContract {

    func getAlbumCellData(album: Album) -> AlbumCellData {
        return AlbumCellData(id: album.id,
                albumName: album.albumName,
                artist: album.artistName,
                albumImageUrl: album.albumImageUrl)
    }

}

protocol AlbumMapperContract {
    func getAlbumCellData(album: Album) -> AlbumCellData
}
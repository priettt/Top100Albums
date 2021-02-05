//
// Created by Francisco Prieto on 04/02/2021.
//

import Foundation

class AlbumDetailMapper: AlbumDetailMapperContract {
    func getAlbumDetail(album: Album) -> AlbumDetailData {
        return AlbumDetailData(id: album.id,
                artistName: album.artistName,
                albumName: album.albumName,
                genres: album.genres.joined(separator: ", "),
                releaseDate: album.releaseDate,
                copyright: album.copyright,
                albumUrl: album.albumUrl)
    }
}

protocol AlbumDetailMapperContract {
    func getAlbumDetail(album: Album) -> AlbumDetailData
}
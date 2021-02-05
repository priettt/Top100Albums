//
// Created by Francisco Prieto on 04/02/2021.
//

import Foundation
@testable import Top100Albums

class AlbumDetailMapperMock: AlbumDetailMapperContract {
    private let testAlbumDetailData = AlbumDetailData(id: "testId",
            artistName: "testArtistName",
            albumName: "testAlbumName",
            genres: "genre1, genre2",
            releaseDate: "releaseDate",
            copyright: "copyright",
            albumUrl: URL.init(fileURLWithPath: "test")
    )

    func getAlbumDetail(album: Album) -> AlbumDetailData {
        return testAlbumDetailData
    }
}
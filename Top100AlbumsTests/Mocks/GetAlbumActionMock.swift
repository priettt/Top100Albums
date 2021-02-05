//
// Created by Francisco Prieto on 04/02/2021.
//

import Foundation
@testable import Top100Albums

class GetAlbumActionMock: GetAlbumActionContract {

    private let testAlbum = Album(id: "testId",
            artistName: "testArtistName",
            albumName: "testAlbumName",
            albumImageUrl: URL(fileURLWithPath: "test"),
            genres: ["genre1", "genre2"],
            releaseDate: "releaseDate",
            copyright: "copyright",
            albumUrl: URL.init(fileURLWithPath: "test")
    )

    func getAlbum(at index: Int) -> Album {
        return testAlbum
    }
}
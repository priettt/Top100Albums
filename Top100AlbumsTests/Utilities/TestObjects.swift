//
// Created by Francisco Prieto on 04/02/2021.
//

import Foundation
@testable import Top100Albums

struct TestObjects {
    static let testAlbum = Album(id: "testId",
            artistName: "testArtistName",
            albumName: "testAlbumName",
            albumImageUrl: URL(fileURLWithPath: "test"),
            genres: ["genre1", "genre2"],
            releaseDate: "releaseDate",
            copyright: "copyright",
            albumUrl: URL.init(fileURLWithPath: "test")
    )

    static let testAlbumDetailData = AlbumDetailData(id: "testId",
            artistName: "testArtistName",
            albumName: "testAlbumName",
            genres: "genre1, genre2",
            releaseDate: "releaseDate",
            copyright: "copyright",
            albumUrl: URL.init(fileURLWithPath: "test")
    )

    static let testAlbumCellData = AlbumCellData(id: "testId",
            albumName: "testAlbumName",
            artist: "testArtist",
            albumImageUrl: URL(fileURLWithPath: "testURL"))
}


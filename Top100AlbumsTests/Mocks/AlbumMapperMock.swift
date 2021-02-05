//
// Created by Francisco Prieto on 04/02/2021.
//

import Foundation
@testable import Top100Albums

class AlbumMapperMock: AlbumMapperContract {
    var testAlbumCellData = AlbumCellData(id: "testId",
            albumName: "testAlbumName",
            artist: "testArtist",
            albumImageUrl: URL(fileURLWithPath: "testURL"))

    func getAlbumCellData(album: Album) -> AlbumCellData {
        return testAlbumCellData
    }
}

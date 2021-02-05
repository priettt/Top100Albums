//
// Created by Francisco Prieto on 04/02/2021.
//

import Foundation
@testable import Top100Albums

class AlbumDetailMapperMock: AlbumDetailMapperContract {

    func getAlbumDetail(album: Album) -> AlbumDetailData {
        return TestObjects.testAlbumDetailData
    }
}
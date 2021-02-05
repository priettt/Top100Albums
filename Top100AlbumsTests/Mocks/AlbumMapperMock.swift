//
// Created by Francisco Prieto on 04/02/2021.
//

import Foundation
@testable import Top100Albums

class AlbumMapperMock: AlbumMapperContract {
    func getAlbumCellData(album: Album) -> AlbumCellData {
        return TestObjects.testAlbumCellData
    }
}

//
// Created by Francisco Prieto on 04/02/2021.
//

import Foundation
@testable import Top100Albums

class GetAlbumActionMock: GetAlbumActionContract {

    func getAlbum(at index: Int) -> Album {
        return TestObjects.testAlbum
    }
}
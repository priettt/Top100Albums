//
// Created by Francisco Prieto on 04/02/2021.
//

import Foundation
@testable import Top100Albums

class AlbumsResponseMapperMock: AlbumsResponseMapperContract {

    var wasCalled = false
    var result: [Album]? = [TestObjects.testAlbum]

    func getAlbums(response: Data) -> [Album]? {
        wasCalled = true
        return result
    }
}

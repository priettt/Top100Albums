//
// Created by Francisco Prieto on 04/02/2021.
//

import Foundation
@testable import Top100Albums

class AlbumsStorageMock: AlbumsStorage {

    var saveAlbumsWasCalled = false

    func getAlbumsCount() -> Int {
        return 0
    }

    func getAlbum(at index: Int) -> Album {
        return TestObjects.testAlbum
    }

    func saveAlbums(albums: [Album]) {
        saveAlbumsWasCalled = true
    }
}

//
// Created by Francisco Prieto on 04/02/2021.
//

import XCTest
@testable import Top100Albums

class InMemoryAlbumsTest: XCTestCase {
    private var storage = InMemoryAlbums()

    override func setUp() {
        super.setUp()
        setupStorage()
    }

    private func setupStorage() {
        storage = InMemoryAlbums()
    }

    func test_whenSavingAnAlbum_shouldBeAbleToRetrieveIt() {
        let album = TestObjects.testAlbum
        storage.saveAlbums(albums: [album])
        XCTAssertEqual(album.id, storage.getAlbum(at: 0).id)
    }

    func test_whenSavingMultipleAlbums_shouldBeAbleToRetrieveThem() {
        let album = TestObjects.testAlbum
        let anotherAlbum = TestObjects.anotherTestAlbum
        storage.saveAlbums(albums: [album, anotherAlbum])
        XCTAssertEqual(album.id, storage.getAlbum(at: 0).id)
        XCTAssertEqual(anotherAlbum.id, storage.getAlbum(at: 1).id)
    }

    func test_whenSavingMultipleAlbums_shouldRetrieveCorrectCount() {
        let album = TestObjects.testAlbum
        let anotherAlbum = TestObjects.anotherTestAlbum
        storage.saveAlbums(albums: [album, anotherAlbum])
        XCTAssertEqual(2, storage.getAlbumsCount())
    }

    func test_whenThereAreNoAlbums_countShouldReturnZero(){
        XCTAssertEqual(0, storage.getAlbumsCount())
    }
}

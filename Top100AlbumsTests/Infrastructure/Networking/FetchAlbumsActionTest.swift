//
// Created by Francisco Prieto on 04/02/2021.
//

import XCTest
@testable import Top100Albums

class FetchAlbumsActionTest: XCTestCase {
    private var action: FetchAlbumsAction?

    private var albumsStorageMock = AlbumsStorageMock()
    private var albumsServiceMock = AlbumsServiceMock()

    override func setUp() {
        super.setUp()
        setupMocks()
        setupAction()
    }

    private func setupMocks() {
        albumsStorageMock = AlbumsStorageMock()
        albumsServiceMock = AlbumsServiceMock()
    }

    private func setupAction() {
        action = FetchAlbumsAction(albumsStorage: albumsStorageMock, albumsService: albumsServiceMock)
    }

    func test_fetch_shouldReturnFalse_whenServiceFails() {
        givenAServiceFailure()

        action?.fetch { [weak self] result in
            self?.thenReturnsFalse(result: result)
        }
    }

    func test_fetch_shouldReturnTrue_whenServiceSucceeds() {
        givenAServiceSuccess()

        action?.fetch { [weak self] result in
            self?.thenReturnsTrue(result: result)
        }
    }

    func test_fetch_shouldCallSaveAlbums_whenServiceSucceeds() {
        givenAServiceSuccess()

        action?.fetch { [weak self] result in
            self?.thenCallsSaveAlbums()
        }
    }

    private func givenAServiceFailure() {
        albumsServiceMock.completionResult = .failure(NetworkError.dataMappingError)
    }

    private func givenAServiceSuccess() {
        albumsServiceMock.completionResult = .success([TestObjects.testAlbum])
    }

    private func thenReturnsFalse(result: Bool) {
        XCTAssertFalse(result)
    }

    private func thenReturnsTrue(result: Bool) {
        XCTAssertTrue(result)
    }

    private func thenCallsSaveAlbums() {
        XCTAssertTrue(albumsStorageMock.saveAlbumsWasCalled)
    }
}

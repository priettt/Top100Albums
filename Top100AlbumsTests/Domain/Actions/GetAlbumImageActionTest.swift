//
// Created by Francisco Prieto on 04/02/2021.
//

import XCTest
import UIKit
@testable import Top100Albums

class GetAlbumImageActionTest: XCTestCase {
    private var action: GetAlbumImageAction?

    private var albumImageStorageMock = AlbumImageStorageMock()
    private var albumImageServiceMock = AlbumImageServiceMock()

    private let testURL = URL(fileURLWithPath: "test")

    override func setUp() {
        super.setUp()
        setupMocks()
        setupAction()
    }

    private func setupMocks() {
        albumImageStorageMock = AlbumImageStorageMock()
        albumImageServiceMock = AlbumImageServiceMock()
    }

    private func setupAction() {
        action = GetAlbumImageAction(albumImageService: albumImageServiceMock, albumImageStorage: albumImageStorageMock)
    }

    func test_getAlbumImage_shouldReturnImage_whenImageIsAlreadyInTheCache() {
        givenImageIsAlreadyInTheCache()

        action?.getAlbumImage(imageUrl: testURL) { [weak self] result in
            self?.thenReturnsImage(result: result)
        }
    }

    func test_getAlbumImage_shouldReturnFailure_whenServiceFails() {
        givenAServiceFailure()

        action?.getAlbumImage(imageUrl: testURL) { [weak self] result in
            self?.thenReturnsFailure(result: result)
        }
    }

    func test_getAlbumImage_shouldReturnImage_whenServiceSucceeds() {
        givenAServiceSuccess()

        action?.getAlbumImage(imageUrl: testURL) { [weak self] result in
            self?.thenReturnsImage(result: result)
        }
    }

    func test_getAlbumImage_shouldSaveImageInStorage_whenServiceSucceeds() {
        givenAServiceSuccess()

        action?.getAlbumImage(imageUrl: testURL) { [weak self] result in
            self?.thenCallsSaveImage()
        }
    }

    private func givenAServiceSuccess() {
        albumImageServiceMock.completionResult = .success(UIImage())
    }

    private func givenAServiceFailure() {
        albumImageServiceMock.completionResult = .failure(GetImageError.imageCreationError)
    }
    
    private func givenImageIsAlreadyInTheCache() {
        albumImageStorageMock.savedImage = UIImage()
    }

    private func thenReturnsImage(result: Result<UIImage, Error>) {
        switch result {
        case .success(_):
            XCTAssert(true)
        case .failure(_):
            XCTFail()
        }
    }

    private func thenCallsSaveImage() {
        XCTAssert(albumImageStorageMock.saveImageWasCalled)
    }

    private func thenReturnsFailure(result: Result<UIImage, Error>) {
        switch result {
        case .success(_):
            XCTFail()
        case .failure(let error):
            guard error is GetImageError else {
                XCTFail()
                return
            }
        }
    }
}

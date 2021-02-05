//
// Created by Francisco Prieto on 04/02/2021.
//

import XCTest
@testable import Top100Albums

class AlbumImageServiceTest: XCTestCase {
    private var service: AlbumImageService?

    private var urlSessionClientMock = URLSessionClientMock()
    private var imageDataMapperMock = ImageDataMapperMock()

    private var testURL = URL(fileURLWithPath: "test")

    override func setUp() {
        super.setUp()
        setupMocks()
        setupService()
    }

    private func setupMocks() {
        urlSessionClientMock = URLSessionClientMock()
        imageDataMapperMock = ImageDataMapperMock()
    }

    private func setupService() {
        service = AlbumImageService(client: urlSessionClientMock, imageDataMapper: imageDataMapperMock)
    }

    func test_getAlbumImage_whenClientCallIsSuccessful_shouldCallMapper() {
        givenASuccessfulClientCall()

        service?.getAlbumImage(url: testURL) { _ in
        }

        thenMapperIsCalled()
    }

    func test_getAlbumImage_whenClientCallFails_shouldReturnFailure() {
        givenAClientCallFailure(error: GetImageError.imageCreationError)

        service?.getAlbumImage(url: testURL) { [weak self] result in
            self?.thenReturnsFailure(result: result, expectedError: GetImageError.imageCreationError)
        }
    }

    func test_getAlbumImage_whenResponseMappingFails_shouldReturnImageMappingError() {
        givenASuccessfulClientCall()
        givenAFailureInResponseMapping()

        service?.getAlbumImage(url: testURL) { [weak self] result in
            self?.thenReturnsFailure(result: result, expectedError: GetImageError.imageMappingError)
        }
    }

    func test_getAlbumImage_whenResponseMappingSucceeds_shouldReturnSuccess() {
        givenASuccessfulClientCall()

        service?.getAlbumImage(url: testURL) { [weak self] result in
            self?.thenReturnsSuccess(result: result)
        }
    }

    private func givenASuccessfulClientCall() {
        urlSessionClientMock.completionResult = .success(Data())
    }

    private func givenAClientCallFailure(error: Error) {
        urlSessionClientMock.completionResult = .failure(error)
    }

    private func givenAFailureInResponseMapping() {
        imageDataMapperMock.result = nil
    }

    private func thenReturnsSuccess(result: Result<UIImage, Error>) {
        switch result {
        case .success(_):
            XCTAssert(true)
        case .failure(_):
            XCTFail()
        }
    }

    private func thenReturnsFailure(result: Result<UIImage, Error>, expectedError: GetImageError) {
        switch result {
        case .success(_):
            XCTFail()
        case .failure(let error):
            guard let error = error as? GetImageError else {
                XCTFail()
                return
            }
            XCTAssertEqual(expectedError, error)
        }
    }

    private func thenMapperIsCalled() {
        XCTAssertTrue(imageDataMapperMock.wasCalled)
    }
}

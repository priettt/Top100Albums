//
// Created by Francisco Prieto on 04/02/2021.
//

import XCTest
@testable import Top100Albums

class AlbumsServiceTest: XCTestCase {
    private var service: AlbumsService?

    private var urlSessionClientMock = URLSessionClientMock()
    private var albumsResponseMapperMock = AlbumsResponseMapperMock()

    override func setUp() {
        super.setUp()
        setupMocks()
        setupService()
    }

    private func setupMocks() {
        urlSessionClientMock = URLSessionClientMock()
        albumsResponseMapperMock = AlbumsResponseMapperMock()
    }

    private func setupService() {
        service = AlbumsService(client: urlSessionClientMock, albumsResponseMapper: albumsResponseMapperMock)
    }

    func test_getAlbums_whenClientCallIsSuccessful_shouldCallMapper() {
        givenASuccessfulClientCall()

        service?.getAlbums { _ in
        }

        thenMapperIsCalled()
    }

    func test_getAlbums_whenClientCallFails_shouldReturnFailure() {
        givenAClientCallFailure(error: NetworkError.dataResponseError)

        service?.getAlbums { [weak self] result in
            self?.thenReturnsFailure(result: result, expectedError: NetworkError.dataResponseError)
        }
    }

    func test_getAlbums_whenResponseMappingFails_shouldReturnDataMappingError() {
        givenASuccessfulClientCall()
        givenAFailureInResponseMapping()

        service?.getAlbums { [weak self] result in
            self?.thenReturnsFailure(result: result, expectedError: NetworkError.dataMappingError)
        }
    }

    func test_getAlbums_whenResponseMappingSucceeds_shouldReturnSuccess() {
        givenASuccessfulClientCall()

        service?.getAlbums { [weak self] result in
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
        albumsResponseMapperMock.result = nil
    }

    private func thenReturnsSuccess(result: Result<[Album], Error>) {
        switch result {
        case .success(_):
            XCTAssert(true)
        case .failure(_):
            XCTFail()
        }
    }

    private func thenReturnsFailure(result: Result<[Album], Error>, expectedError: NetworkError) {
        switch result {
        case .success(_):
            XCTFail()
        case .failure(let error):
            guard let error = error as? NetworkError else {
                XCTFail()
                return
            }
            XCTAssertEqual(expectedError, error)
        }
    }

    private func thenMapperIsCalled() {
        XCTAssertTrue(albumsResponseMapperMock.wasCalled)
    }
}

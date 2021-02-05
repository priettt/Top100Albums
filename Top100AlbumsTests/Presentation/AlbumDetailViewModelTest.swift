//
// Created by Francisco Prieto on 04/02/2021.
//

import XCTest
import UIKit
@testable import Top100Albums

class AlbumDetailViewModelTest: XCTestCase, AlbumDetailViewModelDelegate {
    func onImageLoadSuccess(image: UIImage) {
        onImageLoadSuccessWasCalled = true
    }

    func onImageLoadError() {
        onImageLoadErrorWasCalled = true
    }

    func setupAlbumData(album: AlbumDetailData) {
        setupAlbumDataWasCalled = true
    }

    private var viewModel: AlbumDetailViewModel?
    private var getAlbumImageActionMock = GetAlbumImageActionMock()
    private var albumDetailMapperMock = AlbumDetailMapperMock()

    private var onImageLoadSuccessWasCalled = false
    private var onImageLoadErrorWasCalled = false
    private var setupAlbumDataWasCalled = false

    override func setUp() {
        super.setUp()
        setupMocks()
        setupViewModel()
        setupDelegateCallSupervisors()
    }

    private func setupMocks() {
        getAlbumImageActionMock = GetAlbumImageActionMock()
        albumDetailMapperMock = AlbumDetailMapperMock()
    }

    private func setupDelegateCallSupervisors() {
        onImageLoadSuccessWasCalled = false
        onImageLoadErrorWasCalled = false
        setupAlbumDataWasCalled = false
    }

    private func setupViewModel() {
        viewModel = AlbumDetailViewModel(album: TestObjects.testAlbum, getAlbumImageAction: getAlbumImageActionMock, albumDetailMapper: albumDetailMapperMock)
        viewModel?.delegate = self
    }

    func test_onViewDidLoad_shouldSetupAlbumData() {

        viewModel?.onViewDidLoad()

        thenSetupAlbumDataIsCalled()
    }

    func test_onViewDidLoad_whenGetAlbumImageSucceeds_shouldCallImageLoadSuccess() {
        givenASuccessfulGetImageRequest()

        viewModel?.onViewDidLoad()

        thenOnImageLoadSuccessIsCalled()
    }

    func test_onViewDidLoad_whenGetAlbumImageFails_shouldCallImageLoadError() {
        givenAGetImageRequestFailure()

        viewModel?.onViewDidLoad()

        thenOnImageLoadErrorIsCalled()
    }

    private func thenOnImageLoadSuccessIsCalled() {
        XCTAssertTrue(onImageLoadSuccessWasCalled)
    }

    private func thenOnImageLoadErrorIsCalled() {
        XCTAssertTrue(onImageLoadErrorWasCalled)
    }

    private func thenSetupAlbumDataIsCalled() {
        XCTAssertTrue(setupAlbumDataWasCalled)
    }

    private func givenASuccessfulGetImageRequest() {
        getAlbumImageActionMock.completionResult = .success(UIImage())
    }

    private func givenAGetImageRequestFailure() {
        getAlbumImageActionMock.completionResult = .failure(GetImageError.imageCreationError)
    }
}

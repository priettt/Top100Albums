//
// Created by Francisco Prieto on 04/02/2021.
//

import XCTest
import UIKit
@testable import Top100Albums

class AlbumCellViewModelTest: XCTestCase, AlbumCellViewModelDelegate {
    func onImageLoadSuccess(image: UIImage) {
        onImageLoadSuccessWasCalled = true
    }

    func onImageLoadError() {
        onImageLoadErrorWasCalled = true
    }

    private var viewModel: AlbumCellViewModel?
    private var getAlbumImageActionMock = GetAlbumImageActionMock()

    private var onImageLoadSuccessWasCalled = false
    private var onImageLoadErrorWasCalled = false

    private var testURL = URL(fileURLWithPath: "test")

    override func setUp() {
        super.setUp()
        setupMocks()
        setupViewModel()
        setupDelegateCallSupervisors()
    }

    private func setupMocks() {
        getAlbumImageActionMock = GetAlbumImageActionMock()
    }

    private func setupDelegateCallSupervisors() {
        onImageLoadSuccessWasCalled = false
        onImageLoadErrorWasCalled = false
    }

    private func setupViewModel() {
        viewModel = AlbumCellViewModel(getAlbumImageAction: getAlbumImageActionMock)
        viewModel?.delegate = self
    }

    func test_loadImage_whenGetAlbumImageSucceeds_shouldCallImageLoadSuccess() {
        givenASuccessfulGetImageRequest()

        viewModel?.loadImage(imageUrl: testURL)

        thenOnImageLoadSuccessIsCalled()
    }

    func test_onViewDidLoad_whenGetAlbumImageFails_shouldCallImageLoadError() {
        givenAGetImageRequestFailure()

        viewModel?.loadImage(imageUrl: testURL)

        thenOnImageLoadErrorIsCalled()
    }

    private func thenOnImageLoadSuccessIsCalled() {
        XCTAssertTrue(onImageLoadSuccessWasCalled)
    }

    private func thenOnImageLoadErrorIsCalled() {
        XCTAssertTrue(onImageLoadErrorWasCalled)
    }

    private func givenASuccessfulGetImageRequest() {
        getAlbumImageActionMock.completionResult = .success(UIImage())
    }

    private func givenAGetImageRequestFailure() {
        getAlbumImageActionMock.completionResult = .failure(GetImageError.imageCreationError)
    }
}

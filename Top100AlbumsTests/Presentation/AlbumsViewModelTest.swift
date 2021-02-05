//
// Created by Francisco Prieto on 04/02/2021.
//

import XCTest
@testable import Top100Albums

class AlbumsViewModelTest: XCTestCase, AlbumsViewControllerDelegate {
    func hideLoader() {
        hideLoaderWasCalled = true
    }

    func updateTableView() {
        updateTableViewWasCalled = true
    }

    func showError() {
        showErrorWasCalled = true
    }

    private var viewModel: AlbumsViewModel?
    private var getAlbumActionMock = GetAlbumActionMock()
    private var getAlbumsCountActionMock = GetAlbumsCountActionMock()
    private var fetchAlbumsActionMock = FetchAlbumsActionMock()
    private var albumMapperMock = AlbumMapperMock()

    private var hideLoaderWasCalled = false
    private var updateTableViewWasCalled = false
    private var showErrorWasCalled = false
    private var goToDetailWasCalled = false

    override func setUp() {
        super.setUp()
        setupMocks()
        setupViewModel()
        setupDelegateCallSupervisors()
    }

    private func setupMocks() {
        getAlbumActionMock = GetAlbumActionMock()
        getAlbumsCountActionMock = GetAlbumsCountActionMock()
        fetchAlbumsActionMock = FetchAlbumsActionMock()
        albumMapperMock = AlbumMapperMock()
    }

    private func setupDelegateCallSupervisors() {
        hideLoaderWasCalled = false
        updateTableViewWasCalled = false
        showErrorWasCalled = false
    }

    private func setupViewModel() {
        viewModel = AlbumsViewModel(getAlbumAction: getAlbumActionMock,
                getAlbumsCountAction: getAlbumsCountActionMock,
                fetchAlbumsAction: fetchAlbumsActionMock,
                mapper: albumMapperMock)
        viewModel?.viewControllerDelegate = self
    }

    func test_onViewDidLoad_whenFetchAlbumsSucceeds_shouldUpdateTableView() {
        givenASuccessfulFetchRequest()

        viewModel?.onViewDidLoad()

        thenUpdateTableViewIsCalled()
    }

    func test_onViewDidLoad_whenFetchAlbumsCompletes_shouldHideLoader() {
        givenASuccessfulFetchRequest()

        viewModel?.onViewDidLoad()

        thenHideLoaderIsCalled()
    }

    func test_onViewDidLoad_whenFetchAlbumsFails_shouldShowError() {
        givenAFetchRequestFailure()

        viewModel?.onViewDidLoad()

        thenShowErrorWasCalled()
    }

    private func thenUpdateTableViewIsCalled() {
        XCTAssertTrue(updateTableViewWasCalled)
    }

    private func thenHideLoaderIsCalled() {
        XCTAssertTrue(hideLoaderWasCalled)
    }

    private func thenShowErrorWasCalled() {
        XCTAssertTrue(showErrorWasCalled)
    }

    private func givenASuccessfulFetchRequest() {
        fetchAlbumsActionMock.completionResult = true
    }

    private func givenAFetchRequestFailure() {
        fetchAlbumsActionMock.completionResult = false
    }
}

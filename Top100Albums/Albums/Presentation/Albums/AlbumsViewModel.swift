//
// Created by Francisco Prieto on 02/02/2021.
//

import Foundation

class AlbumsViewModel {

    private let getAlbumAction: GetAlbumActionContract
    private let getAlbumsCountAction: GetAlbumsCountActionContract
    private let fetchAlbumsAction: FetchAlbumsActionContract
    private let mapper: AlbumMapperContract

    weak var viewControllerDelegate: AlbumsViewControllerDelegate?
    weak var coordinatorDelegate: CoordinatorDelegate?

    init(getAlbumAction: GetAlbumActionContract, getAlbumsCountAction: GetAlbumsCountActionContract, fetchAlbumsAction: FetchAlbumsActionContract, mapper: AlbumMapperContract) {
        self.getAlbumAction = getAlbumAction
        self.getAlbumsCountAction = getAlbumsCountAction
        self.fetchAlbumsAction = fetchAlbumsAction
        self.mapper = mapper
    }

    func onViewDidLoad() {
        fetchAlbumsAction.fetch { [weak self] success in
            if success {
                self?.viewControllerDelegate?.updateTableView()
            } else {
                self?.viewControllerDelegate?.showError()
            }
            self?.viewControllerDelegate?.hideLoader()
        }
    }

    func getAlbumsCount() -> Int {
        return getAlbumsCountAction.getAlbumsCount()
    }

    func getAlbumData(for index: Int) -> AlbumCellData {
        return mapper.getAlbumCellData(album: getAlbumAction.getAlbum(at: index))
    }

    func onDidSelectRow(at index: Int) {
        coordinatorDelegate?.goToDetail(selectedAlbum: getAlbumAction.getAlbum(at: index))
    }
}

protocol AlbumsViewControllerDelegate: class {
    func hideLoader()
    func updateTableView()
    func showError()
}

protocol CoordinatorDelegate: class {
    func goToDetail(selectedAlbum: Album)
}
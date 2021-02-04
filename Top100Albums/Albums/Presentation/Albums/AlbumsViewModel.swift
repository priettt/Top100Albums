//
// Created by Francisco Prieto on 02/02/2021.
//

import Foundation

class AlbumsViewModel {

    private let getAlbumAction: GetAlbumAction
    private let getAlbumsCountAction: GetAlbumsCountAction
    private let fetchAlbumsAction: FetchAlbumsAction
    private let mapper: AlbumMapper

    weak var delegate: AlbumsViewModelDelegate?
    weak var coordinator: Coordinator?

    init(coordinator: Coordinator, getAlbumAction: GetAlbumAction, getAlbumsCountAction: GetAlbumsCountAction, fetchAlbumsAction: FetchAlbumsAction, mapper: AlbumMapper) {
        self.getAlbumAction = getAlbumAction
        self.getAlbumsCountAction = getAlbumsCountAction
        self.fetchAlbumsAction = fetchAlbumsAction
        self.coordinator = coordinator
        self.mapper = mapper
    }

    func onViewDidLoad() {
        fetchAlbumsAction.fetch { [weak self] success in
            if success {
                self?.delegate?.hideLoader()
                self?.delegate?.updateTableView()
            } else {
                self?.delegate?.hideLoader()
                self?.delegate?.showError()
            }
        }
    }

    func getAlbumsCount() -> Int {
        return getAlbumsCountAction.getAlbumsCount()
    }

    func getAlbumData(for index: Int) -> AlbumCellData {
        return mapper.getAlbumCellData(album: getAlbumAction.getAlbum(at: index))
    }

    func onDidSelectRow(at index: Int) {
        coordinator?.goToDetail(selectedAlbum: getAlbumAction.getAlbum(at: index))
    }
}

protocol AlbumsViewModelDelegate: class {
    func hideLoader()
    func updateTableView()
    func showError()
}
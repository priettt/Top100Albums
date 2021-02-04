//
// Created by Francisco Prieto on 02/02/2021.
//

import Foundation

class AlbumsViewModel {

    private let getAlbumCellDataAction: GetAlbumCellDataAction
    private let getAlbumsCountAction: GetAlbumsCountAction
    private let fetchAlbumsAction: FetchAlbumsAction

    weak var delegate: AlbumsViewModelDelegate?

    init(getAlbumCellDataAction: GetAlbumCellDataAction, getAlbumsCountAction: GetAlbumsCountAction, fetchAlbumsAction: FetchAlbumsAction) {
        self.getAlbumCellDataAction = getAlbumCellDataAction
        self.getAlbumsCountAction = getAlbumsCountAction
        self.fetchAlbumsAction = fetchAlbumsAction
    }

    func onViewDidLoad() {
        fetchAlbumsAction.fetch { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.delegate?.hideLoader()
                    self?.delegate?.updateTableView()
                } else {
                    self?.delegate?.hideLoader()
                    self?.delegate?.showError()
                }
            }
        }
    }

    func getAlbumsCount() -> Int {
        return getAlbumsCountAction.getAlbumsCount()
    }

    func getAlbumData(for index: Int) -> AlbumCellData {
        return getAlbumCellDataAction.getAlbumCellData(at: index)
    }
}

protocol AlbumsViewModelDelegate: class {
    func hideLoader()
    func updateTableView()
    func showError()
}
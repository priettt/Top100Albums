//
// Created by Francisco Prieto on 02/02/2021.
//

import Foundation

class AlbumsViewModel {

    private let getAlbumAction: GetAlbumAction
    private let getAlbumsCountAction: GetAlbumsCountAction
    private let fetchAlbumsAction: FetchAlbumsAction

    weak var delegate: AlbumsViewModelDelegate?

    init(getAlbumAction: GetAlbumAction, getAlbumsCountAction: GetAlbumsCountAction, fetchAlbumsAction: FetchAlbumsAction) {
        self.getAlbumAction = getAlbumAction
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
                    self?.delegate?.showError()
                    self?.delegate?.hideLoader()
                }
            }
        }
    }

    func getAlbumsCount() -> Int {
        return getAlbumsCountAction.getAlbumsCount()
    }

    func getAlbumData(for index: Int) -> AlbumCellData {
        return getAlbumAction.getAlbum(at: index)
    }
}

protocol AlbumsViewModelDelegate: class {
    func hideLoader()
    func updateTableView()
    func showError()
}
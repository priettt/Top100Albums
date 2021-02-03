//
// Created by Francisco Prieto on 02/02/2021.
//

import Foundation

class AlbumsViewModel {

    private let getAlbumAction: GetAlbumAction
    private let getAlbumsCountAction: GetAlbumsCountAction
    private let fetchAlbumsAction: FetchAlbumsAction

    weak var delegate: AlbumsViewModelDelegate?

    init(getAlbumAction: GetAlbumAction, getAlbumsCountAction: GetAlbumsCountAction, fetchAlbums: FetchAlbumsAction) {
        self.getAlbumAction = getAlbumAction
        self.getAlbumsCountAction = getAlbumsCountAction
        self.fetchAlbumsAction = fetchAlbums
    }

    func onViewDidLoad() {
        fetchAlbumsAction.fetch { [weak self] success in
            if success {
                print("Finished fetching")
                self?.delegate?.hideLoader()
                self?.delegate?.updateTableView()
            } else {
                self?.delegate?.showError()
            }
        }
    }

    func getAlbumsCount() -> Int {
        print("Albums count")
        return getAlbumsCountAction.getAlbumsCount()
    }

    func getAlbumData(for index: Int) -> AlbumCellData {
        print("Albums data")
        return getAlbumAction.getAlbum(at: index)
    }
}

protocol AlbumsViewModelDelegate: class {
    func hideLoader()
    func updateTableView()
    func showError()
}
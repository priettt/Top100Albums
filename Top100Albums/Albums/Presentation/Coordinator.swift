//
// Created by Francisco Prieto on 04/02/2021.
//

import UIKit

class Coordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let albumStorage = InMemoryAlbums()
        let service = AlbumsService(client: URLSessionClient(), albumsResponseMapper: AlbumsResponseMapper())
        let getAlbumsCountAction = GetAlbumsCountAction(albumsStorage: albumStorage)
        let fetchAlbumsAction = FetchAlbumsAction(albumsStorage: albumStorage, albumsService: service)
        let getAlbumAction = GetAlbumAction(albumsStorage: albumStorage)
        let viewModel = AlbumsViewModel(coordinator: self, getAlbumAction: getAlbumAction, getAlbumsCountAction: getAlbumsCountAction, fetchAlbumsAction: fetchAlbumsAction, mapper: AlbumMapper())
        let viewController = AlbumsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToDetail(selectedAlbum: Album) {
        let viewModel = AlbumDetailViewModel(album: selectedAlbum, getAlbumImageAction: GetAlbumImageAction(albumImageService: AlbumImageService(client: URLSessionClient()), albumImageStorage: AlbumImageCache.shared), coordinator: self, albumDetailMapper: AlbumDetailMapper())
        let viewController = AlbumDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

}
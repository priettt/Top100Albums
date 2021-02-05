//
// Created by Francisco Prieto on 04/02/2021.
//

import UIKit

class Coordinator: CoordinatorDelegate {
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
        let viewModel = AlbumsViewModel(getAlbumAction: getAlbumAction, getAlbumsCountAction: getAlbumsCountAction, fetchAlbumsAction: fetchAlbumsAction, mapper: AlbumMapper())
        viewModel.coordinatorDelegate = self
        let viewController = AlbumsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToDetail(selectedAlbum: Album) {
        let viewModel = AlbumDetailViewModel(album: selectedAlbum, getAlbumImageAction: GetAlbumImageAction(albumImageService: AlbumImageService(client: URLSessionClient(), imageDataMapper: ImageDataMapper()), albumImageStorage: AlbumImageCache.shared), albumDetailMapper: AlbumDetailMapper())
        let viewController = AlbumDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

}
//
// Created by Francisco Prieto on 02/02/2021.
//

import UIKit

class AlbumDetailViewModel {

    private let getAlbumImageAction: GetAlbumImageActionContract
    private let album: Album
    private let albumDetailMapper: AlbumDetailMapperContract

    weak var delegate: AlbumDetailViewModelDelegate?

    init(album: Album, getAlbumImageAction: GetAlbumImageActionContract, albumDetailMapper: AlbumDetailMapperContract) {
        self.album = album
        self.getAlbumImageAction = getAlbumImageAction
        self.albumDetailMapper = albumDetailMapper
    }

    func onViewDidLoad() {
        delegate?.setupAlbumData(album: albumDetailMapper.getAlbumDetail(album: album))
        getAlbumImageAction.getAlbumImage(imageUrl: album.albumImageUrl) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let image):
                self.delegate?.onImageLoadSuccess(image: image)
            case .failure(_):
                self.delegate?.onImageLoadError()
            }
        }
    }

    func goToAlbumURL() {
        UIApplication.shared.open(album.albumUrl)
    }
}

protocol AlbumDetailViewModelDelegate: class {
    func onImageLoadSuccess(image: UIImage)
    func onImageLoadError()
    func setupAlbumData(album: AlbumDetailData)
}
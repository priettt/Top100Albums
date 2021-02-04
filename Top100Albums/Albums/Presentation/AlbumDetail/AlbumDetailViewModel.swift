//
// Created by Francisco Prieto on 02/02/2021.
//

import UIKit

class AlbumDetailMapper {
    func getAlbumDetail(album: Album) -> AlbumDetailData {
        return AlbumDetailData(id: album.id,
                artistName: album.artistName,
                albumName: album.albumName,
                genres: album.genres.joined(separator: ", "),
                releaseDate: album.releaseDate,
                copyright: album.copyright,
                albumUrl: album.albumUrl)
    }
}

class AlbumDetailViewModel {

    private let getAlbumImageAction: GetAlbumImageAction
    private let album: Album
    private let albumDetailMapper: AlbumDetailMapper

    weak var delegate: AlbumDetailViewModelDelegate?
    weak var coordinator: Coordinator?

    init(album: Album, getAlbumImageAction: GetAlbumImageAction, coordinator: Coordinator?, albumDetailMapper: AlbumDetailMapper) {
        self.album = album
        self.getAlbumImageAction = getAlbumImageAction
        self.coordinator = coordinator
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
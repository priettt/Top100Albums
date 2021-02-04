//
// Created by Francisco Prieto on 03/02/2021.
//

import UIKit

class AlbumCellViewModel {
    private let getAlbumImageAction: GetAlbumImageAction
    weak var delegate: AlbumCellViewModelDelegate?

    init(getAlbumImageAction: GetAlbumImageAction) {
        self.getAlbumImageAction = getAlbumImageAction
    }

    func loadImage(imageUrl: URL) {
        getAlbumImageAction.getAlbumImage(imageUrl: imageUrl) { [weak self] result in
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
}

protocol AlbumCellViewModelDelegate: class {
    func onImageLoadSuccess(image: UIImage)
    func onImageLoadError()
}

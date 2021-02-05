//
// Created by Francisco Prieto on 04/02/2021.
//

import UIKit
@testable import Top100Albums

class AlbumImageStorageMock: AlbumImageStorage {
    var saveImageWasCalled = false
    var savedImage: UIImage? = nil

    func getAlbumImage(with key: String) -> UIImage? {
        return savedImage
    }

    func saveAlbumImage(image: UIImage, key: String) {
        saveImageWasCalled = true
    }
}

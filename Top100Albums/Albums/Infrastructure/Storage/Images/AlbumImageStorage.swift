//
// Created by Francisco Prieto on 04/02/2021.
//

import UIKit

protocol AlbumImageStorage {
    func getAlbumImage(with key: String) -> UIImage?
    func saveAlbumImage(image: UIImage, key: String)
}

class AlbumImageCache: AlbumImageStorage {

    static let shared = AlbumImageCache()

    private lazy var cache = NSCache<NSString, UIImage>()

    func getAlbumImage(with key: String) -> UIImage? {
        if let image = cache.object(forKey: NSString(string: key)) {
            return image
        }
        return nil
    }

    func saveAlbumImage(image: UIImage, key: String) {
        cache.setObject(image, forKey: NSString(string: key))
    }

}
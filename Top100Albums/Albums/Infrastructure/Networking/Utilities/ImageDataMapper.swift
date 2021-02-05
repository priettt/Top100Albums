//
// Created by Francisco Prieto on 05/02/2021.
//

import UIKit

class ImageDataMapper: ImageDataMapperContract {
    func getImage(data: Data) -> UIImage? {
        return UIImage(data: data)
    }
}

protocol ImageDataMapperContract {
    func getImage(data: Data) -> UIImage?
}
//
// Created by Francisco Prieto on 04/02/2021.
//

import UIKit
@testable import Top100Albums

class ImageDataMapperMock: ImageDataMapperContract {

    var wasCalled = false
    var result: UIImage? = UIImage()

    func getImage(data: Data) -> UIImage? {
        wasCalled = true
        return result
    }
}

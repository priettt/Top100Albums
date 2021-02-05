//
// Created by Francisco Prieto on 04/02/2021.
//

import Foundation
@testable import Top100Albums

class GetAlbumsCountActionMock: GetAlbumsCountActionContract {
    var albumsCount = 0

    func getAlbumsCount() -> Int {
        return albumsCount
    }
}
//
// Created by Francisco Prieto on 04/02/2021.
//

import UIKit
@testable import Top100Albums

class AlbumImageServiceMock: AlbumImageServiceContract {
    var completionResult: Result<UIImage, Error>?

    func getAlbumImage(url: URL, completion: @escaping (Result<UIImage, Error>) -> ()) {
        guard let completionResult = completionResult else {
            return completion(.failure(GetImageError.imageCreationError))
        }

        return completion(completionResult)
    }
}

//
// Created by Francisco Prieto on 04/02/2021.
//

import UIKit

@testable import Top100Albums

class GetAlbumImageActionMock: GetAlbumImageActionContract {

    var completionResult: Result<UIImage, Error>?

    func getAlbumImage(imageUrl: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let completionResult = completionResult else {
            return completion(.failure(GetImageError.imageCreationError))
        }

        return completion(completionResult)
    }
}
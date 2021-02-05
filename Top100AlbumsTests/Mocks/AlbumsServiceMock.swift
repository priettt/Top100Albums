//
// Created by Francisco Prieto on 04/02/2021.
//

import Foundation
@testable import Top100Albums

class AlbumsServiceMock: AlbumsServiceContract {
    var completionResult: Result<[Album], Error>?

    func getAlbums(completion: @escaping (Result<[Album], Error>) -> Void) {
        guard let completionResult = completionResult else {
            return completion(.failure(NetworkError.dataResponseError))
        }

        return completion(completionResult)
    }
}

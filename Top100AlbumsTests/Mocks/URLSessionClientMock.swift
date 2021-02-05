//
// Created by Francisco Prieto on 04/02/2021.
//

import Foundation
@testable import Top100Albums

class URLSessionClientMock: URLSessionClientContract {
    var completionResult: Result<Data, Error>?

    func call(endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let completionResult = completionResult else {
            return completion(.failure(NetworkError.urlError))
        }

        return completion(completionResult)
    }
}
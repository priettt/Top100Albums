//
// Created by Francisco Prieto on 04/02/2021.
//

import Foundation
@testable import Top100Albums

class FetchAlbumsActionMock: FetchAlbumsActionContract {
    var completionResult = false

    func fetch(completion: @escaping (Bool) -> Void) {
        completion(completionResult)
    }
}
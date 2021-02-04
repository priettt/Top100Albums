//
// Created by Francisco Prieto on 04/02/2021.
//

import Foundation

struct GetAlbumsEndpoint: Endpoint {
    static let REQUEST_URL = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"

    var url = URL(string: REQUEST_URL)
}

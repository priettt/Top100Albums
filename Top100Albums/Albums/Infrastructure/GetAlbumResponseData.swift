//
// Created by Francisco Prieto on 03/02/2021.
//

import Foundation

struct GetAlbumResponseData: Decodable {
    let feed: FeedResponseData
}

struct FeedResponseData: Decodable {
    let results: [AlbumResponseData]
}

struct AlbumResponseData: Decodable {
    let artistName: String
    let id: String
    let name: String
    let artworkUrl100: URL
    let genres: [GenreResponseData]
    let releaseDate: String
    let copyright: String
    let url: URL
}

struct GenreResponseData: Decodable {
    let name: String
}
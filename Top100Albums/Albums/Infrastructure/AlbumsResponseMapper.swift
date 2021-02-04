//
// Created by Francisco Prieto on 03/02/2021.
//

import Foundation

class AlbumsResponseMapper {
    func getAlbums(response: Data) -> [Album]? {
        let jsonDecoder = JSONDecoder()
        let feed = try! jsonDecoder.decode(GetAlbumResponseData.self, from: response)
        return getAlbums(from: feed)
    }

    private func getAlbums(from feed: GetAlbumResponseData?) -> [Album]? {
        guard let feed = feed else {
            return nil
        }

        return feed.feed.results.map {
            mapAlbumResponse(response: $0)
        }
    }

    private func mapAlbumResponse(response: AlbumResponseData) -> Album {
        return Album(id: response.id,
                artistName: response.artistName,
                albumName: response.name,
                thumbnailUrl: response.artworkUrl100,
                genres: response.genres.map { $0.name },
                releaseDate: response.releaseDate,
                copyright: response.copyright,
                albumUrl: response.url)
    }
}

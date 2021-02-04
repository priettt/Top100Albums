//
// Created by Francisco Prieto on 03/02/2021.
//

import Foundation

protocol AlbumsServiceContract {
    func getAlbums(completion: @escaping (Result<[Album], Error>) -> Void)
}

class URLSessionClient {
    func call(endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(NetworkError.urlError))
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NetworkError.dataResponseError))
            }
        }.resume()
    }
}

struct AlbumsService: AlbumsServiceContract {
    private let client: URLSessionClient
    private let albumsResponseMapper: AlbumsResponseMapper

    init(client: URLSessionClient, albumsResponseMapper: AlbumsResponseMapper) {
        self.client = client
        self.albumsResponseMapper = albumsResponseMapper
    }

    func getAlbums(completion: @escaping (Result<[Album], Error>) -> Void) {
        client.call(endpoint: GetAlbumsEndpoint()) { result in
            switch result {
            case .success(let data):
                guard let albums = albumsResponseMapper.getAlbums(response: data) else {
                    completion(.failure(NetworkError.dataMappingError))
                    return
                }
                completion(.success(albums))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}

struct GetAlbumsEndpoint: Endpoint {

    static let REQUEST_URL = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"

    var url = URL(string: REQUEST_URL)

}

protocol Endpoint {
    var url: URL? { get }
}

enum NetworkError: Swift.Error {
    case urlError
    case dataMappingError
    case dataResponseError
}
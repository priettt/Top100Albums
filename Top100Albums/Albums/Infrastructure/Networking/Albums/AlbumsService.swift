//
// Created by Francisco Prieto on 03/02/2021.
//

import Foundation

protocol AlbumsServiceContract {
    func getAlbums(completion: @escaping (Result<[Album], Error>) -> Void)
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
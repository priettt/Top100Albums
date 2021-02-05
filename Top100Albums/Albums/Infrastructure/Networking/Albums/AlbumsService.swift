//
// Created by Francisco Prieto on 03/02/2021.
//

import Foundation

protocol AlbumsServiceContract {
    func getAlbums(completion: @escaping (Result<[Album], Error>) -> Void)
}

class AlbumsService: AlbumsServiceContract {
    private let client: URLSessionClientContract
    private let albumsResponseMapper: AlbumsResponseMapperContract

    init(client: URLSessionClientContract, albumsResponseMapper: AlbumsResponseMapperContract) {
        self.client = client
        self.albumsResponseMapper = albumsResponseMapper
    }

    func getAlbums(completion: @escaping (Result<[Album], Error>) -> Void) {
        client.call(endpoint: GetAlbumsEndpoint()) { [weak self] result in
            switch result {
            case .success(let data):
                guard let albums = self?.albumsResponseMapper.getAlbums(response: data) else {
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
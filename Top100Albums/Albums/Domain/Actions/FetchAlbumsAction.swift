//
// Created by Francisco Prieto on 02/02/2021.
//

import Foundation

class FetchAlbumsAction {

    let albumsStorage: AlbumsStorage

    init(albumsStorage: AlbumsStorage) {
        self.albumsStorage = albumsStorage
    }

    func fetch(completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            self.albumsStorage.saveAlbums(albums: [AlbumCellData(id: "1", albumName: "Reputation Stadium Tour", artist: "Taylor Swift", thumbnailUrl: "url")])
            completion(true)
        }
    }
}
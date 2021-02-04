//
// Created by Francisco Prieto on 03/02/2021.
//

import Foundation

protocol AlbumsStorage {
    func getAlbumsCount() -> Int
    func getAlbum(at index: Int) -> Album
    func saveAlbums(albums: [Album])
}

class InMemoryAlbums: AlbumsStorage {
    var albums = [Album]()

    func saveAlbums(albums: [Album]) {
        self.albums.append(contentsOf: albums)
    }

    func getAlbumsCount() -> Int {
        return albums.count
    }

    func getAlbum(at index: Int) -> Album {
        return albums[index]
    }

}

//
// Created by Francisco Prieto on 03/02/2021.
//

import Foundation

protocol AlbumsStorage {
    func getAlbumsCount() -> Int
    func getAlbum(at index: Int) -> AlbumCellData
    func saveAlbums(albums: [AlbumCellData])
}

class InMemoryAlbums: AlbumsStorage {
    var albums = [AlbumCellData]()

    func saveAlbums(albums: [AlbumCellData]) {
        self.albums.append(contentsOf: albums)
    }

    func getAlbumsCount() -> Int {
        return albums.count
    }

    func getAlbum(at index: Int) -> AlbumCellData {
        return albums[index]
    }

}

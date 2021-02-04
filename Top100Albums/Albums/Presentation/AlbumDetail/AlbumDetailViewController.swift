//
//  ViewController.swift
//  Top100Albums
//
//  Created by Francisco Prieto on 30/01/2021.
//

import UIKit

class AlbumDetailViewController: UIViewController {

    private let albumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 24)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 24)
        label.textAlignment = .center
        return label
    }()

    private let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        label.textAlignment = .center
        return label
    }()

    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        label.textAlignment = .center
        return label
    }()

    private let copyrightInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 14)
        label.textAlignment = .center
        return label
    }()

    private let openInITunesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open in iTunes", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .purple
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 18)
        button.addTarget(self, action: #selector(goToAlbumURL), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()

    let viewModel: AlbumDetailViewModel

    init(viewModel: AlbumDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }

    override func viewDidLoad() {
        setupView()
        viewModel.onViewDidLoad()
    }

    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.9715528248, green: 0.8270135056, blue: 0.4844910291, alpha: 1)
        setupAlbumImage()
        setupAlbumName()
        setupArtistName()
        setupGenre()
        setupReleaseDate()
        setupCopyrightInfo()
        setupOpenInITunesButton()
    }

    private func setupAlbumImage() {
        view.addSubview(albumImage)
        NSLayoutConstraint.activate([
            albumImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            albumImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),

        ])
    }

    private func setupAlbumName() {
        view.addSubview(albumNameLabel)
        NSLayoutConstraint.activate([
            albumNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            albumNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            albumNameLabel.topAnchor.constraint(equalTo: albumImage.bottomAnchor, constant: 10),
        ])
    }

    private func setupArtistName() {
        view.addSubview(artistLabel)
        NSLayoutConstraint.activate([
            artistLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            artistLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            artistLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 10),
        ])
    }

    private func setupGenre() {
        view.addSubview(genreLabel)
        NSLayoutConstraint.activate([
            genreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            genreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            genreLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 10),
        ])
    }

    private func setupReleaseDate() {
        view.addSubview(releaseDateLabel)
        NSLayoutConstraint.activate([
            releaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            releaseDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            releaseDateLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 10),
        ])
    }

    private func setupCopyrightInfo() {
        view.addSubview(copyrightInfoLabel)
        NSLayoutConstraint.activate([
            copyrightInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            copyrightInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            copyrightInfoLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 10),
        ])
    }

    private func setupOpenInITunesButton() {
        view.addSubview(openInITunesButton)
        NSLayoutConstraint.activate([
            openInITunesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            openInITunesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            openInITunesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }

    @objc func goToAlbumURL(button: UIButton) {
        viewModel.goToAlbumURL()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlbumDetailViewController: AlbumDetailViewModelDelegate {
    func onImageLoadSuccess(image: UIImage) {
        DispatchQueue.main.async {
            self.albumImage.image = image
        }
    }

    func onImageLoadError() {
        DispatchQueue.main.async {
            self.albumImage.image = UIImage(systemName: "music.note.house")
        }
    }

    func setupAlbumData(album: AlbumDetailData) {
        albumNameLabel.text = album.albumName
        artistLabel.text = album.artistName
        genreLabel.text = album.genres
        releaseDateLabel.text = album.releaseDate
        copyrightInfoLabel.text = album.copyright
    }
}
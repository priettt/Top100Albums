//
// Created by Francisco Prieto on 30/01/2021.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    private var viewModel: AlbumCellViewModel

    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let imageActivityIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .purple
        return indicator
    }()

    private let artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let albumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let albumInformationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(style: CellStyle, reuseIdentifier: String?) {
        viewModel = AlbumCellViewModel(getAlbumImageAction: GetAlbumImageAction(albumImageService: AlbumImageService(client: URLSessionClient()), albumImageStorage: AlbumImageCache()))
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewModel.delegate = self
        setupView()
    }

    private func setupView() {
        backgroundColor = UIColor.clear
        accessoryType = .disclosureIndicator
        setupAlbumImage()
        setupImageActivityIndicator()
        setupAlbumLabels()
    }

    private func setupImageActivityIndicator() {
        contentView.addSubview(imageActivityIndicator)
        NSLayoutConstraint.activate([
            imageActivityIndicator.centerYAnchor.constraint(equalTo: albumImage.centerYAnchor),
            imageActivityIndicator.centerXAnchor.constraint(equalTo: albumImage.centerXAnchor),
        ])
    }

    private func setupAlbumLabels() {
        albumInformationStackView.addArrangedSubview(albumNameLabel)
        albumInformationStackView.addArrangedSubview(artistLabel)
        contentView.addSubview(albumInformationStackView)
        NSLayoutConstraint.activate([
            albumImage.heightAnchor.constraint(equalToConstant: 70),
            albumInformationStackView.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 8),
            albumInformationStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            albumInformationStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    private func setupAlbumImage() {
        contentView.addSubview(albumImage)
        let bottomConstraint = albumImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        NSLayoutConstraint.activate([
            albumImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            albumImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            bottomConstraint,
            albumImage.widthAnchor.constraint(equalToConstant: 100),
        ])
    }

    func configure(with albumData: AlbumCellData) {
        albumNameLabel.text = albumData.albumName
        artistLabel.text = albumData.artist
        imageActivityIndicator.startAnimating()
        viewModel.loadImage(imageUrl: albumData.albumImageUrl)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlbumTableViewCell: AlbumCellViewModelDelegate {
    func onImageLoadSuccess(image: UIImage) {
        imageActivityIndicator.stopAnimating()
        albumImage.image = image
    }

    func onImageLoadError() {
        imageActivityIndicator.stopAnimating()
        albumImage.image = UIImage(systemName: "music.note.house")
    }
}



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

    private let artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
        label.numberOfLines = 2
        return label
    }()

    private let albumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
        setupAlbumLabels()
    }

    private func setupAlbumLabels() {
        albumInformationStackView.addArrangedSubview(albumNameLabel)
        albumInformationStackView.addArrangedSubview(artistLabel)
        contentView.addSubview(albumInformationStackView)
        NSLayoutConstraint.activate([
            albumImage.heightAnchor.constraint(equalToConstant: 90),
            albumInformationStackView.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 10),
            albumInformationStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            albumInformationStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    private func setupAlbumImage() {
        contentView.addSubview(albumImage)
        NSLayoutConstraint.activate([
            albumImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            albumImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            albumImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            albumImage.widthAnchor.constraint(equalToConstant: 100),
        ])
    }

    func configure(with albumData: AlbumCellData) {
        albumNameLabel.text = albumData.albumName
        artistLabel.text = albumData.artist
        viewModel.loadImage(imageUrl: albumData.albumImageUrl)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlbumTableViewCell: AlbumCellViewModelDelegate {
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
}



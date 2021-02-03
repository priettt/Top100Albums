//
// Created by Francisco Prieto on 30/01/2021.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

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
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let albumThumbnail: UIImageView = {
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
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    private func setupView() {
        backgroundColor = UIColor.clear
        accessoryType = .disclosureIndicator
        setupAlbumThumbnail()
        setupAlbumLabels()
    }

    private func setupAlbumLabels() {
        albumInformationStackView.addArrangedSubview(albumNameLabel)
        albumInformationStackView.addArrangedSubview(artistLabel)
        contentView.addSubview(albumInformationStackView)
        NSLayoutConstraint.activate([
            albumThumbnail.heightAnchor.constraint(equalToConstant: 100),
            albumInformationStackView.leadingAnchor.constraint(equalTo: albumThumbnail.trailingAnchor, constant: 8),
            albumInformationStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            albumInformationStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    private func setupAlbumThumbnail() {
        contentView.addSubview(albumThumbnail)
        let bottomConstraint = albumThumbnail.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        bottomConstraint.priority = UILayoutPriority(rawValue: 999)     // Avoid constraints warnings
        NSLayoutConstraint.activate([
            albumThumbnail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            albumThumbnail.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            bottomConstraint,
            albumThumbnail.widthAnchor.constraint(equalToConstant: 100),
        ])
    }

    func bind(albumData: AlbumCellData) {
        albumNameLabel.text = albumData.albumName
        artistLabel.text = albumData.artist
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



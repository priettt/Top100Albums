//
//  ViewController.swift
//  Top100Albums
//
//  Created by Francisco Prieto on 30/01/2021.
//

import UIKit

class AlbumsViewController: UIViewController {

    let tableView = UITableView()
    let titleLabel = UILabel()

    override func viewDidLoad() {
        setupView()
    }

    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.9715528248, green: 0.8270135056, blue: 0.4844910291, alpha: 1)
        setupTitle()
        setupAlbums()
    }

    private func setupTitle() {
        titleLabel.text = "Top 100 Albums"
        titleLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 32)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }

    private func setupAlbums() {
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "albumCell")
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

}

extension AlbumsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! AlbumTableViewCell
        return cell
    }
}

extension AlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}


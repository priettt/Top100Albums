//
//  ViewController.swift
//  Top100Albums
//
//  Created by Francisco Prieto on 30/01/2021.
//

import UIKit

class AlbumsViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()

    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Top 100 Albums"
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let activityIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .purple
        return indicator
    }()

    let viewModel: AlbumsViewModel

    init(viewModel: AlbumsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }

    override func viewDidLoad() {
        viewModel.onViewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.9715528248, green: 0.8270135056, blue: 0.4844910291, alpha: 1)
        setupTitle()
        setupAlbums()
        setupActivityIndicator()
    }

    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }

    private func setupTitle() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }

    private func setupAlbums() {
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "albumCell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlbumsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getAlbumsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as? AlbumTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.getAlbumData(for: indexPath.row))
        return cell
    }
}

extension AlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension AlbumsViewController: AlbumsViewModelDelegate {
    func hideLoader() {
        activityIndicator.stopAnimating()
    }

    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func showError() {

    }
}
//
//  ViewController.swift
//  Top100Albums
//
//  Created by Francisco Prieto on 30/01/2021.
//

import UIKit

class AlbumsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        setupView()
    }

    private func setupView() {
        setupTitle()
    }
    
    private func setupTitle() {
        let title = UILabel()
        title.text = "Top 100 Albums"
        title.font = title.font.withSize(25)
        title.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(title)
        NSLayoutConstraint.activate([
              title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
            ])
    }

}


//
//  DetailedViewController.swift
//  CryptoApp
//
//  Created by Никита Гуляев on 01.03.2022.
//

import UIKit

class DetailedViewController: UIViewController {
    
    let cryptoName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categoryId: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cryptoName)
        view.addSubview(categoryId)
        view.backgroundColor = .magenta
        constraint()
    }

    private func constraint() {
        cryptoName.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        cryptoName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        categoryId.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
        categoryId.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    }
}

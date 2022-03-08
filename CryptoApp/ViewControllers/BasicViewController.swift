//
//  BasicViewController.swift
//  CryptoApp
//
//  Created by Никита Гуляев on 23.02.2022.
//

import UIKit

class BasicViewController: UIViewController, UITableViewDelegate {
    
    private var cryptoModel = [CryptoModelElement]()
    private var sorting: Bool = false
    lazy var sortCryptoModel = {
        return self.cryptoModel.sorted(by: {$0.name > $1.name})
    } ()
    private let detailedViewController = DetailedViewController()
    
    private let cryptoTable: UITableView = {
        let table = UITableView.init(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let tableRefreshControl : UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refresh
    }()
    
    private var sortingTableButton: UIBarButtonItem {
        let button = UIBarButtonItem(
            title: "🔀",
            style: .done,
            target: self,
            action: #selector(sortingTable))
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cryptoTable)
        cryptoNetwork { [weak self] in
            self?.cryptoModel = $0
            DispatchQueue.main.async {
                self?.cryptoTable.reloadData()
            }
        }
        cryptoTable.dataSource = self
        cryptoTable.delegate = self
        cryptoTable.refreshControl = tableRefreshControl
        cryptoTableConstraints()
        title = "Crypto Coin Gecko"
        navigationItem.rightBarButtonItem = sortingTableButton
        cryptoTable.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.reuseId)
    }
    
    //    MARK: - Private func
    
    private func cryptoTableConstraints() {
        cryptoTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        cryptoTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        cryptoTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        cryptoTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        cryptoNetwork { [weak self] in
            self?.cryptoModel = $0
            DispatchQueue.main.async {
                self?.cryptoTable.reloadData()
            }
        }
        sender.endRefreshing()
    }
    
    @objc private func sortingTable() {
        if sorting == false {
            sorting = true
            cryptoTable.reloadData()
        } else {
            sorting = false
            cryptoTable.reloadData()
        }
    }
    @objc private func backSort () {
        sorting = false
        cryptoTable.reloadData()
    }
}

//    MARK: - Table View Data Source

extension BasicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: CryptoTableViewCell.reuseId)

        if sorting == false {
            cell.textLabel?.text = cryptoModel[indexPath.row].name
            cell.detailTextLabel?.text = cryptoModel[indexPath.row].categoryId
        } else {
            cell.textLabel?.text = sortCryptoModel[indexPath.row].name
            cell.detailTextLabel?.text = sortCryptoModel[indexPath.row].categoryId
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(detailedViewController, animated: true)
        detailedViewController.cryptoName.text = cryptoModel[indexPath.row].name
        detailedViewController.categoryId.text = cryptoModel[indexPath.row].categoryId
        
    }
}

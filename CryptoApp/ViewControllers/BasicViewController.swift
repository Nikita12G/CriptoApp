//
//  BasicViewController.swift
//  CryptoApp
//
//  Created by Никита Гуляев on 23.02.2022.
//

import UIKit

class BasicViewController: UIViewController, UITableViewDelegate {
    
    private var cryptoModel = [CryptoModelElement]()
    private var cryptoData: [CryptoModelElement] = []
    private var sorting: Bool = false
    
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
    
    private let sortingBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "A <-> Z",
            style: .done,
            target: self,
            action: #selector(sortingMeaning)
        )
        
        return button
    }()
    
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
        navigationItem.rightBarButtonItem = sortingBarButton
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
    
    @objc private func sortingMeaning() {
        print("ppp")
        cryptoModel = cryptoModel.sorted(by: {$0.name < $1.name})
        print(cryptoModel)
        cryptoTable.reloadData()
    }
    
}

//    MARK: - Table View Data Source

extension BasicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = cryptoModel[indexPath.row].name
        cell.detailTextLabel?.text = cryptoModel[indexPath.row].categoryId
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(detailedViewController, animated: true)
        detailedViewController.cryptoName.text = cryptoModel[indexPath.row].name
        detailedViewController.categoryId.text = cryptoModel[indexPath.row].categoryId
        
    }
}

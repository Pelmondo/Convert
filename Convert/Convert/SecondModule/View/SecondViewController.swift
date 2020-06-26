//
//  SecondViewController.swift
//  Convert
//
//  Created by Сергей Прокопьев on 25.06.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import UIKit
import Foundation

class SecondViewController: UIViewController {

    var presenter: SecondPresenterProtocol!
    var currencies = Array<(key: String, value:String)>()
    var searchedCurrencies = Array<(key: String, value: String)>()
    var isSearching = false
    weak var delegate: MainViewDelegate?
    var tag: Int?
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        table.estimatedRowHeight = 42
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.backgroundColor = .white
        search.searchBarStyle = .minimal
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private let activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .gray
        activity.hidesWhenStopped = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Currencies"
        view.backgroundColor = .white
        presenter.getCurrencies()
        setSetting()
        setUpLayout()
    }
}

extension SecondViewController: SecondViewProtocol {
    func sucssec() {
        currencies = presenter.currencies
        DispatchQueue.main.async {
            self.activity.stopAnimating()
            self.tableView.isHidden = false
            self.searchBar.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    func failure() {
        print("fool")
    }
}
//MARK:- UITableViewDelegate, UITableViewDataSourse
extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? searchedCurrencies.count : currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if isSearching {
            let key = searchedCurrencies[indexPath.row].key
            let value = searchedCurrencies[indexPath.row].value
            cell.textLabel?.text = key + ": " + value
        } else {
            let key = currencies[indexPath.row].key
            let value = currencies[indexPath.row].value
            cell.textLabel?.text = key + ": " + value
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching {
            delegate?.update(searchedCurrencies[indexPath.row].key, tag: tag!)
        } else {
            delegate?.update(currencies[indexPath.row].key, tag: tag!)
        }
        self.navigationController?.popViewController(animated: true)
    }
}
//MARK:- SearchBar Extention
extension SecondViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedCurrencies = currencies.filter({$0.key.prefix(searchText.count) == searchText})
        isSearching = true
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        isSearching = false
        self.searchBar.showsCancelButton = false
        tableView.reloadData()
        self.searchBar.resignFirstResponder()
    }
}
//MARK:- protocol
extension SecondViewController {
    
    fileprivate func setSetting() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
        tableView.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.isHidden = true
        searchBar.delegate = self
        view.addSubview(activity)
        activity.startAnimating()
    }
    
    fileprivate func setUpLayout() {
            
            let constraints = [
                searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                
                tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                
                activity.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                activity.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            ]
            NSLayoutConstraint.activate(constraints)
        }
}

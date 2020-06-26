//
//  SecondPresenter.swift
//  Convert
//
//  Created by Сергей Прокопьев on 25.06.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation

protocol SecondPresenterProtocol: class {
    init(view: SecondViewProtocol, networkService: NetworkServiceProtocol)
    func getCurrencies()
    var currencies: Array<(key: String, value:String)> {get set}
}

protocol SecondViewProtocol: class {
    func sucssec()
    func failure()
    var delegate: MainViewDelegate? {get set}
    var tag: Int? {get set}
}

class SecondPresenter: SecondPresenterProtocol {
    let view: SecondViewProtocol
    let networkService: NetworkServiceProtocol
    var currencies = Array<(key: String, value:String)>()
    
    required init(view: SecondViewProtocol,  networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func getCurrencies() {
        networkService.getCurrency() { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let currencies):
                guard let arrCurrencies = currencies?.currencies else {return}
                self.currencies = Array(arrCurrencies)
                self.view.sucssec()
            case .failure(let error):
                print(error)
                self.view.failure()
            }
        }
    }
}


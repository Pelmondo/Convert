//
//  MainViewModel.swift
//  Convert
//
//  Created by Сергей Прокопьев on 24.06.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation

protocol MainViewProtocol: class {
    //
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, money: Currencies)
    func show()
}

class MainPresenter: MainViewPresenterProtocol {
    let view: MainViewProtocol
    let money: Currencies
    
    required init(view: MainViewProtocol, money: Currencies) {
        self.view = view
        self.money = money
    }
    
    func show() {
        // SomeLogick here
    }
    
    
}

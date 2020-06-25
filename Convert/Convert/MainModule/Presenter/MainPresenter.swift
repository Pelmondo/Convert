//
//  MainViewModel.swift
//  Convert
//
//  Created by Сергей Прокопьев on 24.06.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation

protocol MainViewProtocol: class {
    func succses(_ convert: Convert?)
    func failure()
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    func convertIT(_ it: Convert)
}

class MainPresenter: MainViewPresenterProtocol {
    let view: MainViewProtocol
    let networkService: NetworkServiceProtocol
    var convert: Convert?
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol ) {
        self.view = view
        self.networkService = networkService
    }
    
    func convertIT(_ it: Convert) {
        self.networkService.doConvert(it) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let convert):
                self.convert = convert
                self.view.succses(convert)
            case .failure(let error):
                self.view.failure()
            }
            
        }
    }
    
    
}

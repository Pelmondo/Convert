//
//  MainTestModule.swift
//  ConvertTests
//
//  Created by Сергей Прокопьев on 26.06.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import XCTest
@testable import Convert

class MockView: MainViewProtocol {
    func succses(_ convert: Convert?, _ tag: Int) {
        print(convert!, tag)
    }
    
    func failure(_ error: Error) {
        print(error)
    }
}

class MainTestModule: XCTestCase {

    var view: MockView!
    var networkService: NetworkService!
    var presenter: MainPresenter!
    
    override func setUpWithError() throws {
        view = MockView()
        networkService = NetworkService()
        presenter  = MainPresenter(view: view, networkService: networkService)
    }

    override func tearDownWithError() throws {
        view = nil
        presenter = nil
        networkService = nil
    }

    func testModuleNotNil() throws {
        XCTAssertNotNil(view, "view is not nil")
        XCTAssertNotNil(presenter, "presenter is not nil")
        XCTAssertNotNil(networkService, "networkService is not nil")
        
    }
    
}

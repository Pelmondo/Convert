//
//  ViewController.swift
//  Convert
//
//  Created by Сергей Прокопьев on 23.06.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var presenter: MainViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkService.getCurrency()
    }


}


//
//  MainViewComtroller + Extenssion.swift
//  Convert
//
//  Created by Сергей Прокопьев on 25.06.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation
import UIKit

extension MainViewController {
    func makeTextField() -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.keyboardType = .decimalPad
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        return textField
    }
    
    func makeUIButton() -> UIButton {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Конвертировать", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        return button
    }
    
    func makeCurrUIButton(_ name: String) -> UIButton {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(name, for: .normal)
        button.addTarget(self, action: #selector(currButtonTapped(sender:)), for: .touchUpInside)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        return button
    }
}

extension MainViewController: MainViewDelegate {
    func update(_ name: String, tag: Int) {
        tag == 1 ? self.currenciesOutButton.setTitle(name, for: .normal)
            : self.currenciesInButton.setTitle(name, for: .normal)
        tag == 1 ? (self.outTextField.placeholder = name) : (self.inTextField.placeholder = name)
        self.outTextField.text = ""
        self.inTextField.text = ""
    }
}

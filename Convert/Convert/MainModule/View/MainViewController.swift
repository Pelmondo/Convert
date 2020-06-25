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
    lazy var outTextField = makeTextField()
    lazy var inTextField = makeTextField()
    lazy var convButton = makeUIButton()
    lazy var currenciesOutButton = makeCurrUIButton("AUD")
    lazy var currenciesInButton = makeCurrUIButton("USD")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        view.addSubview(outTextField)
        view.addSubview(convButton)
        view.addSubview(currenciesOutButton)
        view.addSubview(inTextField)
        view.addSubview(currenciesInButton)
        setUpLayout()
        
    }

    @objc func buttonTaped(sender: UIButton) {
        guard let amount = inTextField.text else {return}
        guard let to = currenciesOutButton.titleLabel?.text else {return}
        guard let from = currenciesInButton.titleLabel?.text else {return}
        presenter.convertIT(Convert(to: to, from: from, amount: amount))
    }
    
//    @objc func textDidEndEditing(sender: UITextField) {
//        guard let amount = inTextField.text else {return}
//        guard let to = currenciesOutButton.titleLabel?.text else {return}
//        guard let from = currenciesInButton.titleLabel?.text else {return}
//        presenter.convertIT(Convert(to: to, from: from, amount: amount))
//    }
}

extension MainViewController: MainViewProtocol {
    func succses(_ convert: Convert?) {
        print("cool")
        DispatchQueue.main.async {
            self.outTextField.text = convert?.amount
            self.currenciesOutButton.setTitle(convert?.to, for: .normal)
            self.currenciesInButton.setTitle(convert?.from, for: .normal)
        }
    }
    
    
    func failure() {
        print("fool")
    }
}
//MARK: - LayOut settings
extension MainViewController {
    fileprivate func setUpLayout() {
        
        convButton.addTarget(self, action: #selector(buttonTaped(sender:)), for: .touchUpInside)
//        inTextField.addTarget(self, action: #selector(textDidEndEditing(sender:)), for: .editingChanged)
        let constraints = [
            convButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            convButton.leadingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                constant: 64),
            convButton.trailingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -64),
            convButton.heightAnchor.constraint(equalToConstant: 32),
            // textFields
            outTextField.bottomAnchor.constraint(equalTo: convButton.topAnchor, constant: -42),
            outTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            outTextField.trailingAnchor.constraint(equalTo: currenciesOutButton.leadingAnchor,
                                                            constant: -8),
            outTextField.heightAnchor.constraint(equalToConstant: 30),
            inTextField.bottomAnchor.constraint(equalTo: outTextField.topAnchor, constant: -16),
            inTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            inTextField.trailingAnchor.constraint(equalTo: currenciesInButton.leadingAnchor,
            constant: -8),
            inTextField.heightAnchor.constraint(equalToConstant: 30),
                      
            //button curr
            currenciesOutButton.centerYAnchor.constraint(equalTo: outTextField.centerYAnchor),
            currenciesOutButton.trailingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                       constant: -16),
            currenciesOutButton.widthAnchor.constraint(equalToConstant: 42),
            currenciesInButton.centerYAnchor.constraint(equalTo: inTextField.centerYAnchor),
            currenciesInButton.widthAnchor.constraint(equalToConstant: 42),
            currenciesInButton.trailingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                          constant: -16),
            
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

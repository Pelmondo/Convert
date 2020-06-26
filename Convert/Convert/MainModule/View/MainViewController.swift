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
    lazy var currenciesOutButton = makeCurrUIButton("RUB")
    lazy var currenciesInButton = makeCurrUIButton("USD")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.connectionCheck()
        navigationItem.title = "Convert"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = #colorLiteral(red: 0.3086372316, green: 0.6579651833, blue: 0.7227996588, alpha: 1)
        setUpSettings()
        convButton.isHidden = true
        setUpLayout()
    }
//Если включить кнопку конвертации
//    @objc func buttonTaped(sender: UIButton) {
//
//    }
    @objc func dissmissMyKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func currButtonTapped(sender: UIButton) {
        //костыли, хочу быстрее сделать. поправтиь если будет время!
        let secondVC = ModuleBuilder.createSecondModule() as! SecondViewProtocol
        secondVC.delegate = self
        secondVC.tag = sender.tag
        navigationController?.pushViewController(secondVC as! UIViewController, animated: true)
    }
    
    @objc func textBeginEditing(sender: UITextField) {
        sender.tag == 1 ? (self.inTextField.text = "") : (self.outTextField.text = "")
    }
    
    @objc func textDidEndEditing(sender: UITextField) {
        presenter.connectionCheck()
        if sender.tag == 1 {
            guard let amount = outTextField.text else {return}
            guard let to = currenciesInButton.titleLabel?.text else {return}
            guard let from = currenciesOutButton.titleLabel?.text else {return}
            presenter.convertIT(Convert(to: to, from: from, amount: amount), tag: sender.tag)
            setClear()
        } else {
            guard let amount = inTextField.text else {return}
            guard let to = currenciesOutButton.titleLabel?.text else {return}
            guard let from = currenciesInButton.titleLabel?.text else {return}
            presenter.convertIT(Convert(to: to, from: from, amount: amount), tag: sender.tag)
            setClear()
            }
    }
}

extension MainViewController: MainViewProtocol {
    func succses(_ convert: Convert?, _ tag: Int) {
        if tag == 1 {
            DispatchQueue.main.async {
                self.inTextField.text = convert?.amount
            }
        } else {
            DispatchQueue.main.async {
                self.outTextField.text = convert?.amount
            }
        }
    }
    
    func failure(_ error: Error) {
        print(error)
    }
    
    func notConnection() {
        let alert = UIAlertController(title: nil, message: "Проверьте интернет соединение", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
        }))
        self.present(alert,animated: true, completion: nil)
    }
}
//MARK: - LayOut settings
extension MainViewController {
    fileprivate func setUpSettings() {
        view.addSubview(outTextField)
        view.addSubview(convButton)
        view.addSubview(currenciesOutButton)
        view.addSubview(inTextField)
        view.addSubview(currenciesInButton)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissmissMyKeyboard))
        view.addGestureRecognizer(tap)
//        convButton.addTarget(self, action: #selector(buttonTaped(sender:)), for: .touchUpInside)
        currenciesInButton.tag = 0
        currenciesOutButton.tag = 1
        outTextField.tag = 1
        inTextField.tag = 0
        inTextField.addTarget(self, action: #selector(textDidEndEditing(sender:)), for: .editingChanged)
        outTextField.addTarget(self, action: #selector(textDidEndEditing(sender:)), for: .editingChanged)
        inTextField.addTarget(self, action: #selector(textBeginEditing(sender:)), for: .editingDidBegin)
        outTextField.addTarget(self, action: #selector(textBeginEditing(sender:)), for: .editingDidBegin)
        outTextField.placeholder = "RUB"
        inTextField.placeholder = "USD"
        setClear()
    }
    
    fileprivate func setClear() {
        inTextField.clearsOnBeginEditing = true
        outTextField.clearsOnBeginEditing = true
    }
    
    fileprivate func setUpLayout() {
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

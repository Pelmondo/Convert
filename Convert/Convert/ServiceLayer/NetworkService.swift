//
//  NetworkService.swift
//  Convert
//
//  Created by Сергей Прокопьев on 25.06.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol: class {
    func doConvert(_ it: Convert, complition: @escaping (Result<Convert?, Error>) -> ())
    func getCurrency(complition: @escaping (Result<Currencies?, Error>) -> ())
}

class NetworkService: NetworkServiceProtocol {
    
    func doConvert(_ it: Convert, complition: @escaping (Result<Convert?, Error>) -> ()) {
        let headers = [
            "x-rapidapi-host": "currency-converter5.p.rapidapi.com",
            "x-rapidapi-key": "59afa4a6ebmsh81d36250bd2951dp1c25aejsn41c2c1538fe0"
        ]
        let urlString = "https://currency-converter5.p.rapidapi.com/currency/convert?format=json&from=\(it.from)&to=\(it.to)&amount=\(it.amount)"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                    print(error)
                    return
                }
            guard let data = data else { return }
                do {
                    print(data)
                    let currencies = try JSONDecoder().decode(Money.self, from: data)
                    guard let amount = currencies.rates[it.to]?["rate_for_amount"] else {return}
                    let convert = Convert(to: it.to, from: it.from, amount: amount)
                    complition(.success(convert))
                } catch {
                    print(error.localizedDescription)
                    complition(.failure(error))
                }
            }.resume()
    }

    func getCurrency(complition: @escaping (Result<Currencies?, Error>) -> ()) {
        let headers = [
            "x-rapidapi-host": "currency-converter5.p.rapidapi.com",
            "x-rapidapi-key": "59afa4a6ebmsh81d36250bd2951dp1c25aejsn41c2c1538fe0"
        ]
        let urlString = "https://currency-converter5.p.rapidapi.com/currency/list?format=json"
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                    print(error)
                    return
                }
            guard let data = data else { return }
                do {
                    print(data)
                    let currencies = try JSONDecoder().decode(Currencies.self, from: data)
                    complition(.success(currencies))
                } catch {
                    print(error.localizedDescription)
                    complition(.failure(error))
                }
            }.resume()
        }
}

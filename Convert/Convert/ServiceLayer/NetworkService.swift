//
//  NetworkService.swift
//  Convert
//
//  Created by Сергей Прокопьев on 25.06.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation

class NetworkService {

    class func getCurrency() {
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
                
                do {
                    print(data!)
                    let currencies = try JSONDecoder().decode(Currencies.self, from: data!)
                    print(currencies)
                } catch {
                    print(error.localizedDescription)
                }
            }.resume()
        }
}

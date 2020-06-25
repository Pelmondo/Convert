//
//  Money.swift
//  Convert
//
//  Created by Сергей Прокопьев on 25.06.2020.
//  Copyright © 2020 SergeyProkopyev. All rights reserved.
//

import Foundation

struct Currencies: Decodable {
    let currencies: [String:String]

    init (currencies: [String:String]) {
        self.currencies = currencies
    }
}

struct Money: Decodable {
    let rates: [String: [String:String]]
}

struct Convert {
    let to: String
    let from: String
    let amount: String
}

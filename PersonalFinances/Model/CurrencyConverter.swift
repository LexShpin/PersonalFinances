//
//  CurrencyConverter.swift
//  PersonalFinances
//
//  Created by Alexander Shpin on 12.09.2022.
//

import Foundation

struct CurrencyConverter {
   
    func fetchCurrencyRate(currency: String) {
        let urlString = ""
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        // 1. Create a URL
        // 2. Create a URLSession
        // 3. Give the session a task
        // 4. Start the task
    }

//    func parseJSON(<#data#>: Data) -> <#datatype#> {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(<#Data#>.self, from: <#data#>)
//        } catch {
//            self.delegate?.didFailWithError(error: error)
//            return nil
//        }
//    }
}

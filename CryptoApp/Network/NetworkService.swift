//
//  NetworkService.swift
//  CryptoApp
//
//  Created by Никита Гуляев on 24.02.2022.
//

import Foundation

func cryptoNetwork(completion: @escaping ([CryptoModelElement]) -> Void) {
    let cryptoURL = "https://api.coingecko.com/api/v3/coins/categories/list"
    guard let url = URL(string: cryptoURL) else { return }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data else {
            return
        }
        guard error == nil else {
            return
        }
        
        do {
            let cryptoModel = try JSONDecoder().decode([CryptoModelElement].self, from: data)
            completion(cryptoModel)
        } catch let error {
            print(error)
        }
        
    }.resume()
}


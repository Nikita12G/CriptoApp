//
//  CryptoModel.swift
//  CryptoApp
//
//  Created by Никита Гуляев on 23.02.2022.
//

import Foundation

// MARK: - CryptoModelElement
struct CryptoModelElement: Codable {
    let categoryId: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case name = "name"
    }
}


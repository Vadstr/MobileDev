//
//  ImageModel.swift
//  Lab2
//
//  Created by Vadim on 22.05.2021.
//

import Foundation

struct ImageModel: Codable {
    var id: Int
    var webformatURL: String
}

struct ImageArray: Codable {
    var hits: [ImageModel]
}

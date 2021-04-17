//
//  Book.swift
//  Lab2
//
//  Created by Vadim on 17.04.2021.
//

import UIKit

struct Books: Codable {
    
    let books: [Book]
}

struct Book: Codable {
    
    let title, subtitle, isbn13, price: String
    let image: String
    
    
    var bookImage: UIImage? {
        
        guard !image.isEmpty else {
            
            return UIImage(systemName: "doc.fill.badge.plus")
        }
        return UIImage(named: image) ?? UIImage(systemName: "doc.fill.badge.plus")
    }
}

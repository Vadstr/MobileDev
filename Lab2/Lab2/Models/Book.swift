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
    
    let title, subtitle, isbn13, price, image: String
    let authors, publisher, pages, year, rating, desc: String?
    
    var bookImage: UIImage? {
        
        guard !image.isEmpty else {
            
            return UIImage(systemName: "doc.fill.badge.plus")
        }
        return UIImage(named: image) ?? UIImage(systemName: "doc.fill.badge.plus")
    }
    
    var getFullContent: [(field: String, value: String)]{
        return[
            (field: "Title", value: title),
            (field: "Subtitle", value: subtitle),
            (field: "Authors", value: authors ?? "No infos"),
            (field: "Publisher", value: publisher ?? "No infos"),
            (field: "Isbn13", value: isbn13),
            (field: "Pages", value: pages ?? "No infos"),
            (field: "Year", value: year ?? "No infos"),
            (field: "Rating", value: rating ?? "No infos"),
            (field: "Desc", value: desc ?? "No infos"),
            (field: "Price", value: price)
        ]
    }
}

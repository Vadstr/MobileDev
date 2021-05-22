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
    
    init(title: String, subtitle: String, price: Int) {
        self.title = title
        self.subtitle = subtitle
        self.price = "$\(price)"
        self.authors = nil
        self.publisher = nil
        self.pages = nil
        self.year = nil
        self.rating = nil
        self.desc = nil
        self.image = ""
        self.isbn13 = UUID().uuidString
    }
}

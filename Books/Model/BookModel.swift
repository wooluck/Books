//
//  Book.swift
//  Books
//
//  Created by pineone on 2022/06/21.
//

import Foundation

struct BookModel: Codable {
    let error: String
    let total: String
    let books: [Book]
}

struct Book: Codable {
    var title: String
    let subtitle: String
    let isbn13: String
    let price: String
    let image: String
    let url: String
}




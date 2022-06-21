//
//  Book.swift
//  Books
//
//  Created by pineone on 2022/06/21.
//

import Foundation

struct Book : Codable {
    
    let title : String
    let subtitle : String
    let isbn13 : Int
    let price : String
    let image : String
    let url : String

}

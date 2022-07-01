//
//  BookError.swift
//  Books
//
//  Created by pineone on 2022/07/01.
//

import Foundation

enum BookError: Error {
    case invalidUrl
    case invalidRequest
    case invalidData
    case invalidBookData
    case invalidResponse
    case invalidResponseNum
    case newVCResultFailure
}

//enum WeatherError: Error {
//    case invalidWeatherData
//    
//}

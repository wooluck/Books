//
//  URLSessionExtension.swift
//  Books
//
//  Created by pineone on 2022/06/28.
//

import Foundation
import UIKit
import Alamofire


enum HttpMethod: String {
    case get
    case delete
}

//var newApi = "https://api.itbook.store/1.0/new"

class NetworkManager {
    static let shared = NetworkManager()
    private init() { }
    
    func getBookList<T: Decodable>(apiURL: String, httpMethod: HttpMethod, completion: @escaping (Result<T, BookError>) -> Void) {
        guard let url = URL(string: apiURL) else {
            completion(.failure(.invalidUrl))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            guard let bookData = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.invalidBookData))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            switch response.statusCode {
            case (200...299):
                completion(.success(bookData))
            default:
                completion(.failure(.invalidResponseNum))
            }
        }
        dataTask.resume()
    }
    
    
    
    
    
    
    
    // MARK: NewAPI
//    func getBookList(apiURL: String, httpMethod: HttpMethod, completion: @escaping (Result<[Book], BookError>) -> Void) {
//        guard let url = URL(string: apiURL) else {
//            completion(.failure(.invalidUrl))
//            return
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = httpMethod.rawValue
//        
//        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data else {
//                completion(.failure(.invalidData))
//                return
//            }
//            guard let bookData = try? JSONDecoder().decode(BookModel.self, from: data) else {
//                completion(.failure(.invalidBookData))
//                return
//            }
//            guard let response = response as? HTTPURLResponse else {
//                completion(.failure(.invalidResponse))
//                return
//            }
//            switch response.statusCode {
//            case (200...299):
//                completion(.success(bookData.books))
//            default:
//                completion(.failure(.invalidResponseNum))
//            }
//        }
//        dataTask.resume()
//    }
    
    // MARK: DetailAPI
    func getDetailBookList(apiURL: String, httpMethod: HttpMethod, completion: @escaping(BookDetail) -> Void) {
        guard let url = URL(string: apiURL) else { print("url Error: \(apiURL)"); return }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { print("URLSession data Error"); return }
            guard let bookData = try? JSONDecoder().decode(BookDetail.self, from: data) else {
                print("JSON ERROR : \(data)"); return}
            guard error == nil else { print("error: \(error?.localizedDescription)"); return }
            guard let response = response as? HTTPURLResponse else { print("response Error: \(response)"); return }
            
            if response.statusCode <= 299{
                completion(bookData)
            }
        }
        dataTask.resume()
    }
    
    // MARK: SearchAPI
//    func getSearchBookList(apiURL: String, httpMethod: String = "get", completion: @escaping([Book]) -> Void) {
//        guard let url = URL(string: apiURL) else { print("url Error: \(apiURL)"); return }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod =  httpMethod
//        
//        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data else { print("URLSession data Error"); return }
//            guard let bookData = try? JSONDecoder().decode(BookModel.self, from: data) else {
//                print("JSON ERROR : \(data)"); return }
//            guard error == nil else { print("error: \(error?.localizedDescription)"); return }
//            guard let response = response as? HTTPURLResponse else { print("response Error: \(response)"); return }
//            
//            if response.statusCode <= 299 {
//                completion(bookData.books)
//            }
//        }
//        dataTask.resume()
//        
//    }
}




// MARK: - Example WeatherAPI
//func getWeatherList(apiURL: String, completion: @escaping (Result<WeatherModel, WeatherError>) -> Void) {
//    guard let url = URL(string: apiURL) else {
//        completion(.failure(.invalidWeatherData))
//        return
//    }
//    var request = URLRequest(url: url)
//    request.httpMethod = "GET"
//
//    let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
//        guard let data = data else {
//            completion(.failure(.invalidWeatherData))
//            return
//        }
//
//        guard let weatherData = try? JSONDecoder().decode(WeatherModel.self, from: data) else {
//            completion(.failure(.invalidWeatherData))
//            return
//        }
//
//        guard let response = response as? HTTPURLResponse else {
//            completion(.failure(.invalidWeatherData))
//            return
//        }
//
//        switch response.statusCode {
//        case (200...299):
//            completion(.success(weatherData))
//        default:
//            completion(.failure(.invalidWeatherData))
//        }
//    }
//    dataTask.resume()
//}

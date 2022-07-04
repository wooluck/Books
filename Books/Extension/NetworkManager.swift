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
    
    
    
    
    var book : Book? // Book?
    
//    func getBookList(apiURL: String) async throws -> [Book] {
//        let url = URL(string: apiURL)
//
//        // 기본 GET 방식
//        var request = URLRequest(url: url!)
//
//        let (data, response) = try await URLSession.shared.data(for: request)
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw BookError.invalidResponse}
//
//        let bookData = try JSONDecoder().decode(T.self, from: data)
//
//        return bookData
//    }
    
    
    // 기존코드(안될시 복구)
//    func getBookList<T: Decodable>(apiURL: String, httpMethod: HttpMethod, completion: @escaping (Result<T, BookError>) -> Void) {
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
//            guard let bookData = try? JSONDecoder().decode(T.self, from: data) else {
//                completion(.failure(.invalidBookData))
//                return
//            }
//            guard let response = response as? HTTPURLResponse else {
//                completion(.failure(.invalidResponse))
//                return
//            }
//            switch response.statusCode {
//            case (200...299):
//                completion(.success(bookData))
//            default:
//                completion(.failure(.invalidResponseNum))
//            }
//        }
//        dataTask.resume()
//    }
    
    
    
    
    // New
    func loadBook() async throws -> [Book] {
        let books: [Book] = try await withCheckedThrowingContinuation({ continuation in
            
            getBookList(apiURL: "https://api.itbook.store/1.0/new", httpMethod: .get) { result in
                switch result  {
                case .success(let data):
                    continuation.resume(returning: data)
//                    print("이거봐 : \(data)")
                    
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
        return books
    }
    
    // Detail
    // 파라미터 값으로 넘겨줘야함 .
    func loadDetailBook(isbn13: String) async throws -> BookDetail {
        
        
//        let search = await vc.prepareBook?.isbn13 ?? "없다잉"
        
        let books: BookDetail = try await withCheckedThrowingContinuation({ continuation in
            getDetailBookList(apiURL: "https://api.itbook.store/1.0/books/" + isbn13, httpMethod: .get) { result in
                print("dfdsfsdfsdf : \(isbn13)")
                switch result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
        return books
    }
    
//    func loadSearchBook() async throws ->
    
    
    
    
    // MARK: NewAPI
    func getBookList(apiURL: String, httpMethod: HttpMethod, completion: @escaping (Result<[Book], BookError>) -> Void) {
        guard let url = URL(string: apiURL) else {
            print("url Error : \(apiURL)")
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
            guard let bookData = try? JSONDecoder().decode(BookModel.self, from: data) else {
                completion(.failure(.invalidBookData))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            switch response.statusCode {
            case (200...299):
                completion(.success(bookData.books))
            default:
                completion(.failure(.invalidResponseNum))
            }
        }
        dataTask.resume()
    }
    
    
    // MARK: DetailAPI
    
    func getDetailBookList(apiURL: String, httpMethod: HttpMethod, completion: @escaping (Result<BookDetail, BookError>) -> Void) {
        guard let url = URL(string: apiURL) else {
            print("url Error: \(apiURL)")
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
            guard let bookData = try? JSONDecoder().decode(BookDetail.self, from: data) else {
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
    
    // 기존코드
//    func getDetailBookList(apiURL: String, httpMethod: HttpMethod, completion: @escaping(BookDetail) -> Void) {
//        guard let url = URL(string: apiURL) else { print("url Error: \(apiURL)"); return }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = httpMethod.rawValue
//
//        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data else { print("URLSession data Error"); return }
//            guard let bookData = try? JSONDecoder().decode(BookDetail.self, from: data) else {
//                print("JSON ERROR : \(data)"); return}
//            guard error == nil else { print("error: \(error?.localizedDescription)"); return }
//            guard let response = response as? HTTPURLResponse else { print("response Error: \(response)"); return }
//
//            if response.statusCode <= 299{
//                completion(bookData)
//            }
//        }
//        dataTask.resume()
//    }
    
    // MARK: SearchAPI
    func getSearchBookList(apiURL: String, httpMethod: String = "get", completion: @escaping([Book]) -> Void) {
        guard let url = URL(string: apiURL) else { print("url Error: \(apiURL)"); return }
        
        var request = URLRequest(url: url)
        request.httpMethod =  httpMethod
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { print("URLSession data Error"); return }
            guard let bookData = try? JSONDecoder().decode(BookModel.self, from: data) else {
                print("JSON ERROR : \(data)"); return }
            guard error == nil else { print("error: \(error?.localizedDescription)"); return }
            guard let response = response as? HTTPURLResponse else { print("response Error: \(response)"); return }
            
            if response.statusCode <= 299 {
                completion(bookData.books)
            }
        }
        dataTask.resume()
        
    }
    
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

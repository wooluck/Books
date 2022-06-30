//
//  URLSessionExtension.swift
//  Books
//
//  Created by pineone on 2022/06/28.
//

import Foundation
import UIKit
import Alamofire
import SwiftUI

enum HttpMethod: String{
    case get = "GET"
}

class NetworkManager{
    static let shared = NetworkManager()
    private init() { }
    
    func getBookList(apiURL: String, httpMethod: HttpMethod, completion: @escaping([Book]) -> Void) {
        guard let url = URL(string: apiURL) else { print("url Error: \(apiURL)"); return }

        var request = URLRequest(url: url)
        request.httpMethod = "\(httpMethod)"

        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { print("URLSession data Error"); return }
            guard let bookData = try? JSONDecoder().decode(BookModel.self, from: data) else {
                print("JSON ERROR : \(data)"); return}
            guard error == nil else { print("error: \(error?.localizedDescription)"); return }
            guard let response = response as? HTTPURLResponse else { print("response Error: \(response)"); return }
            
            if response.statusCode <= 299{
                completion(bookData.books)
            }
        }
        dataTask.resume()
    }
    
    
    func getDetailBookList(apiURL: String, httpMethod: HttpMethod, completion: @escaping(BookDetail) -> Void) {
        guard let url = URL(string: apiURL) else { print("url Error: \(apiURL)"); return }

        var request = URLRequest(url: url)
        request.httpMethod = "\(httpMethod)"

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
    
    func getSearchBookList(apiURL: String, httpMethod: HttpMethod, completion: @escaping() -> Void) {
        guard let url = URL(string: apiURL) else { print("url Error: \(apiURL)"); return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "\(httpMethod)"
        
//        let dataTast = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data else { print("URLSession data Error"); return }
//            guard let
//        }
        
    }
    
    
    
    
    
    
    
//    func fetchBook(apiURL: String, httpMethod: HttpMethod, completionHandler: (([Book]) -> Void)?) {
//        guard let url = URL(string: apiURL) else { return }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "\(httpMethod)"
//
//        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
//            guard error == nil,
//                  let self = self,
//                  let response = response as? HTTPURLResponse,
//                  let data = data,
//                  let bookData = try? JSONDecoder().decode(BookModel.self, from: data) else {
//                      print("ERROR : \(error?.localizedDescription)")
//                      return
//                  }
//            if response.statusCode <= 299{
//                completionHandler!(bookData.books)
//                DispatchQueue.main.async {
////                    self.bookTableView.reloadData()
//                }
//            }
//        }
//        dataTask.resume()
//    }
    
    
    
    
    
//    func fetchBook(apiURL: String, httpMethod: HttpMethod) -> [Book] {
//
//        var result: [Book] = []
//
//        guard let url = URL(string: apiURL) else { return [] }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "\(httpMethod)"
//
//        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
//            guard error == nil,
//                  let self = self,
//                  let response = response as? HTTPURLResponse,
//                  let data = data,
//                  let bookData = try? JSONDecoder().decode(BookModel.self, from: data)
//            else {
//                print("ERROR : \(error?.localizedDescription)")
//                return
//            }
//            if response.statusCode <= 299{
//
//                DispatchQueue.main.async {
//                    result = bookData.books
////                    self.bookTableView.reloadData()
//                }
//            }
//        }
//        dataTask.resume()
//        print("Result: \(result)")
//        return result
//    }
}

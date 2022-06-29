//
//  URLSessionExtension.swift
//  Books
//
//  Created by pineone on 2022/06/28.
//

import Foundation
import UIKit
import Alamofire

enum HttpMethod: String{
    case get = "GET"
}

class UrlSessionCode{
    static let urlSessionShared = UrlSessionCode()

    var apiUrl: String?
    var httpMethod: HttpMethod?
    
    var newVc = NewViewController()
    
    private init() { }
    
    func fetchBook(apiURL: String, httpMethod: HttpMethod, completion: @escaping([Book]) -> Void) {
        guard let url = URL(string: apiURL) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "\(httpMethod)"

        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil,

                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let bookData = try? JSONDecoder().decode(BookModel.self, from: data) else {
                      print("ERROR : \(error?.localizedDescription)")
                      
                      return
                  }
            
            
            
            
            if response.statusCode <= 299{
                completion(bookData.books)
            }
        }
        dataTask.resume()
    }
    
//    func fetchBook(apiURL: String, httpMethod: HttpMethod) async throws -> [Book] {
//        guard let url = URL(string: apiURL) else { return []}
//
//        var request = URLRequest(url: url)
//        let (data, response) = try await URLSession.shared.data(for: request)
//        (response as? HTTPURLResponse)?.statusCode == 200
//        let bookData =
//
//        return
//    }
    
    
    func fetchBook(apiURL: String, httpMethod: HttpMethod, completionHandler: (([Book]) -> Void)?) {
        guard let url = URL(string: apiURL) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "\(httpMethod)"

        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let bookData = try? JSONDecoder().decode(BookModel.self, from: data) else {
                      print("ERROR : \(error?.localizedDescription)")
                      return
                  }
            if response.statusCode <= 299{
                completionHandler!(bookData.books)
                DispatchQueue.main.async {
//                    self.bookTableView.reloadData()
                }
            }
        }
        dataTask.resume()
    }
    
    func fetchBook(apiURL: String, httpMethod: HttpMethod) -> [Book] {
        
        var result: [Book] = []
        
        guard let url = URL(string: apiURL) else { return [] }

        var request = URLRequest(url: url)
        request.httpMethod = "\(httpMethod)"

        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let bookData = try? JSONDecoder().decode(BookModel.self, from: data)
            else {
                print("ERROR : \(error?.localizedDescription)")
                return
            }
            if response.statusCode <= 299{
                
                DispatchQueue.main.async {
                    result = bookData.books
//                    self.bookTableView.reloadData()
                }
            }
        }
        dataTask.resume()
        print("Result: \(result)")
        return result
    }
}

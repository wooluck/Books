//
//  NewViewController.swift
//  Books
//
//  Created by pineone on 2022/06/21.
//

import UIKit

class NewViewController : UIViewController {
    
    /// 책 모델 배열
    var bookList = [Book]()
    var dataTasks = [URLSessionTask]()
    
    @IBOutlet weak var bookTableView: UITableView!
    
    
    let dummy: [Book] = [
        Book(title: "123", subtitle: "123", isbn13: "123", price: "123", image: "123", url: "123")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "New Books"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        bookTableView.delegate = self
        bookTableView.dataSource = self
//        bookTableView.register(NewTableViewCell.self, forCellReuseIdentifier: "NewCell")
        
        fetchBook()
        
        
    }
}

/*
 
 */
// MARK: - Extension

extension NewViewController {
    func fetchBook() {
        guard let url = URL(string: "https://api.itbook.store/1.0/new") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let book = try? JSONDecoder().decode(BookModel.self, from: data) else {
                      print("ERROR : \(error?.localizedDescription)")
                      return
                  }
            switch response.statusCode {
            case (200...299):
                
                
                print("Success: \(response.statusCode)")
        
                
                self.bookList = book.books
//
                DispatchQueue.main.async {
                    self.bookTableView.reloadData()
                }
            case (400...499):
                print(
                    """
                    ERROR: Client ERROR \(response.statusCode)
                    Response: \(response)
                    """
                )
            case (500...599):
                print(
                    """
                    ERROR: Server ERROR \(response.statusCode)
                    Response: \(response)
                    """
                )
            default:
                print(
                    """
                    ERROR: \(response.statusCode)
                    Response: \(response)
                    """
                )
            }
        }
        dataTask.resume()
        dataTasks.append(dataTask)
    }
}

extension NewViewController : UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    

}

extension NewViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
//        return dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewCell", for: indexPath) as? NewTableViewCell else { return UITableViewCell() }
        
        let book = bookList[indexPath.row]
        
//        cell.configureView(with: dummy[0])
        cell.configureView(with: book)
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedBook = bookList[indexPath.row]
//        let newDetailViewController = NewDetailViewController()
//
//        newDetailViewController.book = selectedBook
//        self.show(newDetailViewController, sender: nil)
//    }
}




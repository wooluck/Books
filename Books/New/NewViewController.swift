//
//  NewViewController.swift
//  Books
//
//  Created by pineone on 2022/06/21.
//

import UIKit

class NewViewController : UIViewController {
    
    var bookList = [BookModel]()
    
    @IBOutlet weak var bookTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "New Books"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        bookTableView.delegate = self
        bookTableView.dataSource = self
        bookTableView.register(NewTableViewCell.self, forCellReuseIdentifier: "NewCell")
        
    }
}

extension NewViewController {
    func fetchBook() {
        guard let url = URL(string: "https://api.itbook.store/1.0/new") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let reponse = response as? HTTPURLResponse,
                  let data = data,
                  let book = try? JSONDecoder().decode([BookModel].self, from: data) else {
                      print("ERROR : URLSession")
                      return
                  }
            
            
        }
    }
}

extension NewViewController : UITableViewDelegate {
    
}

extension NewViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewCell", for: indexPath) as? NewTableViewCell else { return UITableViewCell() }
        
        let book = bookList[indexPath.row]
        cell.configureView(with: book)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = bookList[indexPath.row]
        let newDetailViewController = NewDetailViewController()
        
        newDetailViewController.book = selectedBook
        self.show(newDetailViewController, sender: nil)
    }
}




//
//  NewViewController.swift
//  Books
//
//  Created by pineone on 2022/06/21.
//

import UIKit

class NewViewController : ViewController {
    
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




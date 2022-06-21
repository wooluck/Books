//
//  NewViewController.swift
//  Books
//
//  Created by pineone on 2022/06/21.
//

import UIKit

class NewViewController : ViewController {
    
    @IBOutlet weak var bookImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "New Books"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        
    }
    
    func configureView(book: Book) {

        guard let url = URL(string: "https://api.itbook.store/1.0/new") else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { [weak self] data, response, error in
            let successRange = (200..<300)
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                guard let book = try? decoder.decode(Book.self, from: data) else { return }
                DispatchQueue.main.async {
                    self?.configureView(book: book)
                }
            } else {
                return
            }
        }
        // 이미지
//        self.bookImage. = book.image

//        self.bookTitle.text = book.title
//        self.bookSubTitle.text = book.subtitle
//        self.bookIsbn13.text = "\(Int(book.isbn13))"
//        self.bookPrice.text = book.price
    }

    func clickLinkButton() {

    }
}




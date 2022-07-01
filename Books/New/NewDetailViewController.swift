//
//  NewDetailViewController.swift
//  Books
//
//  Created by pineone on 2022/06/21.
//

import UIKit
import Kingfisher

class NewDetailViewController: UIViewController {
    
    var prepareBook: Book?
    var detailBook: BookDetail?
    
    @IBOutlet weak var bookDetailImage: UIImageView!
    @IBOutlet weak var bookDetailTitle: UILabel!
    @IBOutlet weak var bookDetailSubTitle: UILabel!
    @IBOutlet weak var bookDetailIsbn13: UILabel!
    @IBOutlet weak var bookDetailPrice: UILabel!
    @IBOutlet weak var bookDetailLinkButton: UIButton!
    @IBOutlet weak var bookDetailTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationSetting()
        textView()
        
        // MARK: - URLSession
        if let isbn = prepareBook?.isbn13 {
            let myurl = "https://api.itbook.store/1.0/books/" + isbn
            print("myurl: \(myurl)")
            // <MyModel,Error> BookModel
            NetworkManager.shared.getBookList(apiURL: myurl, httpMethod: .get) { [weak self] (result : Result<BookDetail,BookError>) in
                guard let `self` = self else { return }
                
                switch result {
                case .success(let book):
                    self.detailBook = book
                    DispatchQueue.main.sync {
                        let imageURL = URL(string: self.detailBook?.image ?? "nil")
                        self.bookDetailImage.load(url: imageURL!)
                        self.bookDetailTitle.text = self.detailBook?.title
                        self.bookDetailSubTitle.text = self.detailBook?.subtitle
                        self.bookDetailIsbn13.text = self.detailBook?.isbn13
                        self.bookDetailPrice.text = self.detailBook?.price
                        self.bookDetailLinkButton.setTitle(self.detailBook?.url, for: .normal)
                    }
                case .failure(let error):
                    print("\(error)")
                }
            }
            
            
            
            
//            NetworkManager.shared.getDetailBookList(apiURL: myurl, httpMethod: .get) { data in
//                print("data: \(data)")
//                self.detailBook = data
//                DispatchQueue.main.sync {
//                    let imageURL = URL(string: self.detailBook?.image ?? "nil")
//                    self.bookDetailImage.load(url: imageURL!)
//                    self.bookDetailTitle.text = self.detailBook?.title
//                    self.bookDetailSubTitle.text = self.detailBook?.subtitle
//                    self.bookDetailIsbn13.text = self.detailBook?.isbn13
//                    self.bookDetailPrice.text = self.detailBook?.price
//                    self.bookDetailLinkButton.setTitle(self.detailBook?.url, for: .normal)
//                }
//            }
            
            
        } else {
            print("isbn13 is Error")
        }
    }
    
    // MARK: Functions
    /// navigationItem
    private func navigationSetting() {
        self.navigationItem.title = "Detail Book"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    /// layer 관련 코드
     func textView() {
        bookDetailTextView.layer.borderWidth = 1.0
        bookDetailTextView.layer.borderColor = UIColor.systemGray5.cgColor
        bookDetailTextView.layer.cornerRadius = 7
        bookDetailTextView.delegate = self
         self.bookDetailTextView.text = "내용을 입력하세요"
    }
}

// MARK: - Extenstions

extension NewDetailViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray{
            textView.text = "내용을 입력하세요"
            textView.textColor = UIColor.lightGray
        } else {
        textView.text = ""
        textView.textColor = UIColor.darkGray
    }
}
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count == 0 {
            textView.text = "내용을 입력하세요"
            textView.textColor = UIColor.lightGray
        } else {
            textView.textColor = UIColor.darkGray
        }
    }
}

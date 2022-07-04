//
//  NewDetailViewController.swift
//  Books
//
//  Created by pineone on 2022/06/21.
//

import UIKit
import Kingfisher

class NewDetailViewController: UIViewController {
    
    var prepareBook: Book? {
        didSet {
            print(prepareBook)            
        }
    }
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
        
        
        Task {
            do {
                let books = try await NetworkManager.shared.loadDetailBook(isbn13: prepareBook?.isbn13 ?? "isbn nil")
                
                self.detailBook = books
                
                DispatchQueue.main.async {
                    let imageURL = URL(string: self.detailBook?.image ?? "nil")
                    self.bookDetailImage.load(url: imageURL!)
                    self.bookDetailTitle.text = self.detailBook?.title
                    self.bookDetailSubTitle.text = self.detailBook?.subtitle
                    self.bookDetailIsbn13.text = self.detailBook?.isbn13
                    self.bookDetailPrice.text = self.detailBook?.price
                    self.bookDetailLinkButton.setTitle(self.detailBook?.url, for: .normal)
                }
            }catch {
                print("Response Error: \(error) @@ \(error.localizedDescription)")
            }
        }

    }
        
        // MARK: - URLSession

    
    
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

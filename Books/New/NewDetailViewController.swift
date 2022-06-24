//
//  NewDetailViewController.swift
//  Books
//
//  Created by pineone on 2022/06/21.
//

import UIKit
import Kingfisher



class NewDetailViewController: UIViewController {
    
    var book = [Book]()
    
    var prepareImage: String?
    var prepareTitle: String?
    var prepareSubTitle: String?
    var prepareIsbn13: String?
    var preparePrice: String?
    var prepareLink: String?
    
    
    
    // 이렇게 셀자체를 가져올수가 있는지
    let newTableViewCell = NewTableViewCell()
    
    @IBOutlet weak var bookDetailImage: UIImageView!
    @IBOutlet weak var bookDetailTitle: UILabel!
    @IBOutlet weak var bookDetailSubTitle: UILabel!
    @IBOutlet weak var bookDetailIsbn13: UILabel!
    @IBOutlet weak var bookDetailPrice: UILabel!
    @IBOutlet weak var bookDetailLinkButton: UIButton!
    @IBOutlet weak var bookDetailTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("NewDetailViewController - viewDidLoad - called")
        
        self.navigationItem.title = "Detail Book"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.tabBarController?.tabBar.isHidden = true
        
        bookDetailTextView.layer.borderWidth = 1.0
        bookDetailTextView.layer.borderColor = UIColor.systemGray5.cgColor
        bookDetailTextView.layer.cornerRadius = 7
        
        bookDetailTitle.text = prepareTitle ?? "NoTitle"
        bookDetailSubTitle.text = prepareSubTitle ?? "NoSubTitle"
        bookDetailIsbn13.text = prepareIsbn13 ?? "NoIsbn13"
        bookDetailPrice.text = preparePrice ?? "NoPrice"
        print("prepareImage - \(prepareImage)")
        let imageURL = URL(string: prepareImage ?? "NoImage")
        bookDetailImage.kf.setImage(with: imageURL)
        bookDetailLinkButton.setTitle(prepareLink, for: .normal)
        
        bookDetailTextView.delegate = self
        
        
        
        
        
        
//        let imageURL = URL(string: book.books.image)
//        bookDetailImage.kf.setImage(with: imageURL)
//        bookDetailTitle.text = book.title
//        bookDetailSubTitle.text = book.subtitle
//        bookDetailIsbn13.text = book.isbn13
//        bookDetailPrice.text = book.price
    }
    
    // MARK: 뷰 생명주기
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("NewDetailViewController - viewWillAppear - called")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("NewDetailViewController - viewDidAppear - called")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("NewDetailViewController - viewWillDisappear - called")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("NewDetailViewController - viewDidDisappear - called")
        
    }
}

// MARK: Extension
extension NewDetailViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
}

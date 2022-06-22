//
//  NewDetailViewController.swift
//  Books
//
//  Created by pineone on 2022/06/21.
//

import UIKit
import Kingfisher

class NewDetailViewController : UIViewController {
    
    var book: BookModel!
    
    // 이렇게 셀자체를 가져올수가 있는지
    var newTableViewCell = NewTableViewCell()
    
    @IBOutlet weak var bookDetailImage: UIImageView!
    @IBOutlet weak var bookDetailTitle: UILabel!
    @IBOutlet weak var bookDetailSubTitle: UILabel!
    @IBOutlet weak var bookDetailIsbn13: UILabel!
    @IBOutlet weak var bookDetailPrice: UILabel!
    @IBOutlet weak var bookDetailLinkButton: UIButton!
    @IBOutlet weak var bookDetailTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Detail Book"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
//        let imageURL = URL(string: book.image)
//        bookDetailImage.kf.setImage(with: imageURL)
//        bookDetailTitle.text = book.title
//        bookDetailSubTitle.text = book.subtitle
//        bookDetailIsbn13.text = "\(book.isbn13)"
//        bookDetailPrice.text = book.price
    }
    
    
}

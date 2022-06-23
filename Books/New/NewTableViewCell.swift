//
//  NewTableViewCell.swift
//  Books
//
//  Created by pineone on 2022/06/21.
//

import UIKit
import Kingfisher

class NewTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookSubTitle: UILabel!
    @IBOutlet weak var bookIsbn13: UILabel!
    @IBOutlet weak var bookPrice: UILabel!
    
    
    @IBAction func bookLinkButton(_ sender: UIButton) {
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // 테이블 뷰 셀 사이의 간격
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 14, right: 0))
        
        // 그림자, 셀 둥글게
        layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.5
            layer.shadowRadius = 20
            contentView.layer.cornerRadius = 20
            contentView.layer.masksToBounds = true

    }
    
    func configureView(with bookModel: Book) {

        let imageURL = URL(string: bookModel.image )
        bookImage.kf.setImage(with: imageURL)
        bookTitle.text = bookModel.title
        bookSubTitle.text = bookModel.subtitle
        bookIsbn13.text = bookModel.isbn13
        bookPrice.text = bookModel.price
        
        selectionStyle = .none
    }
    
//    func getURLBookData() {
//
//        guard let url = URL(string: "https://api.itbook.store/1.0/new") else { return }
//
//        // 네트워킹 시작
//        let session = URLSession(configuration: .default)
//
//        session.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else { return }
//
//            // Json타입의 데이터를 디코딩
//            let decoder = JSONDecoder()
//            let bookResponse = try? decoder.decode(BookModel.self, from: data)
//            self.books = BookModel.
//
//            guard let book = try? decoder.decode(BookModel.self, from: data) else { return }
//            DispatchQueue.main.async {
//                self.configureView(bookModel: book)
//            }
//
//
//        }
//
//
//    }



}

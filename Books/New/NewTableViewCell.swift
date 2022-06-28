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

        // TODO: 사파리 어플 켜서 홈페이지 띄우기
//        guard let url = URL(string: "www.naver.com"), UIApplication.shared.canOpenURL(url) else { return }
//        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewSizeAndLayer()
    }
    
    // MARK: - Functions
    
    /// 테이블 뷰 셀 사이의 간격, 그림자, 셀 둥글게
    func viewSizeAndLayer() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 14, right: 0))
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 20
        contentView.layer.cornerRadius = 30
        contentView.layer.masksToBounds = true
    }
    
    /// 가져온 데이터 mapping
    func configureView(with bookModel: Book) {

//        let imageURL = URL(string: bookModel.image)
        if let url = URL(string: bookModel.image) {
            bookImage.kf.setImage(with: url)
        } else {
            print("Image URL Not Failed")
        }
       
        bookTitle.text = bookModel.title
        bookSubTitle.text = bookModel.subtitle
        bookIsbn13.text = bookModel.isbn13
        bookPrice.text = bookModel.price
        
        selectionStyle = .none
    }
}

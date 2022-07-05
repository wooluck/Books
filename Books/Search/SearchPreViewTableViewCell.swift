//
//  SearchPreViewTableViewCell.swift
//  Books
//
//  Created by pineone on 2022/07/04.
//

import UIKit
import Kingfisher

class SearchPreViewTableViewCell: UITableViewCell {
    
    var preparebook: Book?

    @IBOutlet weak var searchPreBookImage: UIImageView!
    @IBOutlet weak var searchPreBookTitle: UILabel!
    @IBOutlet weak var searchPreBookSubTitle: UILabel!
    @IBOutlet weak var searchPreBookIsbn13: UILabel!
    @IBOutlet weak var searchPreBookPrice: UILabel!
    @IBOutlet weak var searchPreBookLinkButton: UIButton!
    
    
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


        if let url = URL(string: bookModel.image) {
            searchPreBookImage.load(url: url)
            let imageData = try! Data(contentsOf: url)
            searchPreBookImage.image = UIImage(data: imageData)
        } else {
            print("Image URL Not Failed")
        }
       
        searchPreBookTitle.text = bookModel.title
        searchPreBookSubTitle.text = bookModel.subtitle
        searchPreBookIsbn13.text = bookModel.isbn13
        searchPreBookPrice.text = bookModel.price
        
        selectionStyle = .none
    }
}

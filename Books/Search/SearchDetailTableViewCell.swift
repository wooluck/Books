//
//  NewDetailTableViewCell.swift
//  Books
//
//  Created by luck woo on 2022/06/26.
//

import UIKit
import Kingfisher

class SearchDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var searchBookImage: UIImageView!
    @IBOutlet weak var searchBookTitle: UILabel!
    @IBOutlet weak var searchBookSubTitle: UILabel!
    @IBOutlet weak var searchBookIsbn13: UILabel!
    @IBOutlet weak var searchBookPrice: UILabel!
    @IBOutlet weak var searchBookLinkButton: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        
    }
    
    // 가져온 데이터 넣기
    func configureView(with bookModel: Book) {

        let imageURL = URL(string: bookModel.image )
        searchBookImage.kf.setImage(with: imageURL)
        searchBookTitle.text = bookModel.title
        searchBookSubTitle.text = bookModel.subtitle
        searchBookIsbn13.text = bookModel.isbn13
        searchBookPrice.text = bookModel.price
        searchBookLinkButton.text = bookModel.url
        selectionStyle = .none
    }

    
}

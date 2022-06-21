//
//  NewTableViewCell.swift
//  Books
//
//  Created by pineone on 2022/06/21.
//

import UIKit

class NewTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookSubTitle: UILabel!
    @IBOutlet weak var bookIsbn13: UILabel!
    @IBOutlet weak var bookPrice: UILabel!
    
    
    @IBAction func bookLinkButton(_ sender: UIButton) {
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.getURLBookData()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView(bookModel: BookModel) {
        // 이미지도 넣어야됨
        self.bookTitle.text = bookModel.title
        self.bookSubTitle.text = bookModel.subtitle
        self.bookIsbn13.text = "\(Int(bookModel.isbn13))"
        self.bookPrice.text = bookModel.price
        
    }
    
    func getURLBookData() {

        guard let url = URL(string: "https://api.itbook.store/1.0/new") else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            let decoder = JSONDecoder()
            
            guard let book = try? decoder.decode(BookModel.self, from: data) else { return }
            DispatchQueue.main.async {
                self.configureView(bookModel: book)
            }
            
            
        }
       
        
    }



}

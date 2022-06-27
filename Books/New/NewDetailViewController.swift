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
        textViewLayer()
        dataGet()
        
    }
    
    // MARK: Functions
    /// navigation, tabbar
    func navigationSetting() {
        self.navigationItem.title = "Detail Book"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    /// layer 관련 코드
    func textViewLayer() {
        bookDetailTextView.layer.borderWidth = 1.0
        bookDetailTextView.layer.borderColor = UIColor.systemGray5.cgColor
        bookDetailTextView.layer.cornerRadius = 7
    }
    
    
    func dataGet() {
        let imageURL = URL(string: prepareImage ?? "NoImage")
        bookDetailImage.kf.setImage(with: imageURL)
        bookDetailTitle.text = prepareTitle ?? "NoTitle"
        bookDetailSubTitle.text = prepareSubTitle ?? "NoSubTitle"
        bookDetailIsbn13.text = prepareIsbn13 ?? "NoIsbn13"
        bookDetailPrice.text = preparePrice ?? "NoPrice"
        bookDetailLinkButton.setTitle(prepareLink, for: .normal)
    }
}

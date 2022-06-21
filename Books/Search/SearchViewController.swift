//
//  SearchViewController.swift
//  Books
//
//  Created by pineone on 2022/06/21.
//

import UIKit

class SearchViewController : ViewController {
    
    let serachController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Search Books"

        self.navigationItem.searchController = serachController
    }
}

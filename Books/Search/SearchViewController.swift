//
//  SearchViewController.swift
//  Books
//
//  Created by pineone on 2022/06/21.
//

import UIKit

class SearchViewController : UIViewController {
    
    let searchController = UISearchController()
    
    @IBOutlet weak var searchTableView: UITableView!
    
    
    let data = [Book]()
    var filteredData: [Any]!
    
    @IBOutlet weak var searchTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Search Books"

        self.navigationItem.searchController = searchController
    }
}


// MARK: Extension

extension SearchViewController: UITableViewDelegate {
    
    
}

//extension SearchViewController: UITableViewDataSource {
//    
//    
//    
//}

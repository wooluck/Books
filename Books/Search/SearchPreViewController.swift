//
//  SearchPreViewController.swift
//  Books
//
//  Created by pineone on 2022/07/01.
//

import Foundation
import Alamofire
import Kingfisher
import UIKit

class SearchPreViewController: UIViewController, UISearchControllerDelegate  {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController
        searchController.delegate = self
    }
    
}



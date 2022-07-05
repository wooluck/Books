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

class SearchPreViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    var bookList = [Book]()
    var filteredData = [Book]()
    var searchBarWord = ""
    
    var newApi = "https://api.itbook.store/1.0/new"
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var searchBookTableView: UITableView!
    
    /// SearchBar 활성화 여부, Text 입력 여부
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    @IBOutlet weak var noBookList: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        
        navigationAndTableViewSet()
        
        
        Task {
            do {
                let books = try await NetworkManager.shared.loadSearchBook(query: searchBarWord)
                
                self.bookList = books
                
                DispatchQueue.main.async {
                    self.searchBookTableView.reloadData()
                }
            }catch {
                print("Response Error: \(error) @@ \(error.localizedDescription)")
            }
        }
        
    }
    
    // MARK: - Functions
    
    /// navigation 설정, tableview 프로토콜 설정
    func navigationAndTableViewSet() {
        self.navigationItem.title = "New Books"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchBar.placeholder = "검색어를 입력해보세요."
        //        searchController.searchResultsUpdater = self
        noBookList.isHidden = true
        
        searchBookTableView.delegate = self
        searchBookTableView.dataSource = self
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewDetailViewController {
            if let index = sender as? Int {
                vc.prepareBook = bookList[index]
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        self.searchBarWord = text
        print("text = \(text)")
        
        Task {
            do {
                let books = try await NetworkManager.shared.loadSearchBook(query: searchBarWord)
                
                self.bookList = books
                
                DispatchQueue.main.async {
                    self.searchBookTableView.reloadData()
                }
            }catch {
                print("Response Error: \(error) @@ \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Extension

extension SearchPreViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PrePass", sender: indexPath.row)
        
    }
}

extension SearchPreViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return self.isFiltering ? self.filteredData.count : self.bookList.count
        return self.bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchPreCell", for: indexPath) as? SearchPreViewTableViewCell else { return UITableViewCell() }
        
        //        if self.isFiltering {
        //            if filteredData.count != 0 {
        //                cell.configureView(with: filteredData[indexPath.row])
        //                self.noBookList.isHidden = true
        //            }
        //        } else {
        cell.configureView(with: bookList[indexPath.row])
        self.noBookList.isHidden = true
        //        }
        return cell
    }
    
}





//extension SearchPreViewController: UISearchResultsUpdating {
//
//    func updateSearchResults(for searchController: UISearchController) {
//        /// searchbar에 입력한 텍스트
//        guard let text = searchController.searchBar.text else { return }
//        self.searchBarWord = text
//        self.filteredData = self.bookList.filter { $0.title.localizedCaseInsensitiveContains(text)}
//        self.noBookList.isHidden = filteredData.isEmpty ? false : true
//        self.searchBookTableView.reloadData()
//
////        print("text: \(text)")
//
//    }
//}

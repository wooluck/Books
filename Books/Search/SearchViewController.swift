//
//  SearchViewController.swift
//  Books
//
//  Created by pineone on 2022/06/21.
//

import UIKit
import Alamofire
import Kingfisher

class SearchViewController : UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UITableView!
    var bookList = [Book]()
    var filteredData = [Book]()
    var searchBarWord = ""
    
    fileprivate var newApi = "https://api.itbook.store/1.0/new"
    
    /// SearchBar 활성화 여부, Text 입력 여부
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var noSearch: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviagationSetting()
        searchBarAndTableViewSetting()
        
        NetworkManager.shared.getBookList(apiURL: newApi, httpMethod: .get) { (result :Result<BookModel, BookError>) in
            switch result {
            case .success(let data):
                self.bookList = data.books
                DispatchQueue.main.sync {
                    self.searchTableView.reloadData()
                }
            case .failure:
                print("NetworkManager - error ")
            }
        }
        
//        searchBar.delegate = self
        
    }
    
    // MARK: - Functions
    /// navigationItem 관련 소스
    func naviagationSetting() {
        self.navigationItem.title = "Search Books"
//        self.navigationItem.searchController = searchController
    }
    
    /// searchbar, tableview 프로토콜, 검색결과x Label
    func searchBarAndTableViewSetting() {
//        searchController.searchBar.placeholder = "검색어를 입력해보세요."
//        searchController.searchResultsUpdater = self
        searchTableView.dataSource = self
        searchTableView.delegate = self
        noSearch.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewDetailViewController {
            if let index = sender as? Int {
                vc.prepareBook = bookList[index]
            }
        }
    }
    
}


// MARK: Extension

//extension SearchViewController: UISearchControllerDelegate {
//
//}

extension SearchViewController {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("확인버튼이 눌렸다 !")
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        /// searchbar에 입력한 텍스트
        guard let text = searchController.searchBar.text else { return }
        self.searchBarWord = text
        self.filteredData = self.bookList.filter { $0.title.localizedCaseInsensitiveContains(text)}
        self.noSearch.isHidden = filteredData.isEmpty ? false : true
        self.searchTableView.reloadData()
        
        //        NetworkManager.shared.getBookList(apiURL: "https://api.itbook.store/1.0/new", httpMethod: .get) { [weak self] data in
        //            print("리얼data Response: \(data)")
        //            self?.bookList = data
        //            DispatchQueue.main.sync {
        //                self?.bookTableView.reloadData()
        //            }
        //        }
        
        print("text: \(text)")
        
        //        NetworkManager.shared.getSearchBookList(apiURL: "https://api.itbook.store/1.0/search/\(searchBarWord)", httpMethod: ) { [weak self] data in
        //            print("써치 data : \(data)")
        //
        //                    }
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoPassDetailVC", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isFiltering ? self.filteredData.count : self.bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchDetailTableViewCell else { return UITableViewCell() }
        
        if self.isFiltering {
            if filteredData.count != 0 {
                cell.configureView(with: filteredData[indexPath.row])
                self.noSearch.isHidden = true
            }
        } else {
            cell.configureView(with: bookList[indexPath.row])
            self.noSearch.isHidden = true
        }
        return cell
    }
}

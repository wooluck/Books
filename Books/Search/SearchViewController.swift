//
//  SearchViewController.swift
//  Books
//
//  Created by pineone on 2022/06/21.
//

import UIKit
import Alamofire
import Kingfisher

class SearchViewController : UIViewController {
    
    var bookList = [Book]()
    var filteredData = [Book]()

    /// SearchBar 활성화 여부, Text 입력 여부
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    let searchController = UISearchController()
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var noSearch: UILabel!
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Search Books"
        self.navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "검색어를 입력해보세요."
        searchController.searchResultsUpdater = self
        searchTableView.dataSource = self
        searchTableView.delegate = self
        noSearch.isHidden = true
        
        fetchBook()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewDetailViewController {
            if let index = sender as? Int {
                vc.prepareImage = "\(bookList[index].image)"
                vc.prepareTitle = "\(bookList[index].title)"
                vc.prepareSubTitle = "\(bookList[index].subtitle)"
                vc.prepareIsbn13 = "\(bookList[index].isbn13)"
                vc.preparePrice = "\(bookList[index].price)"
                vc.prepareLink = "\(bookList[index].url)"
            }
        }
    }
}


// MARK: Extension

extension SearchViewController {
    
    /// Alamofire 한번 이용해보기
    func requestBookName() {
        let urlString =  "https://api.itbook.store/1.0/search/{query}/1"
        
        AF
            .request(urlString)
            .responseDecodable(of: BookModel.self) { response in
                guard case .success(let data) = response.result else { return }
                self.searchTableView.reloadData()
            }
            .resume()
    }
    
    /// URLSession 이용
    func fetchBook() {
        guard let url = URL(string: "https://api.itbook.store/1.0/new") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let bookData = try? JSONDecoder().decode(BookModel.self, from: data) else {
                      print("ERROR : \(error?.localizedDescription)")
                      return
                  }
            switch response.statusCode {
            case (200...299):
                print("Success: \(response.statusCode)")
                self.bookList = bookData.books

                DispatchQueue.main.async {
                    self.searchTableView.reloadData()
                }
            case (400...499):
                print(
                    """
                    ERROR: Client ERROR \(response.statusCode)
                    Response: \(response)
                    """
                )
            case (500...599):
                print(
                    """
                    ERROR: Server ERROR \(response.statusCode)
                    Response: \(response)
                    """
                )
            default:
                print(
                    """
                    ERROR: \(response.statusCode)
                    Response: \(response)
                    """
                )
            }
        }
        dataTask.resume()
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        /// searchbar에 입력한 텍스트
        guard let text = searchController.searchBar.text else { return }
        self.filteredData = self.bookList.filter { $0.title.localizedCaseInsensitiveContains(text)}
        self.noSearch.isHidden = filteredData.isEmpty ? false : true
        self.searchTableView.reloadData()
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
            
            let imageURL = URL(string: filteredData[indexPath.row].image )
            cell.searchBookImage.kf.setImage(with: imageURL)
            cell.searchBookTitle.text = self.filteredData[indexPath.row].title
            cell.searchBookSubTitle.text = self.filteredData[indexPath.row].subtitle
            cell.searchBookIsbn13.text = self.filteredData[indexPath.row].isbn13
            cell.searchBookPrice.text = self.filteredData[indexPath.row].price
            cell.searchBookLinkButton.text = self.filteredData[indexPath.row].url
                
            self.noSearch.isHidden = true
            }
        } else {
            cell.configureView(with: bookList[indexPath.row])
            self.noSearch.isHidden = true
        }
        return cell
    }
}

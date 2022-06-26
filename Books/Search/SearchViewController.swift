//
//  SearchViewController.swift
//  Books
//
//  Created by pineone on 2022/06/21.
//

import UIKit
import Alamofire

class SearchViewController : UIViewController {
    
    var bookList = [Book]()
    var dataTasks = [URLSessionTask]()
    
    let searchController = UISearchController()
    
    @IBOutlet weak var searchTableView: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Search Books"
        self.navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "검색어를 입력해보세요."
        
        searchTableView.dataSource = self
        searchTableView.delegate = self
//        fetchBook()
        
        requestBookName()
    }
}


// MARK: Extension

extension SearchViewController {
    
    // Alamofire 한번 이용해보기
    func requestBookName() {
        let urlString =  "https://api.itbook.store/1.0/search/{query}/1"
        
        AF
            .request(urlString)
            .responseDecodable(of: BookModel.self) { response in
                guard case .success(let data) = response.result else { return }
                
                print("이거이거이거 - \(data.books)")
                self.searchTableView.reloadData()
            }
            .resume()
    }
    
    
    func fetchBook() {
        guard let url = URL(string: "https://api.itbook.store/1.0/new") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let book = try? JSONDecoder().decode(BookModel.self, from: data) else {
                      print("ERROR : \(error?.localizedDescription)")
                      return
                  }
            switch response.statusCode {
            case (200...299):
                print("Success: \(response.statusCode)")
                self.bookList = book.books

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
        dataTasks.append(dataTask)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        
        
        searchTableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchDetailTableViewCell else { return UITableViewCell() }
        let book = bookList[indexPath.row]
        cell.configureView(with: book)
        
        return cell
    }
    
    
}

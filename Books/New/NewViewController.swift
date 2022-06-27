//
//  NewViewController.swift
//  Books
//
//  Created by pineone on 2022/06/21.
//

import UIKit

class NewViewController : UIViewController {
    
    /// 책 모델 배열
    var bookList = [Book]()
    
    @IBOutlet weak var bookTableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "New Books"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        bookTableView.delegate = self
        bookTableView.dataSource = self
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

// MARK: - Extension


extension NewViewController {
    /// API Session 사용
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
                    self.bookTableView.reloadData()
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

extension NewViewController : UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PassDetailVC", sender: indexPath.row)
    }
}

extension NewViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewCell", for: indexPath) as? NewTableViewCell else { return UITableViewCell() }
        cell.configureView(with: bookList[indexPath.row])
        
        return cell
    }
}




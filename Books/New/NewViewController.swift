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
    
    var newApi = "https://api.itbook.store/1.0/new"
    @IBOutlet weak var bookTableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationAndTableViewSet()
        
        Task {
            do {
                let books = try await NetworkManager.shared.loadBook()
                
                self.bookList = books
                
                DispatchQueue.main.async {
                    self.bookTableView.reloadData()
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
        
        bookTableView.delegate = self
        bookTableView.dataSource = self
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewDetailViewController {
            if let index = sender as? Int {
                vc.prepareBook = bookList[index]
            }
        }
    }
}

// MARK: - Extension

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




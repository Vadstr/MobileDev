//
//  BooksViewController.swift
//  Lab2
//
//  Created by Vadim on 17.04.2021.
//

import UIKit

class BooksViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var books: [Book] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        books = getBooks()
        
        tableView.register(UINib(nibName: "BookTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BookTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getBooks() -> [Book] {
        
        do {
            if let path = Bundle.main.path(forResource: "BooksList", ofType: "txt"),
               let jsonData = try String(contentsOfFile: path, encoding: String.Encoding.utf8).data(using: .utf8) {
                
                let decodedData = try JSONDecoder().decode(Books.self, from: jsonData)
                return decodedData.books
            }
            
        } catch {
            print("Error: ", error.localizedDescription)
        }
        return []
    }
    
    func getBook(with id: String) -> Book? {
            
            guard !id.isEmpty else {
                return nil
            }
            
            do {
                if let path = Bundle.main.path(forResource: id, ofType: "txt"),
                   let jsonData = try String(contentsOfFile: path, encoding: String.Encoding.utf8).data(using: .utf8) {
                    
                    let decodedData = try JSONDecoder().decode(Book.self, from: jsonData)
                    return decodedData
                }
            } catch let error {
                print(error.localizedDescription)
            }
            return nil
        }
}

extension BooksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedID = books[indexPath.row].isbn13
        if let selectedBook = getBook(with: selectedID){
        let controller = BookContentViewControler.create(with: selectedBook)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as? BookTableViewCell else {
            return UITableViewCell()
        }
        let book = books[indexPath.row]
        cell.book = book
        return cell
    }
}

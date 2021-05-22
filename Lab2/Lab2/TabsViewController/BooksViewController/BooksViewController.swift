//
//  BooksViewController.swift
//  Lab2
//
//  Created by Vadim on 17.04.2021.
//

import UIKit
import Alamofire

class BooksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cantFoundLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var books: [Book] = []
    var searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //        books = getBooks()
        cantFoundLabel.isHidden = true
        tableView.register(UINib(nibName: "BookTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BookTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func findBooks(name: String) {
        activityIndicator.startAnimating()
        AF.request("https://api.itbook.store/1.0/search/\(name)")
            .validate()
            .responseDecodable(of: Books.self) { [weak self] (response) in
                self?.activityIndicator.stopAnimating()
                guard let response = response.value else { return }
                self?.cantFoundLabel.isHidden = !response.books.isEmpty
                self?.books = response.books
                self?.tableView.reloadData()
            }
    }
    
    func findBookDetails(isbn13: String, completion: @escaping (Book) -> Void) {
        activityIndicator.startAnimating()
        AF.request("https://api.itbook.store/1.0/books/\(isbn13)")
            .validate()
            .responseDecodable(of: Book.self) { [weak self] (response) in
                self?.activityIndicator.stopAnimating()
                guard let response = response.value else { return }
                completion(response)
            }
    }
}

extension BooksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedID = books[indexPath.row].isbn13
        findBookDetails(isbn13: selectedID) { [weak self] book in
            let controller = BookContentViewControler.create(with: book)
            self?.navigationController?.pushViewController(controller, animated: true)
        }
        //        if let selectedBook = getBook(with: selectedID){
        //            let controller = BookContentViewControler.create(with: selectedBook)
        //            navigationController?.pushViewController(controller, animated: true)
        //        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return booksInSearch.count
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Library"
    }
}

extension BooksViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let enteredText = searchController.searchBar.text?.lowercased(),
              enteredText.count > 2 else {
            books = []
            cantFoundLabel.isHidden = false
            tableView.reloadData()
            return
        }
        findBooks(name: enteredText)
        //        booksInSearch = enteredText.isEmpty ? books : books.filter { book in
        //            book.title.lowercased().contains(enteredText) ||  book.subtitle.lowercased().contains(enteredText)
        //        }
        //        cantFoundLabel.isHidden = !booksInSearch.isEmpty
        //        tableView.reloadData()
    }
}


extension BooksViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        books = []
        cantFoundLabel.isHidden = false
        tableView.reloadData()
    }
}

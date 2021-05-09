//
//  BooksViewController.swift
//  Lab2
//
//  Created by Vadim on 17.04.2021.
//

import UIKit

class BooksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cantFoundLabel: UILabel!
    
    var books: [Book] = []
    var booksInSearch: [Book] = []
    var searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        books = getBooks()
        booksInSearch = books
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
    
    private func createNewBook(alert: UIAlertController, title: String, subtitle: String, price: String) {
        
        guard let intPrice = Int(price),
              (0...Int.max).contains(intPrice) else {
            
            let invalidAlert = UIAlertController(title: "Invalid price", message: "", preferredStyle: .alert)
            invalidAlert.addAction(UIAlertAction(title: "Try again", style: .default))
            present(invalidAlert, animated: true)
            return
        }
        
        let newBook = Book(title: title, subtitle: subtitle, price: intPrice)
        books.append(newBook)
        booksInSearch.append(newBook)
        tableView.reloadData()
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: IndexPath(row: self.booksInSearch.count - 1, section: 0), at: .bottom, animated: true)
        }
        cantFoundLabel.isHidden = true
    }
    
    @IBAction func createNewAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Create new book", message: "", preferredStyle: .alert)
        
        // Text fields
        alert.addTextField { $0.placeholder = "Book title" }
        alert.addTextField {
            $0.placeholder = "Book subtitle"
        }
        alert.addTextField {
            $0.keyboardType = .numberPad
            $0.placeholder = "Price"
        }
        
        // Actions
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Add", style: .default) { [weak alert, weak self] _ in
            
            guard let title = alert?.textFields?[0].text,
                  let subtitle = alert?.textFields?[1].text,
                  let price = alert?.textFields?[2].text else {
                return
            }
            
            self?.createNewBook(alert: alert!, title: title, subtitle: subtitle, price: price)
        })
        
        present(alert, animated: true)
        
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
        let selectedID = booksInSearch[indexPath.row].isbn13
        if let selectedBook = getBook(with: selectedID){
            let controller = BookContentViewControler.create(with: selectedBook)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksInSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as? BookTableViewCell else {
            return UITableViewCell()
        }
        let book = booksInSearch[indexPath.row]
        cell.book = book
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Library"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let bookToDelete = booksInSearch.remove(at: indexPath.row)
            books.removeAll { book in
                return book.isbn13 == bookToDelete.isbn13
            }
        }
        tableView.reloadData()
        cantFoundLabel.isHidden = !booksInSearch.isEmpty
        
    }
}

extension BooksViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let enteredText = searchController.searchBar.text?.lowercased() else {
            return
        }
        booksInSearch = enteredText.isEmpty ? books : books.filter { book in
            book.title.lowercased().contains(enteredText) ||  book.subtitle.lowercased().contains(enteredText)
        }
        cantFoundLabel.isHidden = !booksInSearch.isEmpty
        tableView.reloadData()
    }
}


extension BooksViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        booksInSearch = books
        tableView.reloadData()
        cantFoundLabel.isHidden = !booksInSearch.isEmpty
    }
}

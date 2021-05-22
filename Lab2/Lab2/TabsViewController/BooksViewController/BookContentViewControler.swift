//
//  BookContentViewControler.swift
//  Lab2
//
//  Created by Vadim on 17.04.2021.
//

import UIKit

class BookContentViewControler: UIViewController {
    
    static func create(with book: Book) -> BookContentViewControler {
        
        let controller = UIStoryboard(name: "Main", bundle: Bundle.main) .instantiateViewController(withIdentifier: "BookContentViewControler") as! BookContentViewControler
        controller.book = book
        return controller
    }
    
    @IBOutlet weak var bookContentTableView: UITableView!
    @IBOutlet weak var bookPreviewImageView: UIImageView!
    
    var book: Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookPreviewImageView.sd_setImage(with: URL(string: book?.image ?? ""), placeholderImage: UIImage(systemName: "doc.fill.badge.plus"))
        
        bookContentTableView.register(UINib(nibName: "BookContentTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "BookContentTableViewCell")
        
        bookContentTableView.delegate = self
        bookContentTableView.dataSource = self
    }
}

extension BookContentViewControler: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return book.getFullContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookContentTableViewCell", for: indexPath) as? BookContentTableViewCell else {
            return UITableViewCell()
        }
        let data = book.getFullContent[indexPath.row]
        cell.config(field: data.field, value: data.value)
        return cell
    }
}

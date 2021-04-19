//
//  BookTableViewCell.swift
//  MobileSystemProgramming
//
//  Created by Vadim on 17.03.2021.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookSubtitleLabel: UILabel!
    @IBOutlet weak var bookPriceLabel: UILabel!
    
    var book: Book? {
        didSet {
            bookImageView.image = book?.bookImage
            bookTitleLabel.text = book?.title
            bookSubtitleLabel.text = book?.subtitle
            bookPriceLabel.text = book?.price
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}

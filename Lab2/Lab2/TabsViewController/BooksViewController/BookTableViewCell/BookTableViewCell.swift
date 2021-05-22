//
//  BookTableViewCell.swift
//  MobileSystemProgramming
//
//  Created by Vadim on 17.03.2021.
//

import UIKit
import SDWebImage

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookSubtitleLabel: UILabel!
    @IBOutlet weak var bookPriceLabel: UILabel!
    
    var book: Book? {
        didSet {
            bookImageView.sd_setImage(with: URL(string: book?.image ?? ""), placeholderImage: UIImage(systemName: "doc.fill.badge.plus"))
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

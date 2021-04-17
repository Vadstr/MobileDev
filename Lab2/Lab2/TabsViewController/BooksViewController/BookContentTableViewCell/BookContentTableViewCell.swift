//
//  BookContentTableViewCell.swift
//  Lab2
//
//  Created by Vadim on 17.04.2021.
//

import UIKit

class BookContentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var field: UILabel!
    @IBOutlet weak var value: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    func config(field: String, value: String)
    {
        self.field.text = field
        self.value.text = value
    }
}

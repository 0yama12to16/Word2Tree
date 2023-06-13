//
//  CustomTableViewCell.swift
//  Word2Tree
//
//  Created by ToyaOyama on 2023/06/11.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var content: UILabel!
    @IBOutlet var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

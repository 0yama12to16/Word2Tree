//
//  CustomTableViewCell.swift
//  Word2Tree
//
//  Created by ToyaOyama on 2023/06/11.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var leafBox: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var content: UILabel!
    
    var superView1: ViewController! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

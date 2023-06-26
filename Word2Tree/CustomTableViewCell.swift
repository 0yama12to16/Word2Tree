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
    
    var superView1: ViewController! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func buttonTapped(_ sender: Any) {
        content.text = "ボタンが押されました。"
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

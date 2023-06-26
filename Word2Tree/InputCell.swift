//
//  InputCell.swift
//  Word2Tree
//
//  Created by ToyaOyama on 2023/06/14.
//

import UIKit
import Alamofire

class InputCell: UITableViewCell {

    @IBOutlet var name: UITextField!
    @IBOutlet var content: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func buttonTapped(_ sender: Any) {
        doPost(prompt: content.text!)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func doPost(prompt: String){
            let parameters = ["prompt":prompt] as [String : String]
            
            AF.request("http://localhost:5000/toTree", method: .post, parameters:  parameters , encoding: JSONEncoding.default, headers: nil).response { response in
                print(response.value!!)
                    }
        }
    
}

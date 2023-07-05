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
    
    var superView: ViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func buttonTapped(_ sender: Any) {
        superView.item.append([])
        superView.item[superView.item.count-1].append(name.text!)
        superView.item[superView.item.count-1].append(content.text!)
        print(superView.item)
        
        let indexPath = IndexPath(row: superView.item.count - 1, section: 0)
        superView.tableView1.insertRows(at: [indexPath], with: .automatic)
        
        doPost(prompt: content.text!)
        
        name.text = ""
        content.text = ""
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func doPost(prompt: String){
            let parameters = ["prompt":prompt] as [String : String]
            
            AF.request("http://192.168.1.2:11000/toTree", method: .post, parameters:  parameters , encoding: JSONEncoding.default, headers: nil).response { response in
                print(response.value!!)
                    }
        }
    
}

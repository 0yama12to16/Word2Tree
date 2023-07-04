//
//  ViewController.swift
//  Word2Tree
//
//  Created by ToyaOyama on 2023/06/11.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView1: UITableView!
    var tableView2: UITableView!
    var item = [["A","今日は寝坊をしたため気分が悪いです"]]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView1 = UITableView(frame:CGRect(x: 0, y:0, width:view.bounds.width, height: view.bounds.height-200), style: .plain)
        tableView1.delegate = self
        tableView1.dataSource = self
        view.addSubview(tableView1)
        tableView1.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableView1.rowHeight = 200
        
        tableView2 = UITableView(frame:CGRect(x: 0, y:view.bounds.height-200, width:view.bounds.width, height: 200), style: .plain)
        tableView2.delegate = self
        tableView2.dataSource = self
        view.addSubview(tableView2)
        tableView2.register(UINib(nibName: "InputCell", bundle: nil), forCellReuseIdentifier: "inputCell")
        tableView2.rowHeight = 200
        
        NotificationCenter.default.addObserver(self, selector: #selector(openKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(closeKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func openKeyboard(notification: Notification) {
        if let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            self.tableView2.frame.origin.y -= keyboardRect.height
        }
    }
    
    @objc func closeKeyboard(notification: Notification) {
        self.tableView2.frame.origin.y = view.bounds.height-200
    }
        
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1{
            return item.count
        } else if tableView == tableView2 {
            return 1
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        if tableView == tableView1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
            if let customCell = cell as? CustomTableViewCell {
                customCell.content.text = item[indexPath.row][1]
                customCell.name.text = item[indexPath.row][0]
            }
            
            var cellSelectedBgView1 = UIView()
            cellSelectedBgView1.backgroundColor = UIColor.white
            cell.selectedBackgroundView = cellSelectedBgView1
            
        } else if tableView == tableView2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "inputCell", for: indexPath) as! InputCell
            if let inputCell = cell as? InputCell {
                inputCell.superView = self
            }
            
            var cellSelectedBgView2 = UIView()
            cellSelectedBgView2.backgroundColor = UIColor.white
            cell.selectedBackgroundView = cellSelectedBgView2
            
        }
        return cell
    }
    
    /**
    func inputView(_ inputView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func inputView(_ inputView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = inputView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath) as! InputCell
        return cell
    }
     */
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                self.view.endEditing(true)
    }
     */
   

}
 

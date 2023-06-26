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
    var item: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView1 = UITableView(frame:CGRect(x: 0, y:0, width:view.bounds.width, height: view.bounds.height-400), style: .plain)
        tableView1.delegate = self
        tableView1.dataSource = self
        view.addSubview(tableView1)
        tableView1.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableView1.rowHeight = 200
        
        tableView2 = UITableView(frame:CGRect(x: 0, y:view.bounds.height-400, width:view.bounds.width, height: 400), style: .plain)
        tableView2.delegate = self
        tableView2.dataSource = self
        view.addSubview(tableView2)
        tableView2.register(UINib(nibName: "InputCell", bundle: nil), forCellReuseIdentifier: "inputCell")
        tableView2.rowHeight = 400
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1{
            return 9
        } else if tableView == tableView2 {
            return 1
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        if tableView == tableView1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        } else if tableView == tableView2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "inputCell", for: indexPath) as! InputCell
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
 

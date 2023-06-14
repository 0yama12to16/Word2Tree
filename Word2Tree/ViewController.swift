//
//  ViewController.swift
//  Word2Tree
//
//  Created by ToyaOyama on 2023/06/11.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView = UITableView(frame:CGRect(x: 0, y:0, width:view.bounds.width, height: view.bounds.height-200), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        let inputView = UITableView(frame:CGRect(x: 0, y:view.bounds.height-200, width:view.bounds.width, height: 200), style: .plain)
        view.addSubview(inputView)
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableView.rowHeight = 200
        inputView.register(UINib(nibName: "InputCell", bundle: nil), forCellReuseIdentifier: "InputCell")
        inputView.rowHeight = 200
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        //cell.content.text = self.item[indexPath.row]
        return cell
    }
    
    
    /**
    func inputView(_ inputView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func inputView(_ inputView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = inputView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath) as! InputCell
        return cell
    }
     **/
    func inputTableView(_ inputTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
        }
        
        func inputTableView(_ inputTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = inputTableView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath) as! InputCell
            return cell
        }


}



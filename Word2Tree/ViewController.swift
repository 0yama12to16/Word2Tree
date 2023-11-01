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
    var tableView_input: UITableView!
    var tableView_list: UITableView!
    var imageView: UIImageView!
    var navigationBar: UINavigationBar!
    
    var addButtonItem: UIBarButtonItem!
    
    var tableView_below_bar: UITableView!
    
    //indexをリストIDとして利用
    var item: [String] = []
    
    var keyboardFlag: Bool = false
    let secondVC = ViewController_wood()
    
    
    
    //ToDo：リストの情報が、メモリに保持されているので、フロントとの整合性を保つために、その日の分のリスト情報は、外部のファイルに出力しておき、次にアプリを開いた場合にそれを読み込んでからスタートする形。
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView_below_bar = UITableView(frame:CGRect(x:0,y:50,width:view.bounds.width,height:view.bounds.height),style:.plain)
        tableView_below_bar.delegate = self
        tableView_below_bar.dataSource = self
        view.addSubview(tableView_below_bar)
        
    
        
        navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height:100 ))
        navigationBar.barTintColor = UIColor.gray // バーの背景色
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white] //タイトルのテキストカラー
        let navigationItem = UINavigationItem()
        navigationItem.title = "入力画面"
        navigationBar.setItems([navigationItem], animated: false)
        view.addSubview(navigationBar)
        
        
        var deleteButtonItem = UIBarButtonItem(title: "主観の樹・客観の樹", style: .done, target: self, action: #selector(deleteButtonPressed(_:)))
        navigationItem.rightBarButtonItem = deleteButtonItem
        
        
        
        
        tableView_list = UITableView(frame:CGRect(x:0,y:0,width:view.bounds.width/2,height:view.bounds.height-90),style:.plain)
        tableView_list.delegate = self
        tableView_list.dataSource = self
        tableView_below_bar.addSubview(tableView_list)
        
        tableView_input = UITableView(frame:CGRect(x:view.bounds.width/2,y:0,width:view.bounds.width/2,height:view.bounds.height),style:.plain)
        tableView_input.delegate = self
        tableView_input.dataSource = self
        tableView_below_bar.addSubview(tableView_input)
        
        imageView = UIImageView(image: UIImage(named: "sample_plutick"))
        imageView.frame = CGRect(x: 25, y: 10, width: tableView_input.bounds.width-25, height: tableView_input.bounds.width-25) // 位置とサイズの設定
        tableView_input.addSubview(imageView)
        
        let borderLayer = CALayer()
        borderLayer.backgroundColor = UIColor.gray.cgColor
        borderLayer.frame = CGRect(x: tableView_list.frame.width, y: 50, width: 1, height: tableView_list.frame.height)
        view.layer.addSublayer(borderLayer)
        

        tableView1 = UITableView(frame:CGRect(x: 0, y:0, width:view.bounds.width, height: view.bounds.height), style: .plain)
        tableView1.delegate = self
        tableView1.dataSource = self
        tableView_list.addSubview(tableView1)
        tableView1.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableView1.rowHeight = 200
        
        tableView2 = UITableView(frame:CGRect(x: 10, y:view.bounds.height-265, width:view.bounds.width, height: 250), style: .plain)
        tableView2.delegate = self
        tableView2.dataSource = self
        tableView_input.addSubview(tableView2)
        tableView2.register(UINib(nibName: "InputCell", bundle: nil), forCellReuseIdentifier: "inputCell")
        tableView2.rowHeight = 250
        
        NotificationCenter.default.addObserver(self, selector: #selector(openKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(closeKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
        
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.previousVC = self
            
    }
    
    @objc func openKeyboard(notification: Notification) {
        if (!keyboardFlag){
            if let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
                self.tableView_input.frame.origin.y -= keyboardRect.height
                
            }
            keyboardFlag = true
        }
    }
    
    @objc func closeKeyboard(notification: Notification) {
        if keyboardFlag {
            self.tableView_input.frame.origin.y = 0
            keyboardFlag = false
        }
    }
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1{
            return item.count
        } else if tableView == tableView2 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("\(indexPath.row)番目の行が選択されました。")
        //テストのためコメントアウト
        //postListNo(listNo: indexPath.row)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        if tableView == tableView1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
            if let customCell = cell as? CustomTableViewCell {
                customCell.content.text = item[indexPath.row]
                print(indexPath.row)
            }
            
            var cellSelectedBgView1 = UIView()
            cellSelectedBgView1.layer.shadowColor = UIColor.gray.cgColor
            cellSelectedBgView1.layer.borderWidth = 2.0
            //cellSelectedBgView1.backgroundColor = .black
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
    
    @objc func deleteButtonPressed(_ sender: UIBarButtonItem) {
        self.present(secondVC, animated: true, completion: nil)
    }
    
    
}
 

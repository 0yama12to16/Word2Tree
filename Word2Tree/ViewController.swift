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
    var emotionList: [Int] = []
    var emotionListO: [Int] = []
    
    var keyboardFlag: Bool = false
    let secondVC = ViewController_wood()
    
    var isTextFilled: Bool = false
    //選択されている感情（default値は100）
    var selectedEmotion: Int = 100
    var inputcell: InputCell!
    
    //LastToDo:tableView_listの下の方が見切れるのを治す。
    
    
    
    //ToDo：リストの情報が、メモリに保持されているので、フロントとの整合性を保つために、その日の分のリスト情報は、外部のファイルに出力しておき、次にアプリを開いた場合にそれを読み込んでからスタートする形。
    //ToDo:tableView_listの下の方が見切れているので、サイズの調整
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
        
        
        
        tableView_list = UITableView(frame:CGRect(x:0,y:0,width:view.bounds.width/2,height:view.bounds.height-50),style:.plain)
        tableView_list.delegate = self
        tableView_list.dataSource = self
        tableView_below_bar.addSubview(tableView_list)
        
        tableView_input = UITableView(frame:CGRect(x:view.bounds.width/2,y:0,width:view.bounds.width/2,height:view.bounds.height),style:.plain)
        tableView_input.delegate = self
        tableView_input.dataSource = self
        tableView_below_bar.addSubview(tableView_input)
        
        imageView = UIImageView(image: UIImage(named: "color"))
        imageView.frame = CGRect(x: 40, y: 40, width: tableView_input.bounds.width-80, height: tableView_input.bounds.width-80) // 位置とサイズの設定
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        tableView_input.addSubview(imageView)
        
        let borderLayer = CALayer()
        borderLayer.backgroundColor = UIColor.gray.cgColor
        borderLayer.frame = CGRect(x: tableView_list.frame.width, y: 50, width: 1, height: tableView_list.frame.height)
        view.layer.addSublayer(borderLayer)
        
        //Todo:tableViewがtableView1とtableView_listで二重になってるっぽい？
        tableView1 = UITableView(frame:CGRect(x: 0, y:0, width:view.bounds.width, height: tableView_list.bounds.height), style: .plain)
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
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print(imageView.clipsToBounds)
//        print("touched")
//        let touch = touches.first!
//        let location = touch.location(in: self.imageView)
//        var x = location.x - imageView.bounds.width/2
//        var y = location.y - imageView.bounds.height/2
//
//        var euclid: Double = sqrt((x*x)+(y*y))
//        var cosxy = x/euclid
//
//        print(euclid,cosxy)
//        //以降で原点からのピタゴラスと、cosを使って条件分岐を行う。
//
//    }
    
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        
        
        //for test
        print(isTextFilled)
        if isTextFilled{
            inputcell.postButton.isEnabled = true
        }
        
            // タッチした位置を取得
        let location = sender.location(in: sender.view)
            // 座標を表示
        var x: Double = location.x - imageView.bounds.width/2
        var y: Double = -(location.y - imageView.bounds.height/2)
        var euclid: Double = sqrt((x*x)+(y*y))
        var cosxy: Double = x/euclid
        var quadrant: Int = 0
        if(x >= 0 && y >= 0){
            quadrant = 1
        }else if(y >= 0 && x < 0){
            quadrant = 2
        }else if(y < 0 && x < 0){
            quadrant = 3
        }else if(y < 0 && x >= 0){
            quadrant = 4
        }
        if (quadrant == 1 || quadrant == 2){
            if (euclid<=28.33){
                changeImage(imageNo: 0)
            }else if (euclid>28.33 && euclid<=85){
                if ((cosxy > cos(1*Double.pi/8)) && (cosxy <= cos(0*Double.pi/8))){
                    changeImage(imageNo: 3)
                }
                else if ((cosxy > cos(3*Double.pi/8)) && (cosxy <= cos(1*Double.pi/8))){
                    changeImage(imageNo:2 )
                }
                else if ((cosxy > cos(5*Double.pi/8)) && (cosxy <= cos(3*Double.pi/8))){
                    changeImage(imageNo:1 )
                }
                else if ((cosxy > cos(7*Double.pi/8)) && (cosxy <= cos(5*Double.pi/8))){
                    changeImage(imageNo: 8)
                }
                else if ((cosxy > cos(8*Double.pi/8)) && (cosxy <= cos(7*Double.pi/8))){
                    changeImage(imageNo: 7)
                }
            }else if (euclid>85 && euclid<=141.66){
                if ((cosxy > cos(1*Double.pi/8)) && (cosxy <= cos(0*Double.pi/8))){
                    changeImage(imageNo: 11)
                }
                else if ((cosxy > cos(3*Double.pi/8)) && (cosxy <= cos(1*Double.pi/8))){
                    changeImage(imageNo: 10)
                }
                else if ((cosxy > cos(5*Double.pi/8)) && (cosxy <= cos(3*Double.pi/8))){
                    changeImage(imageNo:9 )
                }
                else if ((cosxy > cos(7*Double.pi/8)) && (cosxy <= cos(5*Double.pi/8))){
                    changeImage(imageNo:16 )
                }
                else if ((cosxy > cos(8*Double.pi/8)) && (cosxy <= cos(7*Double.pi/8))){
                    changeImage(imageNo:15 )
                }
            }else if (euclid>141.66 && euclid<=198.32){
                if ((cosxy > cos(1*Double.pi/8)) && (cosxy <= cos(0*Double.pi/8))){
                    changeImage(imageNo: 19)
                }
                else if ((cosxy > cos(3*Double.pi/8)) && (cosxy <= cos(1*Double.pi/8))){
                    changeImage(imageNo: 18)
                }
                else if ((cosxy > cos(5*Double.pi/8)) && (cosxy <= cos(3*Double.pi/8))){
                    changeImage(imageNo:17 )
                }
                else if ((cosxy > cos(7*Double.pi/8)) && (cosxy <= cos(5*Double.pi/8))){
                    changeImage(imageNo: 24)
                }
                else if ((cosxy > cos(8*Double.pi/8)) && (cosxy <= cos(7*Double.pi/8))){
                    changeImage(imageNo:23 )
                }
            }else if (euclid>198.32){
                if ((cosxy > cos(2*Double.pi/8)) && (cosxy <= cos(0*Double.pi/8))){
                    changeImage(imageNo: 26)
                }
                else if ((cosxy > cos(4*Double.pi/8)) && (cosxy <= cos(2*Double.pi/8))){
                    changeImage(imageNo: 25)
                }
                else if ((cosxy > cos(6*Double.pi/8)) && (cosxy <= cos(4*Double.pi/8))){
                    changeImage(imageNo: 32)
                }
                else if ((cosxy > cos(8*Double.pi/8)) && (cosxy <= cos(6*Double.pi/8))){
                    changeImage(imageNo:31 )
                }
            }
        } else if (quadrant == 3 || quadrant == 4){
            if (euclid<=28.33){
                changeImage(imageNo: 0)
            }else if (euclid>28.33 && euclid<=85){
                if ((cosxy > cos(8*Double.pi/8)) && (cosxy <= cos(9*Double.pi/8))){
                    changeImage(imageNo: 7)
                }
                else if ((cosxy > cos(9*Double.pi/8)) && (cosxy <= cos(11*Double.pi/8))){
                    changeImage(imageNo:6)
                }
                else if ((cosxy > cos(11*Double.pi/8)) && (cosxy <= cos(13*Double.pi/8))){
                    changeImage(imageNo: 5)
                }
                else if ((cosxy > cos(13*Double.pi/8)) && (cosxy <= cos(15*Double.pi/8))){
                    changeImage(imageNo: 4)
                }
                else if ((cosxy > cos(15*Double.pi/8)) && (cosxy <= cos(16*Double.pi/8))){
                    changeImage(imageNo: 3)
                }
            }else if (euclid>85 && euclid<=141.66){
                if ((cosxy > cos(8*Double.pi/8)) && (cosxy <= cos(9*Double.pi/8))){
                    changeImage(imageNo: 15)
                }
                else if ((cosxy > cos(9*Double.pi/8)) && (cosxy <= cos(11*Double.pi/8))){
                    changeImage(imageNo: 14)
                }
                else if ((cosxy > cos(11*Double.pi/8)) && (cosxy <= cos(13*Double.pi/8))){
                    changeImage(imageNo:13 )
                }
                else if ((cosxy > cos(13*Double.pi/8)) && (cosxy <= cos(15*Double.pi/8))){
                    changeImage(imageNo:12 )
                }
                else if ((cosxy > cos(15*Double.pi/8)) && (cosxy <= cos(16*Double.pi/8))){
                    changeImage(imageNo: 11)
                }
            }else if (euclid>141.66 && euclid<=198.32){
                if ((cosxy > cos(8*Double.pi/8)) && (cosxy <= cos(9*Double.pi/8))){
                    changeImage(imageNo:23 )
                }
                else if ((cosxy > cos(9*Double.pi/8)) && (cosxy <= cos(11*Double.pi/8))){
                    changeImage(imageNo: 22)
                }
                else if ((cosxy > cos(11*Double.pi/8)) && (cosxy <= cos(13*Double.pi/8))){
                    changeImage(imageNo: 21)
                }
                else if ((cosxy > cos(13*Double.pi/8)) && (cosxy <= cos(15*Double.pi/8))){
                    changeImage(imageNo: 20)
                }
                else if ((cosxy > cos(15*Double.pi/8)) && (cosxy <= cos(16*Double.pi/8))){
                    changeImage(imageNo: 19)
                }
            }else if (euclid>198.32){
                if ((cosxy > cos(8*Double.pi/8)) && (cosxy <= cos(10*Double.pi/8))){
                    changeImage(imageNo: 30)
                }
                else if ((cosxy > cos(10*Double.pi/8)) && (cosxy <= cos(12*Double.pi/8))){
                    changeImage(imageNo: 29)
                }
                else if ((cosxy > cos(12*Double.pi/8)) && (cosxy <= cos(14*Double.pi/8))){
                    changeImage(imageNo: 28)
                }
                else if ((cosxy > cos(14*Double.pi/8)) && (cosxy <= cos(16*Double.pi/8))){
                    changeImage(imageNo:27 )
                }
            }
        }
    }
    
    func changeImage(imageNo: Int){
        imageView.image = UIImage(named: "color"+String(imageNo))

        selectedEmotion = imageNo
        print()
        //imageView.isUserInteractionEnabled = true
        //imageView.addGestureRecognizer(tapGesture)
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
    
    //ToDo:バックエンドとの整合性のためにも、配列にリストナンバーを格納しておく方法にシフトを検討
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if (tableView == tableView1){
            print("\(indexPath.row)番目の行が選択されました。")
            //テストのためコメントアウト
            postListNo(listNo: indexPath.row)
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        if tableView == tableView1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
            if let customCell = cell as? CustomTableViewCell {
                customCell.content.text = item[indexPath.row]
                customCell.leafBoxS.image = UIImage(named: "leaf"+String(emotionList[indexPath.row]))
                print(emotionListO)
                //LastToDo:ここで以下をアンコメントすると、バックエンドから感情が返ってきていない状態で、以下を実行するためindexOutOfRangeとなる。
                //customCell.leafBox.image = UIImage(named: "leaf"+String(emotionListO[indexPath.row]))

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
                self.inputcell = inputCell
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
        secondVC.previousVC = self
        self.present(secondVC, animated: true, completion: nil)
    }
    
    
}
 

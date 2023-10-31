//
//  ViewController_wood.swift
//  Word2Tree
//
//  Created by ToyaOyama on 2023/10/31.
//
import UIKit

class ViewController_wood: UIViewController{
    
    var imageView: UIImageView!
    var navigationBar: UINavigationBar!
    var imageCounter: Int = 0
    
    var addButtonItem: UIBarButtonItem!
    
    var item: [String] = []
    var indexOfItem: [Int] = []
    
    var keyboardFlag: Bool = false
    var previousVC: ViewController? = nil
    
    //はじめだけよまれる
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: (previousVC?.view.bounds.width)!, height:100 ))
        navigationBar.barTintColor = UIColor.gray // バーの背景色
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white] //タイトルのテキストカラー
        let navigationItem = UINavigationItem()
        navigationItem.title = "主観の木　　　　　　　　　　　　　　　　　　　　　　　客観の木"
        navigationBar.setItems([navigationItem], animated: false)
        view.addSubview(navigationBar)
        
        
        var deleteButtonItem = UIBarButtonItem(title: "戻る", style: .done, target: self, action: #selector(deleteButtonPressed(_:)))
        navigationItem.leftBarButtonItem = deleteButtonItem
        
        
        
        imageView = UIImageView(image: UIImage(named: "dammy_tree"))
        imageView.frame = CGRect(x:0 , y: 50, width: (previousVC?.view.bounds.width)!, height: (previousVC?.view.bounds.height)!-50) // 位置とサイズの設定
        view.addSubview(imageView)
        // Do any additional setup after loading the view.
        
        
            
    }
    func updateImage() {
        //ToDo画像変更のコード
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self.imageView)
        Swift.print(type(of: location))
        var x = location.x
        var y = location.y
        //テストのため以下はコメントアウト
        //postPosLeaf(x: x, y: y)
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
        print(imageCounter)
        self.dismiss(animated: true)
    }
}
 



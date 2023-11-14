//
//  InputCell.swift
//  Word2Tree
//
//  Created by ToyaOyama on 2023/06/14.
//

import UIKit
import Alamofire

class InputCell: UITableViewCell{
    @IBOutlet weak var content2: HintTextView!
    @IBOutlet weak var postButton: UIButton!
    
    
    var superView: ViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        /**
        let attributes: [NSAttributedString.Key : Any] = [
              .font: UIFont.boldSystemFont(ofSize: 22.0) // フォントサイズ：20、太さ：bold

            ]
        
        content.attributedPlaceholder = NSAttributedString(string: "投稿内容　", attributes: attributes)
         */
        // Initialization code
        
        content2.layer.borderColor = UIColor.black.cgColor
        
        content2.layer.borderWidth = 0.5
        content2.layer.cornerRadius = 5
        content2.setCell(inputcell: self)
        content2.hintText = "投稿内容\n例文：これから展示回るの楽しみです！\n           毎日暑すぎ！ムリ！\n           今日は寝坊してしまい気分が落ち込んでいます。"
        //content2.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        postButton.isEnabled = false
         
        
    }

    @IBAction func buttonTapped(_ sender: Any) {
        
        //テストのため以下をコメントアウト
        //doPost(prompt: content2.text!)
        //テストのため以下をコメントアウト
        getEmoO(emoNoS: superView.selectedEmotion, content: content2.text!, viewController: superView)
        //上記のhttpgetで得た客観的感情をViewControllerクラスに渡す。
        //行を追加するよりも先にViewControllerクラスに客観的感情を渡す必要があるので、これを上記の処理より先に持ってきた方が良い？
        //superView.secondVC.imageCounter += 1
        //画像を保存
        //viewContoroller_woodを更新
        superView.secondVC.updateImage()
        
        
        content2.text = ""
        content2.changeVisibility()
        
        superView.selectedEmotion = 100
        superView.isTextFilled = false
        superView.imageView.image = UIImage(named: "color")
        self.postButton.isEnabled = false
        
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
//    func textViewDidChange(_ textView: UITextView){
//        if (!textView.text.isEmpty && superView.selectedEmotion != 100){
//            superView.isTextFilled = true
//            postButton.isEnabled = true
//        }else {
//            superView.isTextFilled = false
//            postButton.isEnabled = false
//        }
//    }
    
    func addingCell(){
        
    }
    
    
}


//以下プレーズホルダー付き、複数業テキストフィールドクラス
@IBDesignable
class HintTextView: UITextView {
    
    var inputcell: InputCell? = nil
    // Placeholder として表示するテキスト
    var hintText = "" {
        didSet {
            hintLabel.text = hintText
        }
    }
    
    private lazy var hintLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.textColor = .lightGray
        return label
    }()
    
    public func setCell(inputcell: InputCell){
        self.inputcell = inputcell
    }
    
    // テキストの初期値を入れるときは textViewDidChange が発火しないのでこちらのメソッドを使用する
    func setText(_ text: String) {
        self.text = text
        changeVisibility()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
        super.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
    
    // 2. TextView の中に Label を置く
        addSubview(hintLabel)
        
    // Placeholder の表示位置を調整
        NSLayoutConstraint.activate([
        // hintLabe とその親である HintTextView のトップの余白
            hintLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
        // hintLabe とその親である HintTextView で X 軸を一致させる
            hintLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        // hintLabe はその親である HintTextView よりも幅を 10 小さくする（左右に 5 ずつ余白を設ける）
            hintLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -10),
        ])
        
        self.delegate = self
    }
    
    func changeVisibility() {
        if self.text.isEmpty {
            hintLabel.isHidden = false
        } else {
            hintLabel.isHidden = true
        }
    }
    func changeButtonStatus(_ textView: UITextView){
        if (!textView.text.isEmpty && inputcell?.superView.selectedEmotion != 100){
            inputcell?.postButton.isEnabled = true
        }else {
            inputcell?.postButton.isEnabled = false
        }
    }
    func changeIsTextFilled_ViewController(_ textView: UITextView){
        if (!textView.text.isEmpty){
            inputcell?.superView.isTextFilled = true
        } else {
            inputcell?.superView.isTextFilled = false
        }
    }
}

extension HintTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // 3. TextView に文字が入力されているかどうかで Label の表示/非表示を切り替える
        changeVisibility()
        changeButtonStatus(textView)
        changeIsTextFilled_ViewController(textView)
        
    }
}

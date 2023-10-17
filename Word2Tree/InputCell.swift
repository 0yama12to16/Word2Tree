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
    @IBOutlet weak var content2: HintTextView!
    
    
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
        
        content2.hintText = "投稿内容\n例文：これから展示回るの楽しみです！\n           毎日暑すぎ！ムリ！\n           今日は寝坊してしまい気分が落ち込んでいます。"

        //content2.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
         
        
    }

    @IBAction func buttonTapped(_ sender: Any) {
        superView.item.append([])
        superView.item[superView.item.count-1].append(name.text!)
        superView.item[superView.item.count-1].append(content2.text!)
        print(superView.item)
        
        let indexPath = IndexPath(row: superView.item.count - 1, section: 0)
        superView.tableView1.insertRows(at: [indexPath], with: .automatic)
        
        doPost(prompt: content2.text!)
        
        name.text = ""
        content2.text = ""
        content2.changeVisibility()
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


//以下プレーズホルダー付き、複数業テキストフィールドクラス
@IBDesignable
class HintTextView: UITextView {
    
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
    
    // 追記: テキストの初期値を入れるときは textViewDidChange が発火しないのでこちらのメソッドを使用する
    // （もっと良い方法がありそうですが...）
    func setText(_ text: String) {
        self.text = text
        changeVisibility()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
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
}

extension HintTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // 3. TextView に文字が入力されているかどうかで Label の表示/非表示を切り替える
        changeVisibility()
    }
}

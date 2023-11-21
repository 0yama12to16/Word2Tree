//
//  httpModule.swift
//  Word2Tree
//
//  Created by ToyaOyama on 2023/10/24.
//

import Foundation
import Alamofire

var domain: String = "http://192.168.0.2"
var port: String = "5000"

//Done
func postListNo(listNo: Int){
    let uri = domain+":"+port+"/postListNo?listNo="+String(listNo)
    AF.request(uri, method: .get, encoding: JSONEncoding.default, headers: nil).response { response in
        print(response.value!!)
    }
}

//Done
func postPosLeaf(x: Double, y: Double){
    let uri = domain+":"+port+"/postPosLeaf?x="+String(x)+"&y="+String(y)
    AF.request(uri, method: .get, encoding: JSONEncoding.default, headers: nil).response { response in
        print(response.value!!)
    }
}

//response:image of wood, EmoO
func getEmoO(emoNoS: Int,content: String,viewController: ViewController){
    var uri: String!
//    if let data = content.data(using: .utf8) {
//        if let utf8String = String(data: data, encoding: .utf8) {
//            uri = domain+":"+port+"/getEmoO?emoNoS="+String(emoNoS)+"&content="+utf8String // 結果を出力する
//        }
//    }
    let encoded: String = content.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
    uri = domain+":"+port+"/getEmoO?emoNoS="+String(emoNoS)+"&content="+encoded

    AF.request(uri, method: .get, encoding: JSONEncoding.default, headers: nil).response { response in
        if let data = response.data {
            if (Int(String(data: data, encoding: .utf8)!) == -1){
            }
            else{
                print(String(data: data, encoding: .utf8)!.split(separator: ",")[0].split(separator: ":")[1].count)
                
                let jsonObject = try? JSONDecoder.init().decode(ResModel.self, from: data)
                //print(jsonObject)
                let newWood: UIImage = convertBase64ToImage(jsonObject!.image)!
                viewController.secondVC.imageView.image = newWood
                viewController.emotionList.append(emoNoS)
                viewController.emotionListO.append(jsonObject!.EmoS)
                viewController.inputcell.addingCell()
                viewController.item.append("")
                viewController.item[viewController.item.count-1].append(content)
                let indexPath = IndexPath(row: viewController.item.count - 1, section: 0)
                viewController.tableView1.insertRows(at: [indexPath], with: .automatic)
            }
        }
    }
}

//バイナリ配列(Base64からUIImageに変換)
private func convertBase64ToImage(_ base64String: String) -> UIImage? {
    guard let imageData = Data(base64Encoded: base64String) else { return nil }
    return UIImage(data: imageData)
}

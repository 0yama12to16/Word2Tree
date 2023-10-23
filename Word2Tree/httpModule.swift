//
//  httpModule.swift
//  Word2Tree
//
//  Created by ToyaOyama on 2023/10/24.
//

import Foundation
import Alamofire

var domain: String = "http://localhost"
var port: String = "5000"

func postListNo(listNo: Int){
    let uri = domain+":"+port+"/postListNo?listNo="+String(listNo)
    AF.request(uri, method: .get, encoding: JSONEncoding.default, headers: nil).response { response in
        print(response.value!!)
    }
}

func postPosLeaf(x: Double, y: Double){
    let uri = domain+":"+port+"/postPosLeaf?x="+String(x)+"&y="+String(y)
    AF.request(uri, method: .get, encoding: JSONEncoding.default, headers: nil).response { response in
        print(response.value!!)
    }
}

func getEmoO(emoNoS: Int,content: String){
    let uri = domain+":"+port+"/getEmoO?emoNoS="+String(emoNoS)+"&content="+String(content)
    AF.request(uri, method: .get, encoding: JSONEncoding.default, headers: nil).response { response in
        print(response.value!!)
    }
}

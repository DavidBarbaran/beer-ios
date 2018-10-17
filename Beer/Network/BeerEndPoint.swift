//
//  BeerEndPoint.swift
//  Beer
//
//  Created by Melanie on 10/17/18.
//

import Foundation
import Alamofire
import SwiftyJSON

class BeerEndPoint {
    static func loginUser(email: String, completionHandler: @escaping(_ userKey:String?, _ password: String?, _ idUser:Int?, _ error: String?)->Void) {
        Alamofire.request("\(BeerAPI.baseURL)\(BeerAPI.loginURL)\(email)").responseJSON { (response) in
            switch response.result {
            case .success:
                let data = JSON(response.data!)
                if data.isEmpty {
                    completionHandler(nil,nil,nil, "Usuario no registrado")
                    return
                }else {
                    let key = data.dictionaryValue.keys.first!
                    completionHandler(key,data[key]["password"].stringValue,data[key]["id"].intValue,nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
    }
}

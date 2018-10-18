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
    
    static func createUser(user: User, completionHandler: @escaping(_ newIdUser: String?, _ error: String?) -> Void){
        let url = String(format: "\(BeerAPI.baseURL)\(BeerAPI.userURL)")
        let parameters: [String: Any] = [
            "email" : user.email,
            "birthdate": user.birthdate,
            "id" : 0,
            "lastname" : user.lastname,
            "name": user.name,
            "password" : user.password,
            "question" : user.question,
            "answer" : user.answer]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                let data = JSON(response.data!)
                completionHandler(data.stringValue, nil)
                print(data)
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(nil,"No se pudo registrar")
            }

        }
    }
    
    static func getSecurityQuestions(completionHandler: @escaping(_ questions: [JSON]?, _ error: String?)->Void) {
        Alamofire.request("\(BeerAPI.baseURL)\(BeerAPI.questionsURL)").responseJSON { (response) in
            switch response.result {
            case .success:
                let data = JSON(response.data!)
                let questionsArray = data.arrayValue.map({$0["question"]})
                completionHandler(questionsArray, nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    
}

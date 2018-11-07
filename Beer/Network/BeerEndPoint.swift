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
    static func loginUser(email: String, completionHandler: @escaping(_ user: User?, _ error: String?)->Void) {
        Alamofire.request("\(BeerAPI.baseURL)\(BeerAPI.loginURL)\(email)").responseJSON { (response) in
            switch response.result {
            case .success:
                let data = JSON(response.data!)
                if data.isEmpty {
                    completionHandler(nil, "Usuario no registrado")
                    return
                }else {
                    let key = data.dictionaryValue.keys.first!
                    print(key)
                    completionHandler(User.from(json: data[key]), nil)
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
            "answer" : user.answer,
            "urlImage": user.urlImage]
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
                let questionsArray = data.arrayValue.map{$0["question"]}
                completionHandler(questionsArray, nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getDrinks(completionHandler: @escaping(_ products: [Product]?, _ error: String?) -> Void) {
        Alamofire.request("\(BeerAPI.baseURL)\(BeerAPI.drinksURL)").responseJSON { (response) in
            switch response.result {
            case .success:
                let data = JSON(response.data!)
                let keys = data.dictionaryValue.keys
                var products: [Product] = []
                keys.forEach{
                    let prod = Product.from(json: data[$0])
                    products.append(prod)
                }
                completionHandler(products,nil)
            case .failure(let error):
                completionHandler(nil,"No se puede obtener las bebidas\(error.localizedDescription)")
            }
        }
    }
    
    static func getDrinks(withFilter filter: String, completionHandler: @escaping(_ products: [Product]?, _ error: String?)-> Void) {
        Alamofire.request("\(BeerAPI.baseURL)\(BeerAPI.filterDrinksURL)\(filter)").responseJSON { (response) in
            switch response.result {
            case .success:
                let data = JSON(response.data!)
                let keys = data.dictionaryValue.keys
                var products: [Product] = []
                keys.forEach{
                    let prod = Product.from(json: data[$0])
                    products.append(prod)
                }
                completionHandler(products, nil)
//                dump(products)
            case .failure(let error):
                completionHandler(nil,"No se puede obtener las bebidas\(error.localizedDescription)")
            }

        }
    }
}

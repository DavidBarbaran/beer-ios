//
//  Product.swift
//  Beer
//
//  Created by Melanie on 10/26/18.
//

import Foundation
import  SwiftyJSON

class Product {
    var id: Int
    var name: String
    var category: String
    var description: String
    var image: String
    var isOffer: Bool
    var price: Double
    var offer: Int
    
    
    init(id: Int, name: String, category: String, description: String, image: String, isOffer: Bool, price: Double, offer: Int) {
        self.id = id
        self.name = name
        self.category = name
        self.description = name
        self.image = image
        self.isOffer = isOffer
        self.offer = offer
        self.price = price
    }
    
    static func from(json: JSON) -> Product {
        return Product.init(id: json["id"].intValue, name: json["name"].stringValue, category: json["category"].stringValue, description: json["description"].stringValue, image: json["image"].stringValue, isOffer: json["isOffer"].boolValue, price: json["price"].doubleValue, offer: json["offer"].intValue)
    }
    
}

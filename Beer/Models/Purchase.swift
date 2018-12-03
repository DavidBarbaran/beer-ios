import Foundation
import SwiftyJSON

class Purchase {
    var idPurchase: String
    
    init(idPurchase: String) {
        self.idPurchase = idPurchase
    }
    
    static func from(json: JSON) -> Purchase {
        return Purchase.init(idPurchase: json["_id"].stringValue)
    }
    
    static func from(jsonArray: [JSON]) -> [Purchase] {
        var resultArray: [Purchase]  = []
        jsonArray.forEach({resultArray.append(Purchase.from(json: $0))})
        return resultArray
    }
}

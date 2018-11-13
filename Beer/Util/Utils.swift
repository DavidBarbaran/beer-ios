//
//  Utils.swift
//  Beer
//
//  Created by Melanie on 11/7/18.
//

import Foundation
import UIKit

class Utils {
    static func randomNumber(MIN: Int, MAX: Int)-> Int{
        return Int(arc4random_uniform(UInt32(MAX-MIN)) + UInt32(MIN));
    }
    
    static func changeBorderOnEdit(sender: HoshTextField) {
        sender.borderActiveColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
        sender.borderInactiveColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
        sender.placeholderColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
    }
}

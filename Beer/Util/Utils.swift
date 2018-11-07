//
//  Utils.swift
//  Beer
//
//  Created by Melanie on 11/7/18.
//

import Foundation

class Utils {
    static func randomNumber(MIN: Int, MAX: Int)-> Int{
        return Int(arc4random_uniform(UInt32(MAX-MIN)) + UInt32(MIN));
    }
}

//
//  Preference.swift
//  Beer
//
//  Created by Melanie on 10/29/18.
//

import Foundation

class userPreference {
    static let sharedInstance = userPreference()
    init() {}
    var userName: String?
    var userLastname: String?
    var userDate: String?
}

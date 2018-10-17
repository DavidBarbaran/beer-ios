//
//  User.swift
//  Beer
//
//  Created by Melanie on 10/17/18.
//

import Foundation

class User {
    var name: String
    var lastname: String
    var birthdate: String
    var email: String
    var password: String
    
    
    init(name: String, lastname:String, birthdate:String, email:String, password:String) {
        self.name = name
        self.lastname = lastname
        self.birthdate = birthdate
        self.email = email
        self.password = password
    }
}

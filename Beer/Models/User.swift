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
    var question: String
    var answer: String
    
    init(name: String, lastname:String, birthdate:String, email:String, password:String, question: String, answer: String) {
        self.name = name
        self.lastname = lastname
        self.birthdate = birthdate
        self.email = email
        self.password = password
        self.question = question
        self.answer = answer
    }
}

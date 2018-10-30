//
//  BeerAPI.swift
//  Beer
//
//  Created by Melanie on 10/16/18.
//

import Foundation

class BeerAPI {
    
    static let baseURL = "https://beer-a2751.firebaseio.com/"
//    https://beer-a2751.firebaseio.com/user.json?print=pretty&orderBy="email"&equalTo="david@gmail.com"
    static let userURL = "user.json"
    static let loginURL = "user.json?print=pretty&orderBy=%22email%22&equalTo="
    static let questionsURL = "security_questions.json"
    static let drinksURL = "drink.json"
    static let filterDrinksURL = "drink.json?orderBy=%22category%22&equalTo="

//    https://beer-a2751.firebaseio.com/security_questions.json
}



//
//  CSProfile.swift
//  BetLive
//
//  Created by Mohammed  Ibrahem on 7/14/19.
//  Copyright © 2019 Mohammed  Ibrahem. All rights reserved.
//

import Foundation

class CSProfile {
    var pID:String = ""
    var pUUID:String = ""
    var fName:String = ""
    var lName:String = ""
    var email:String = ""
    var password:String = ""
    var imageURL:String = ""
    var birthDay:Date = Date.init()
    var lastlogin:Date = Date.init()
    var isDoctor:String = ""
    var isAdmin:Bool = false
    var loginType:String = ""
    var phone:String = ""
    var stutes:Bool = false
    
    
    
    
    func toArray() -> [String : Any] {
        return [
        "pID" :pID
        ,"pUUID" : pUUID
        ,"fName" : fName
        ,"lName" : lName
        ,"email" : email
        ,"password" : password
        ,"imageURL" : imageURL
        ,"birthDay" : birthDay.description
        ,"lastlogin" : lastlogin.description
        ,"isDoctor" : isDoctor
        ,"isAdmin" : isAdmin
        ,"loginType" : loginType
        ,"phone" : phone
        ,"stutes" : stutes
        ]
        
        
    }
}


//
//  CSPetCatogry.swift
//  BetLive
//
//  Created by Mohammed  Ibrahem on 7/10/19.
//  Copyright © 2019 Mohammed  Ibrahem. All rights reserved.
//

import Foundation


class CSPetCatogry {
    var cID:Int32 = 0
    var cName:String = " "
    var cDescription:String = " "
    var cNotes:String = " "
    var cImgURl:[String] = [" "]
    var cPerentID:Int32 = -1
    
    
    
    func toArray() -> [String : Any] {
       return ["cID":cID,
        "cName": cName,
        "cDescription": cDescription,
        "cNotes": cNotes,
        "cPerentID": cPerentID,
        "cImgURl": cImgURl]
       
    }
}

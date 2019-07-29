//
//  CSMessages.swift
//  BetLive
//
//  Created by Mohammed  Ibrahem on 7/27/19.
//  Copyright © 2019 Mohammed  Ibrahem. All rights reserved.
//

import Foundation

class CSMessage:NSObject {
    var MID:String = " "
    var UName:String = ""
    var Message:String = ""
    var Date:String = ""
    var Replays:[String:String] = [" ":" "]
    
    
    func toArray() -> [String : Any] {
        return ["MID":MID,
                "UName": UName,
                "Message": Message,
                "Date": Date,
                "Replays": Replays
            ]
        
    }
}

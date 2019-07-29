//
//  CSMessagesList.swift
//  BetLive
//
//  Created by Mohammed  Ibrahem on 7/27/19.
//  Copyright © 2019 Mohammed  Ibrahem. All rights reserved.
//

import Foundation
import FirebaseDatabase

class CSMessageList{
    var messagesList:[CSMessage] = [CSMessage]()
    var message:CSMessage = CSMessage()
    
    func add() {
        messagesList.append(message)
    }
    
    func insertToDB() {
        let arr:[String] = ["Messages",message.UName]
        let dict = message.toArray()
        let dealDB = CSDealWithDB()
        dealDB.addToFireBaseDB(refArr: arr , dict: dict , autoID: true)
    }
    
    func retriveUserMessage(completion: @escaping (Bool) -> ()){
        let arr:[String] = ["Messages",message.UName]
        let dealDB = CSDealWithDB()
        messagesList.removeAll()
        dealDB.FetchFromFireBaseDB(refArr: arr){ (snapshot) in
            if snapshot != nil{
                if let snapshots = snapshot!.children.allObjects as? [DataSnapshot]{
                    for snap in snapshots {
                        let msg = CSMessage()
                        let value = snap.value as? NSDictionary
                        //msg.MID = value?["cID"] as? Int32 ?? 0
                        msg.Message = value?["Message"] as? String ?? ""
                        msg.Date = value?["Date"] as? String ?? ""
                        msg.Replays = value?["Replays"] as? [String:String] ?? ["":""]
                        msg.UName = value?["UName"] as? String ?? ""
                        self.messagesList.append(msg)
                    }
                }
            completion(true)
            }
        }
    }
        
        
        
        
        /*{ (snapshot) in
            
            let snapshots = snapshot!.children.allObjects as? [String:CSMessage]
            print(snapshots)
            let dic = snapshot!.value as? [String:AnyObject]
            CSMessage.setValuesForKeys(dic!)
        }
 */
    // FIXME: - fix next function
//    func retriveAllCatogriesDB(completion: @escaping (Bool) -> ()) {
//        let arr:[String] = ["Catogries"]
//
//        let dealDB = CSDealWithDB()
//        dealDB.FetchFromFireBaseDB(refArr: arr) { (snapshot) in
//            if snapshot != nil{
//                if let snapshots = snapshot!.children.allObjects as? [DataSnapshot]{
//                    for snap in snapshots{
//                        let catogry = CSPetCatogry()
//                        let value = snap.value as? NSDictionary
//                        catogry.cID = value?["cID"] as? Int32 ?? 0
//                        catogry.cName = value?["cName"] as? String ?? ""
//                        catogry.cDescription = value?["cDescription"] as? String ?? ""
//                        catogry.cNotes = value?["cNotes"] as? String ?? ""
//                        catogry.cPerentID = value?["cPerentID"] as? Int32 ?? -1
//                        catogry.cImgURl = value?["cImgURl"] as? [String] ?? [""]
//
//                        self.petCatogriesList.append(catogry)
//                    }
//                }
//                completion(true)
//            }
//            else {print("errrrrrrrrror ")}
//        }
//    }
//
//    func getMessage(withPID:Int32) -> [CSPetCatogry]{
//        var catogries  = [cspetCatogry]
//        for catogry in petCatogriesList {
//            if (catogry.cPerentID == withPID){
//                catogries.append(catogry)
//            }
//        }
//        catogries.remove(at: 0)
//        return catogries
//    }
//
//    func getParentID(withID:Int32) -> Int32{
//        var pID:Int32 = 0
//        for catogry in petCatogriesList {
//            if (catogry.cID == withID){
//                pID = catogry.cPerentID
//                return pID
//            }
//        }
//        return pID
//
//    }
}

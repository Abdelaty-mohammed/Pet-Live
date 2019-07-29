//
//  CSPetCatogriesList.swift
//  BetLive
//
//  Created by Mohammed  Ibrahem on 7/12/19.
//  Copyright © 2019 Mohammed  Ibrahem. All rights reserved.
//

import Foundation
import FirebaseDatabase


class CSPetCatogriesList{
    var petCatogriesList:[CSPetCatogry] = [CSPetCatogry]()
    
    func add(catogry:CSPetCatogry) {
        petCatogriesList.append(catogry)
    }
    
    func insertToDB(catogry:CSPetCatogry) {
        let arr:[String] = ["Catogries",String(catogry.cID)]
        let dict = catogry.toArray()
        let dealDB = CSDealWithDB()
        dealDB.addToFireBaseDB(refArr: arr , dict: dict)
    }
    
    func retriveAllCatogriesDB(completion: @escaping (Bool) -> ()) {
        let arr:[String] = ["Catogries"]

        let dealDB = CSDealWithDB()
        dealDB.FetchFromFireBaseDB(refArr: arr) { (snapshot) in
            if snapshot != nil{
                if let snapshots = snapshot!.children.allObjects as? [DataSnapshot]{
                    for snap in snapshots{
                        let catogry = CSPetCatogry()
                        let value = snap.value as? NSDictionary
                        catogry.cID = value?["cID"] as? Int32 ?? 0
                        catogry.cName = value?["cName"] as? String ?? ""
                        catogry.cDescription = value?["cDescription"] as? String ?? ""
                        catogry.cNotes = value?["cNotes"] as? String ?? ""
                        catogry.cPerentID = value?["cPerentID"] as? Int32 ?? -1
                        catogry.cImgURl = value?["cImgURl"] as? [String] ?? [""]
                        
                        self.petCatogriesList.append(catogry)
                    }
                }
                completion(true)
            }
            else {print("errrrrrrrrror ")}
        }
    }
    
    func getCatogriew(withPID:Int32) -> [CSPetCatogry]{
        var catogries  = [cspetCatogry]
        for catogry in petCatogriesList {
            if (catogry.cPerentID == withPID){
                catogries.append(catogry)
            }
        }
        catogries.remove(at: 0)
        return catogries
    }
    
    func getParentID(withID:Int32) -> Int32{
        var pID:Int32 = 0
        for catogry in petCatogriesList {
            if (catogry.cID == withID){
                pID = catogry.cPerentID
                return pID
            }
        }
        return pID
        
    }
}

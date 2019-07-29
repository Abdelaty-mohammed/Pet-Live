//
//  CSProfileList.swift
//  BetLive
//
//  Created by Mohammed  Ibrahem on 7/14/19.
//  Copyright © 2019 Mohammed  Ibrahem. All rights reserved.
//

import Foundation
import Firebase

class CSProfileListxxxxxx{
    
    var ProfileList:[CSProfile] = [CSProfile]()

    func insertNew(profile :CSProfile){
        insertToDB(profile: profile)
        addToList(profile: profile)
    }
    
    func addToList(profile :CSProfile){
        ProfileList.append(profile)
    }
    
    func insertToDB(profile :CSProfile) {
        let arr:[String] = ["Profile",profile.pUUID]
        let dict = profile.toArray()
        let dealDB = CSDealWithDB()
        dealDB.addToFireBaseDB(refArr: arr , dict: dict)
    }
    
    func retriveAllProfilesDB(completion: @escaping (Bool) -> ()) {
        let arr:[String] = ["Profile"]
        
        let dealDB = CSDealWithDB()
        dealDB.FetchFromFireBaseDB(refArr: arr) { (snapshot) in
            if snapshot != nil{
                if let snapshots = snapshot!.children.allObjects as? [DataSnapshot]{
                    for snap in snapshots{
                        let profile = CSProfile()
                        let value = snap.value as? NSDictionary
                        
                        profile.pID = value?["pID"] as? String ?? ""
                        profile.pUUID = value?["pUUID"] as? String ?? ""
                        profile.fName = value?["fName"] as? String ?? ""
                        profile.lName = value?["lName"] as? String ?? ""
                        profile.email = value?["email"] as? String ?? ""
                        profile.password = value?["password"] as? String ?? ""
                        profile.imageURL = value?["imageURL"] as? String ?? ""
                        profile.birthDay = value?["birthDay"] as? Date ?? Date.init()
                        profile.lastlogin = value?["lastlogin"] as? Date ?? Date.init()
                        profile.isAdmin = value?["isAdmin"] as? Bool ?? false
                        profile.isDoctor = value?["isDoctor"] as? String ?? ""
                        profile.loginType = value?["loginType"] as? String ?? ""
                        profile.phone = value?["phone"] as? String ?? ""
                        profile.stutes = value?["stutes"] as? Bool ?? false
                        
                        self.ProfileList.append(profile)
                    }
                }
                completion(true)
            }
            else {print("errrrrrrrrror ")}
        }
    }
    
    func getProfile(withUUID:String) -> CSProfile{
        let profile = CSProfile()
        for p in ProfileList {
            if (p.pUUID == withUUID){
                return p
            }
        }
        return profile
    }
}

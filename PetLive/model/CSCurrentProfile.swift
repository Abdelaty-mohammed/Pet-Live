//
//  CSCurrentProfile.swift
//  BetLive
//
//  Created by Mohammed  Ibrahem on 7/14/19.
//  Copyright © 2019 Mohammed  Ibrahem. All rights reserved.
//

import Foundation
import Firebase

class CSCurrentProfile{
    
    var cProfile = CSProfile()
    
    func loginByEmail(completion: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: cProfile.email, password: cProfile.password) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completion(false)
            } else {
                self.cProfile.pID = Auth.auth().currentUser!.uid
                print(Auth.auth().currentUser!.email ?? "")
                completion(true)
            }
        }
    }
    
    
    func registerByEmail(completion: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: cProfile.email, password: cProfile.password) {(authResult, error) in
            if let user = authResult?.user {
                self.cProfile.pID = user.uid
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func isLogin() -> Bool {
        guard let email = Auth.auth().currentUser?.email else { return false}
        
        if  email.contains("@"){
            cProfile.pID = Auth.auth().currentUser!.uid
            return true
        }
        
        return false
    }
    
    func signOutByEmail(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func insertToDB() {
        let arr:[String] = ["cProfile",cProfile.pID]
        let dict = cProfile.toArray()
        let dealDB = CSDealWithDB()
        dealDB.addToFireBaseDB(refArr: arr , dict: dict)
    }
    
    func updatePassword(completion: @escaping (_ success: Bool) -> Void){
        Auth.auth().currentUser?.updatePassword(to: cProfile.password, completion: { (error) in
            if error != nil {
                completion(false)
            }
            else {completion(true)}
        })
    }
    
    func loadCProfileBypID()
    {
        let arr:[String] = ["cProfile",self.cProfile.pID]
        
        let dealDB = CSDealWithDB()
        dealDB.FetchByKey(refArr: arr, Complication: { (snapshot) in
            if ( snapshot!.exists() ) {
                print(snapshot?.childrenCount as Any)
                //in case there are several skillets
                    let value = snapshot?.value as? NSDictionary
                    self.cProfile.pUUID = value?["pUUID"] as? String ?? ""
                    self.cProfile.fName = value?["fName"] as? String ?? ""
                    self.cProfile.lName = value?["lName"] as? String ?? ""
                    self.cProfile.email = value?["email"] as? String ?? "123"
                    self.cProfile.password = value?["password"] as? String ?? ""
                    self.cProfile.imageURL = value?["imageURL"] as? String ?? ""
                    //self.cProfile.birthDay = value?["birthDay"] as? Date ?? Date.init()
                    //self.cProfile.lastlogin = value?["lastlogin"] as? Date ?? Date.init()
                    self.cProfile.isAdmin = value?["isAdmin"] as? Bool ?? false
                    self.cProfile.isDoctor = value?["isDoctor"] as? String ?? ""
                    self.cProfile.loginType = value?["loginType"] as? String ?? ""
                    self.cProfile.phone = value?["phone"] as? String ?? ""
                    self.cProfile.stutes = value?["stutes"] as? Bool ?? false
            } else {
                print("Skillet was not found")
            }
        })
    }
    
    
}



//    func registerByEmail(){

//        Auth.auth().createUser(withEmail: cProfile.email   , password: cProfile.password) { authResult, error in
//            if error == nil {
//                print("register success >>> \(String(describing: authResult?.additionalUserInfo?.description))")
//                    self.cProfile.pID = Auth.auth().currentUser!.uid
//            } else {
//                print(error!.localizedDescription)
//                return
//            }
//
//            print("login successfully ") // ...
//            // ...
//        }
//    }

//    func loginByEmail(){
//        Auth.auth().signIn(withEmail: cProfile.email, password: cProfile.password) { [weak self] user, error in
//            guard self != nil else {
//                print(error!.localizedDescription)
//                return
//            }
//            print("login successfully ")// ...
//            self!.cProfile.pID = Auth.auth().currentUser!.uid
//            print(self!.cProfile.pID)
//            print(Auth.auth().currentUser!.displayName)
//            print(Auth.auth().currentUser!.email)
//            print(Auth.auth().currentUser!.isEmailVerified)
//            print(Auth.auth().currentUser!.phoneNumber)
//        }
//    }

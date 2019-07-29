//
//  CSDealWithDB.swift
//  BetLive
//
//  Created by Mohammed  Ibrahem on 7/12/19.
//  Copyright © 2019 Mohammed  Ibrahem. All rights reserved.
//

import Foundation
import Firebase
import UIKit


class CSDealWithDB {
    var ref: DatabaseReference! = Database.database().reference()
    
    func addToFireBaseDB(refArr:[String],dict:[String:Any],autoID:Bool = false){
        for child in refArr {
            ref = ref.child(child)
        }
        if autoID {
            ref.childByAutoId().setValue(dict)
        } else {
            ref.setValue(dict)
        }
    }
        
    
    func FetchFromFireBaseDB(refArr:[String],Complication:@escaping (_ result:DataSnapshot?) ->() )  {
        for child in refArr {
            ref = ref.child(child)
        }
        
        //ref.child("Catogries").observe(.value, with: { (snapshot) in
        ref?.observe(.value, with: { (snapshot) in
            //let x = snapshot.value
            //print(x as Any)
            //let value = snapshot.children.allObjects
            Complication(snapshot)
        }){
            (error) in
            print(error.localizedDescription)
        }
    }
    
    func FetchByValue(refArr:[String] ,searchValue:String,Complication:@escaping (_ result:DataSnapshot?) ->() )  {
        for index in 1..<refArr.count-1 {
            ref = ref.child(refArr[index])
        }
        ref.queryOrdered(byChild: refArr[refArr.count-1]).queryEqual(toValue: searchValue)
            .observe(.value, with: { snapshot in
                if ( snapshot.exists() ) {
                    Complication(snapshot)
//                    for child in snapshot.children {
//                    in case there are several skillets
//                        let key = (child as AnyObject).key as String
//                        print(key)
//                    }
                } else {
                    print("Skillet was not found")
                }
            })
    }
    
    func FetchByKey(refArr:[String],Complication:@escaping (_ result:DataSnapshot?) ->() )  {
        for child in refArr {
            ref = ref.child(child)
        }
        ref.observe(.value, with: { snapshot in
            if ( snapshot.exists() ) {
                print(snapshot)
                Complication(snapshot)
    //                    for child in snapshot.children {
    //                    in case there are several skillets
    //                        let key = (child as AnyObject).key as String
    //                        print(key)
    //                    }
            } else {
                print("value was not found")
            }
        })
    }
    
    func saveImgeUrl(toRefLocation:[String] , dict:[String:Any]){
        addToFireBaseDB(refArr: toRefLocation, dict: dict)
        
    }
    
    
   
    
}


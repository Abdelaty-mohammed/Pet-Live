//
//  insertToDB.swift
//  BetLive
//
//  Created by Mohammed  Ibrahem on 7/12/19.
//  Copyright © 2019 Mohammed  Ibrahem. All rights reserved.
//

import Foundation
import UIKit

class EntryDataToDB{
    
    static func EntryCatogriesToDB() {
        var cspetCatogry:CSPetCatogry = CSPetCatogry()
        cspetCatogry.cID = 1
        cspetCatogry.cName = "Dogs"
        cspetCatogry.cDescription = "Everyone knows that dogs are man’s best friend, and for good reason. They are loyal, charming and quite lovable. Children love them and they make a great addition to any family. Remember, as a dog owner you must properly care for the animal. Some pets can be left to their own devices for a day or two, but that’s not the case with dogs. You have to really care for your pet and love it, feed it, walk it, take the time to train your dog properly and provide it a good home."
        cspetCatogry.cImgURl[0]="https://firebasestorage.googleapis.com/v0/b/petlive-f9757.appspot.com/o/dogs.jpg?alt=media&token=1e047e2e-08a4-4009-bc55-850259407436"
        //        cspetCatogry.cImgURl.append("www.1yahoo1.com")
        //        cspetCatogry.cImgURl.append("www.1yahoo2.com")
        //        cspetCatogry.cImgURl.append("www.1yahoo3.com")
        cspetCatogry.cPerentID = 0
        cspetCatogry.cNotes = "1"
        petCatogryList.add(catogry: cspetCatogry)
        petCatogryList.insertToDB(catogry: cspetCatogry)

        
        cspetCatogry = CSPetCatogry()
        cspetCatogry.cID = 2
        cspetCatogry.cName = "Cats"
        cspetCatogry.cDescription = "Cats also make a fantastic pet, and the beauty of this majestic animal is that it’s quite independent. Depending on your particular needs, you can have an indoor or an outdoor cat. Indoor cats certainly require much more attention than an outdoor cat, but ultimately they are very easy to care for in either circumstance.As far as small pets go, cats are easy to care for and they do not require as much attention as dogs. You can leave a cat home alone for one night as long as there’s enough food and water available. It would be a good idea to change the litter box before going out for the night."
        cspetCatogry.cImgURl[0] = "https://firebasestorage.googleapis.com/v0/b/petlive-f9757.appspot.com/o/imagesc.jpg?alt=media&token=b56c74b9-12f6-48ef-b298-b3740fd12f3b"
        //        cspetCatogry.cImgURl.append("www.2yahoo1.com")
        //        cspetCatogry.cImgURl.append("www.2yahoo2.com")
        //        cspetCatogry.cImgURl.append("www.2yahoo3.com")
        cspetCatogry.cPerentID = 0
        cspetCatogry.cNotes = "2"
        petCatogryList.add(catogry: cspetCatogry)
        petCatogryList.insertToDB(catogry: cspetCatogry)

        //
        cspetCatogry = CSPetCatogry()
        cspetCatogry.cID = 3
        cspetCatogry.cName = "Fish"
        cspetCatogry.cDescription = "This is another very popular one of many house pets. You’ll need to feed them, change the water at certain times, and clean the tank every once in a while. But other than that, fish can ultimately be left to their own devices. They make great pets and they really add flair to your home decor."
    cspetCatogry.cImgURl[0]="https://firebasestorage.googleapis.com/v0/b/petlive-f9757.appspot.com/o/fish.jpg?alt=media&token=cb5fc9dd-6e53-45ca-b0e3-1a0ddf60eabe"
    cspetCatogry.cImgURl.append("https://firebasestorage.googleapis.com/v0/b/petlive-f9757.appspot.com/o/fishpng.png?alt=media&token=a395620d-333a-4dc0-b06c-08d29d93ac0d")
        //        cspetCatogry.cImgURl.append("www.3yahoo2.com")
        //        cspetCatogry.cImgURl.append("www.3yahoo3.com")
        cspetCatogry.cPerentID = 0
        cspetCatogry.cNotes = "3"
        petCatogryList.add(catogry: cspetCatogry)
        petCatogryList.insertToDB(catogry: cspetCatogry)
        
        
        
        //        petCatogry.retriveDB(withCPID: 0)
        //        print(petCatogry.CatogryLists.count)
    }
//    static func uploadimage(withUrl urlString : String) -> String! {
//        let image = UIImageView()
//        image.loadImageUsingCache(withUrl:urlString)
//        CSDealWithSorage.upload(image: image.image!){
//            url in
//            return url
//        }
//        return ""
//    }
}

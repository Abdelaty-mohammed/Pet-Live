//
//  VCLoading.swift
//  BetLive
//
//  Created by Mohammed  Ibrahem on 7/13/19.
//  Copyright © 2019 Mohammed  Ibrahem. All rights reserved.
//

import UIKit

class VCLoading: UIViewController   {
    
    @IBOutlet weak var gifView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //GetGUID()
        if currentProfile.isLogin() {
            currentProfile.loadCProfileBypID()
        }
        if currentProfile.cProfile.pID == "" {
             self.performseque(identifier: "SIDShowAuthLogin")
        }
        gifView.loadGif(name: "giphy")
        
        petCatogryList.retriveAllCatogriesDB { success in
            guard success == true else {return}
            mList.message.UName = "Mabdelaty"
            print(mList.message.UName)
            mList.retriveUserMessage(completion: { success in
                self.performseque(identifier: "SIDShowCatogries")
            })
        }
    }
//    override func viewDidAppear(_ animated: Bool) {
//        if CheckInternet.Connection(){
//            self.Alert(Message: "Connected")
//        }
//        else{
//            self.Alert(Message: "Your Device is not connected with internet")
//        }
//    }
    func performseque(identifier:String){
        switch identifier {
        case "SIDShowCatogries":
            performSegue(withIdentifier:identifier, sender:self)
            
        case "SIDShowAuthLogin":
            performSegue(withIdentifier:identifier, sender:self)
            
        default: break
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="SIDShowCatogries" {
            gifView.removeFromSuperview()
        }
        if segue.identifier=="SIDShowAuthLogin" {
            if let vc = segue.destination as? VCLoginAuth{
                vc.CState = .stander
            }
            
        }
        
    }
    
    func GetGUID() {
        if let uuid = UIDevice.current.identifierForVendor?.uuidString {
            print("your uuid is :\(uuid)")
        }
    }
}

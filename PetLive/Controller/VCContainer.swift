//
//  VCContainer.swift
//  BetLive
//
//  Created by Mohammed  Ibrahem on 7/10/19.
//  Copyright © 2019 Mohammed  Ibrahem. All rights reserved.
//

import UIKit

class VCContainer: UIViewController {

    
    @IBOutlet weak var sideConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         NotificationCenter.default.addObserver(self, selector: #selector(ToggleSideMenu), name: NSNotification.Name(rawValue: "SideMenu"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(showScreen), name: NSNotification.Name("Profile"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showSetting), name: NSNotification.Name("Setting"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(signOut), name: NSNotification.Name("signOut"), object: nil)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="SIDShowProfile" {
            if let vc = segue.destination as? VCLoginAuth{
                vc.CState = .viewProfile
            }
            
        }
        
    }
    
    @objc func showScreen(){
        performSegue(withIdentifier: "SIDShowProfile", sender: self)
    }
    @objc func showSetting(){
        print("setting")
    }
    @objc func signOut() {
        currentProfile.signOutByEmail()
    }
    

    var sideMenuFlag = false
    
    @objc func ToggleSideMenu() {
        if sideMenuFlag == true {
            sideConstraint.constant = -200
        }
        else{
            sideConstraint.constant = 0
        }
        
        sideMenuFlag = !sideMenuFlag
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        NotificationCenter.default.post(name: NSNotification.Name("LoadProfileImage"), object: nil)

    }
}

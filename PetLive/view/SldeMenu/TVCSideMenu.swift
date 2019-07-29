//
//  TVCSideMenu.swift
//  BetLive
//
//  Created by Mohammed  Ibrahem on 7/11/19.
//  Copyright © 2019 Mohammed  Ibrahem. All rights reserved.
//

import UIKit

class TVCSideMenu: UITableViewController {
    
    
    @IBOutlet weak var imgVProfile: UIImageView!
    override func viewDidLoad() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadProfileImage), name: NSNotification.Name("LoadProfileImage"), object: nil)

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        NotificationCenter.default.post(name: NSNotification.Name("SideMenu"), object: nil)
        
        switch indexPath.row {
        case 1: NotificationCenter.default.post(name: NSNotification.Name("Profile"), object: nil)
        case 2: NotificationCenter.default.post(name: NSNotification.Name("Setting"), object: nil)
        case 3: NotificationCenter.default.post(name: NSNotification.Name("signOut"), object: nil)
        default: break
            
        }
    }
    
    @objc func loadProfileImage(){
        imgVProfile.loadImageUsingCache(withUrl: currentProfile.cProfile.imageURL)
    }
}

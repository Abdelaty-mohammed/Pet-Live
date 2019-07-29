//
//  VCMoreDetails.swift
//  Movies&Stars
//
//  Created by Mohammed  Ibrahem on 7/1/19.
//  Copyright © 2019 Mohammed  Ibrahem. All rights reserved.
//

import UIKit
import WebKit

class VCMoreDetails: UIViewController {

    @IBOutlet weak var ScrollVMImages: UIScrollView!
    @IBOutlet weak var nBar: UINavigationItem!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var textVDescription: UITextView!
    
    
    var catogryDetails : CSPetCatogry!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadScrollView()
        reloadMoreDetails()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnShowQA(_ sender: Any) {
        
        mList.retriveUserMessage { success in
            guard success == true else {return}
            self.performSegue(withIdentifier: "SIDShowDetails", sender: self)
        }
    }
    
    func reloadScrollView()  {
        for i in 0..<catogryDetails.cImgURl.count {
            let imageView=UIImageView()
            imageView.contentMode = .scaleToFill
            
            let CatogryImgURl = catogryDetails.cImgURl[0]
            
            imageView.loadImageUsingCache(withUrl: CatogryImgURl)
            
            let xPos = CGFloat(i)*self.view.bounds.size.width
            
            imageView.frame = CGRect(x: xPos + 5, y: 0, width: view.frame.size.width - 10, height: ScrollVMImages.frame.size.height)
            
            ScrollVMImages.contentSize.width=view.frame.size.width*CGFloat(i+1)
            
            ScrollVMImages.addSubview(imageView)
        }
    }
    
    func reloadMoreDetails()  {
        nBar.title = catogryDetails.cName
        lblTitle.text = catogryDetails.cName
        lblNotes.text = catogryDetails.cNotes
        textVDescription.text = catogryDetails.cDescription
    }
}


//
//  ViewController.swift
//  BetLive
//
//  Created by Mohammed  Ibrahem on 7/10/19.
//  Copyright © 2019 Mohammed  Ibrahem. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var myImageView: UIImageView!
    var imagePicker: UIImagePickerController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imagePicker=UIImagePickerController()
        imagePicker.delegate=self
        
        //Chooseimage()
        //EntryDataToDB.EntryCatogriesToDB()
        

    
    }
    func Chooseimage(){
        present(imagePicker, animated: true, completion: nil)
    }
    func downloadimage(){
        
        myImageView.loadImageUsingCache(withUrl: "https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?cs=srgb&dl=beauty-bloom-blue-67636.jpg&fm=jpg")
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            myImageView.image = image
            
//            upload(image: myImageView.image!){
//                url in
//                self.saveImge(profileUrl: url!) { success in
//                    if success != nil {
//                        print("success")
//                    }
//                }
//            }
            
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    
    @IBAction func temp(_ sender: Any) {
        
       //EntryDataToDB.EntryCatogriesToDB()
    
    }
    
    
    
    
    
    var alertController:UIAlertController!
    func showaction(){
    alertController=UIAlertController(title:"Send me Via", message:"You can send me via email or Imessage ", preferredStyle:UIAlertController.Style.actionSheet)
    
    
    let emailAction=UIAlertAction(title:"Email", style:UIAlertAction.Style.default){
        (action)->Void in
        print("Send the File Via emial")
    }
    
    let imessageAction=UIAlertAction(title:"iMessage", style:UIAlertAction.Style.default){
        (action)->Void in
        print("Send teh file via imessage")
    }
    
    
    let cancelAction=UIAlertAction(title:"Cancel", style:UIAlertAction.Style.cancel){
        (action)->Void in
        print("actionSheet was Canceled")
    }
    
    alertController.addAction(emailAction)
    alertController.addAction(imessageAction)
    alertController.addAction(cancelAction)
    
}
    @IBAction func showActionsheet(_ sender: Any) {
    
    let alertController=UIAlertController(title:"BriefOS", message:"Hello World ", preferredStyle: .actionSheet)
    
    alertController.addAction(UIAlertAction(title:"OK", style:.default, handler:self.okHandler))
    
    
    alertController.addAction(UIAlertAction(title:"Cancel", style:.cancel, handler:nil))
    
    self.present(alertController, animated:true, completion:nil)
    
}
    func okHandler(alert:UIAlertAction!){
    
    self.navigationController?.pushViewController(UIViewController(), animated:true)
}
    


}


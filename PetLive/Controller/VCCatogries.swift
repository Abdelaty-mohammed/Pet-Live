//
//  CVControllerCatogries.swift
//  BetLive
//
//  Created by Mohammed  Ibrahem on 7/11/19.
//  Copyright © 2019 Mohammed  Ibrahem. All rights reserved.
//

import UIKit


var petCatogryList = CSPetCatogriesList()
var cspetCatogry = CSPetCatogry()

class CVControllerCatogries: UICollectionViewController {

    var imagePicker: UIImagePickerController!

    let reuseIdentifier = "CellCatogry"
    
    var subCatogry = [cspetCatogry]
    
    var parentID : Int32 = 0
    var lastParnetID : Int32 = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        //cspetCatogry.retriveDB(withCPID: parentID)
        //cspetCatogry.CatogryLists.append()
        //EntryDataToDB.EntryCatogriesToDB()
        //petCatogryList.retriveAllCatogries()
        reloadCollectionView()
    }
    
    func reloadCollectionView(){
        self.subCatogry = petCatogryList.getCatogriew(withPID: self.parentID)
        self.collectionView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return subCatogry.count
        }
        else { return 1 }
        
    }

   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if indexPath.section == 0 {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CVCellCatogries

        let CatogryImgURl = subCatogry[indexPath.row].cImgURl[0]
    
        cell.lblCatogryName.text = subCatogry[indexPath.row].cName
        cell.imageVCatogory.loadImageUsingCache(withUrl: CatogryImgURl)
        return cell
    }
    else {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BackToPerent", for: indexPath)
        if(parentID != 0) {
            cell.isHidden = false
        }
        else {cell.isHidden = true}
        return cell
        }
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.section == 0)
        {
            
            // FIXME: bug parentID
            
            parentID = subCatogry[indexPath.row].cID
            cspetCatogry = subCatogry[indexPath.row]
            subCatogry = petCatogryList.getCatogriew(withPID: parentID)
            if subCatogry.count == 0 {
                
                performSegue(withIdentifier:"SIDShowDetails", sender:self)
                parentID = cspetCatogry.cPerentID
                subCatogry.append(cspetCatogry)
            }
            else {
                lastParnetID = parentID
                self.collectionView.reloadData()
            }
        }
    }

    @IBAction func btnBackToHome(_ sender: Any) {
        
        if(subCatogry.count == 0 ){
            parentID = lastParnetID
        } else {
            parentID = petCatogryList.getParentID(withID: lastParnetID)
            lastParnetID = parentID
        }
        reloadCollectionView()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier=="SIDShowDetails"
        {
            if let VCMDetails=segue.destination as? VCMoreDetails{
                VCMDetails.catogryDetails = cspetCatogry
            }
            
        }
    }
    
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    
    
    func ChooseImages(){
        
       present(imagePicker, animated: true, completion: nil)
//
        
        
//        myImageView.loadImageUsingCache(withUrl: "https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?cs=srgb&dl=beauty-bloom-blue-67636.jpg&fm=jpg")


    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[.originalImage] as? UIImage {
////            profile.image = image
//        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func btnTabMore(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("SideMenu"), object: nil)
    }
    
}

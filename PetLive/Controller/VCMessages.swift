//
//  VCMessages.swift
//  BetLive
//
//  Created by Mohammed  Ibrahem on 7/26/19.
//  Copyright © 2019 Mohammed  Ibrahem. All rights reserved.
//

import UIKit

class VCMessages: UIViewController,UITableViewDelegate,UITableViewDataSource , UINavigationControllerDelegate{
    
    var expandedCellIndex : Int = -1

    @IBOutlet weak var TVMessage : UITableView!
    @IBOutlet weak var VQuestion: UIView!
    
    @IBOutlet weak var LCTopHeight: NSLayoutConstraint!
    
    @IBOutlet weak var txvMessage: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TVMessage.rowHeight = UITableView.automaticDimension
        TVMessage.estimatedRowHeight = 40
        
        TVMessage.dataSource = self
        TVMessage.delegate = self
        
        hidePopUp()
        
        addKeyboardObserver()
        
        TVMessage.reloadData()

        

    }
    
    
    //FIXME: - add real username
    @IBAction func btnCommitMSG(_ sender: Any) {
        mList.message.UName = currentProfile.cProfile.fName + currentProfile.cProfile.lName
        mList.message.Message = txvMessage.text!
        mList.message.Date = Date.init().description
        mList.add()
        mList.insertToDB()
        hidePopUp()
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        hidePopUp()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {return mList.messagesList.count}
        else {return 1}
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RIDMessageCell", for: indexPath) as! TVCellMessage
            let t0 = [ NSAttributedString.Key.foregroundColor: UIColor.red ,
                       NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 16.0)!]
            
            let Q0 = NSMutableAttributedString(string: "\t \t \t ---- Your Questions ---- \n ", attributes: t0 )
            let Q1 = NSAttributedString(string: mList.messagesList[indexPath.row].Message)
            let Questions = NSMutableAttributedString()
            
            Questions.append(Q0)
            Questions.append(Q1)
            
            cell.lblUserName.text = mList.messagesList[indexPath.row].UName
            cell.lblPostDate.text = mList.messagesList[indexPath.row].Date
            cell.lblMessageTitle.attributedText = Questions
            
            let AnwserAttributed = NSMutableAttributedString()
            let t1 = NSMutableAttributedString(string: "\t \t \t ---- Doctor Replays ---- \n ", attributes: t0 )
            AnwserAttributed.append(t1)
            
            for item in mList.messagesList[indexPath.row].Replays {
                
                let t3 = NSMutableAttributedString(string: item.key + " : ", attributes: t0)
                let t4 = NSAttributedString(string: item.value)
                
                AnwserAttributed.append(t3)
                AnwserAttributed.append(t4)
            }
            cell.lblAnswer.attributedText = AnwserAttributed
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RIDAdd", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            if let cell = tableView.cellForRow(at: indexPath) as? TVCellMessage {
                cell.VExpandedCell.isHidden = !cell.VExpandedCell.isHidden
                if currentProfile.cProfile.isDoctor == "1"{
                    cell.VDoctorReplayCell.isHidden = !cell.VDoctorReplayCell.isHidden
                }
                
                if !cell.VExpandedCell.isHidden {
                    expandedCellIndex = indexPath.row
                }
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }
        else {
            showPopUp()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt
        indexPath: IndexPath) {
        if indexPath.section == 0 {
            expandedCellIndex = indexPath.row
            let cell = tableView.cellForRow(at: indexPath) as? TVCellMessage
            cell?.VExpandedCell.isHidden = true
            cell?.VDoctorReplayCell.isHidden = true
        }
        
    }
    
    func showPopUp(){
        LCTopHeight.constant = 185
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.6 , initialSpringVelocity: 0 ,options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func hidePopUp(){
        LCTopHeight.constant = 1000
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.6 , initialSpringVelocity: 0 ,options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    // MARK: - for keyboard
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func removeKeyboardObservers(){
        NotificationCenter.default.removeObserver(self,forKeyPath: UIResponder.keyboardWillShowNotification.rawValue)
        NotificationCenter.default.removeObserver(self,forKeyPath: UIResponder.keyboardWillHideNotification.rawValue)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
                LCTopHeight.constant = 40
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
            LCTopHeight.constant = 185
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func resignTextFieldFirstResponders() {
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
    }
    func resignAllFirstResponders() {
        view.endEditing(true)
    }
    //end for keyboard

    

}

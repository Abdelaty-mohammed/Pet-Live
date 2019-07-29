//
//  VCLoginAuth.swift
//  BetLive
//
//  Created by Mohammed  Ibrahem on 7/14/19.
//  Copyright © 2019 Mohammed  Ibrahem. All rights reserved.
//

// FIXME: bug XYZ
// TODO: add configuration code
// MARK: - Properties
// MARK: Methods
// MARK: - Methods
import UIKit

//MARK: - Public Variable
enum CurrentState {
    case stander
    case login
    case register
    case viewProfile
    case EditProfile
}

class VCLoginAuth: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    // MARK: - Variable
    var isCompleate:Bool = false
    var isChangeProfileImage = false
    var CState:CurrentState = CurrentState.stander
    var message:String = ""
    
    var imagePicker: UIImagePickerController!
    
    // MARK: - IBOutlet
    @IBOutlet weak var ImgVProfile: UIImageView!
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var SCisDoctor: UISegmentedControl!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPassword2: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnChangeImage: UIButton!
    
    @IBOutlet weak var topConstraintHight: NSLayoutConstraint!
    @IBOutlet weak var tobLogoConstrainHight: NSLayoutConstraint!
    
    //MARK: - Init    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        addKeyboardObserver()
        
        prepareImagePicker()
        
        prepareView()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //removeKeyboardObservers()
    }
    
    // MARK: - IBAction
    @IBAction func btnShowLoginPop(_ sender: Any) {
        CState = .login
        ShowPopUp()
    }
    
    @IBAction func btnSignByFBTabed(_ sender: Any) {
       ////// temp signout
        currentProfile.signOutByEmail()
    }
    @IBAction func btnShowRegister(_ sender: Any) {
        CState = .register
        ShowPopUp()
    }
    
    @IBAction func btnRigister(_ sender: Any) {
        btnAction()
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        switch CState {
        case .viewProfile:
            dismissView()
            break
        case .EditProfile:
            CState = .viewProfile
            ShowPopUp()
            break
        case .stander:
            fallthrough
        case .login:
            fallthrough
        case .register:
            hidePopUP()
            view.endEditing(true)
            CState = .stander
        }
    }
    
    @IBAction func btnChangeImage(_ sender: Any) {
        Chooseimage()
    }
    
    // MARK: - Methods
    
    func register(){
        currentProfile.cProfile.fName = txtFName.text ?? " "
        currentProfile.cProfile.lName = txtLName.text ?? " "
        currentProfile.cProfile.email = txtEmail.text ?? " "
        currentProfile.cProfile.phone = txtPhone.text ?? " "
        currentProfile.cProfile.isDoctor = String( SCisDoctor.selectedSegmentIndex)
        currentProfile.cProfile.password = txtPassword.text ?? " "
        currentProfile.cProfile.loginType = "Email"
        
        currentProfile.cProfile.lastlogin = Date()
        
        
        if let _ = txtEmail.text, let _ = txtPassword.text {
            currentProfile.registerByEmail() {(success) in
                //guard let `self` = self else { return }
                if (success) {
                    self.message = "User was sucessfully created."
                    self.isCompleate = true
                     currentProfile.insertToDB()
                } else {
                    self.message = "There was an error."
                }
                self.showAlert()
            }
        }

        if currentProfile.cProfile.pID != "" {
            CState = .login
        }else {
            CState = .EditProfile
        }
    }
    
    func login(){
        if validateion() {
            currentProfile.loginByEmail() { (success) in
               // guard let self = nil else { return }
                if (success) {
                    self.isCompleate = true
                    currentProfile.loadCProfileBypID()
                    self.message = "User was sucessfully logged in."
                } else {
                    self.message = "There was an error."
                }
            }
        }
        else {message = "Please Check your E-mail and Password"
        }
        
        showAlert()
        
    }
    
    func updateProfile(){
        currentProfile.cProfile.fName = txtFName.text!
        currentProfile.cProfile.lName = txtLName.text!
        currentProfile.cProfile.phone = txtPhone.text!
        if txtPassword.text != ""{
            currentProfile.cProfile.password = txtPassword.text!
            currentProfile.updatePassword { (done) in
                self.isCompleate = done
            }
        }
        
        if isChangeProfileImage {
            isChangeProfileImage = false
            ImgVProfile.uploadToFireDB(image: ImgVProfile.image!) { (urlString) in
                if urlString != nil {
                    currentProfile.cProfile.imageURL = urlString!
                    print(urlString!)
                }
            }
        }
        if isCompleate {
            currentProfile.insertToDB()
        }

    }
    
    func validateion()->Bool{
        guard let email = txtEmail.text else { return false}
        guard let password = txtPassword.text else { return false}
        if email != "" && password != "" {
            currentProfile.cProfile.email = email
            currentProfile.cProfile.password = password
            return true
        }
        return false
    }
    
    func fillViewData(){
        txtFName.text = currentProfile.cProfile.fName
        txtLName.text = currentProfile.cProfile.lName
        txtEmail.text = currentProfile.cProfile.email
        txtPhone.text = currentProfile.cProfile.phone
        if currentProfile.cProfile.isDoctor == "0"
        {SCisDoctor.selectedSegmentIndex = 0}
        else if currentProfile.cProfile.isDoctor == "1"
        {SCisDoctor.selectedSegmentIndex = 1}
        ImgVProfile.loadImageUsingCache(withUrl: currentProfile.cProfile.imageURL)
    }
    
    func ShowPopUp() {
        if CState != .login {
            txtFName.isHidden = false
            txtLName.isHidden = false
            txtPhone.isHidden = false
            SCisDoctor.isHidden = false
            txtPassword2.isHidden = false
            btnChangeImage.isHidden = true
        }
        
        switch CState {
        case .login :
            txtFName.isHidden = true
            txtLName.isHidden = true
            txtPhone.isHidden = true
            SCisDoctor.isHidden = true
            txtPassword2.isHidden = true
            txtEmail.text = ""
            txtPassword.text = ""
            
            btnRegister.setTitle("Login",for: .normal)
            break
        case .register:
            btnRegister.setTitle("Register",for: .normal)
            break
        case .EditProfile :
            btnRegister.setTitle("Save",for: .normal)
            txtFName.isEnabled = true
            txtLName.isEnabled = true
            txtEmail.isEnabled = true
            txtPhone.isEnabled = true
            SCisDoctor.isEnabled = true
            txtPassword.isHidden = false
            txtPassword2.isHidden = false
            btnChangeImage.isHidden = false
            
            fillViewData()
            break
        case .viewProfile :
            btnRegister.setTitle("Edit",for: .normal)
            txtFName.isEnabled = false
            txtLName.isEnabled = false
            txtEmail.isEnabled = false
            txtPhone.isEnabled = false
            SCisDoctor.isEnabled = false
            txtPassword.isHidden = true
            txtPassword2.isHidden = true
            fillViewData()
            break
        case .stander:
            break
        }
        topConstraintHight.constant = 320
        tobLogoConstrainHight.constant = -270
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.6 , initialSpringVelocity: 0 ,options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func hidePopUP() {
        topConstraintHight.constant = 850
        tobLogoConstrainHight.constant = -120
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6 , initialSpringVelocity: 0 ,options: .curveLinear, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func prepareView(){
        switch CState {
        case .stander     : hidePopUP()
        case .login       : ShowPopUp()
        case .register    : ShowPopUp()
        case .EditProfile : ShowPopUp()
        case .viewProfile : ShowPopUp()
        }
    }
    
    func showAlert(){
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated:true, completion:nil)
        message = " "
    }
    
    func btnAction(){
        switch CState {
        case .register:
            register()
        case .login :
            login()
            hidePopUP()
            break
        case .EditProfile :
            updateProfile()
            break
        case .viewProfile :
            CState = .EditProfile
            break
        case .stander:
            break
        }
        if isCompleate {
            isCompleate = false
            if CState != .viewProfile {
                dismissView()
            }
        }
        else {
            ShowPopUp()
        }
    }
    
    func dismissView(){
        self.dismiss(animated: true) {
        }
    }
    // MARK: - Change Profile Image
    func prepareImagePicker(){
        imagePicker=UIImagePickerController()
        imagePicker.delegate=self
    }
    
    func Chooseimage(){
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            ImgVProfile.image = image
            isChangeProfileImage = true
            imagePicker.dismiss(animated: true, completion: nil)
        }
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
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
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

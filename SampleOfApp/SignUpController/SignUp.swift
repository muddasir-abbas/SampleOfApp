//
//  SignUp.swift
//  SampleOfApp
//
//  Created by Macbook on 18/01/2024.
//

import FlagPhoneNumber
import Firebase
import UIKit
import FlagPhoneNumber
import FirebaseAuth
import SkyFloatingLabelTextField
import SVProgressHUD

class SignUp: UIViewController, FPNTextFieldDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var shadowColor: UIView!
    @IBOutlet weak var classTxtFldView: RoundView!
    @IBOutlet weak var emailTxtFldView: RoundView!
    @IBOutlet weak var phnNoTxtFldView: RoundView!
    @IBOutlet weak var paswrdTxtFldView: RoundView!
    @IBOutlet weak var rapeatPaswrdTxtFldView: RoundView!
    @IBOutlet weak var slctQuestionTxtFldView: RoundView!
    @IBOutlet weak var yourQuestionTxtFldView: RoundView!
    @IBOutlet weak var answerTxtFldView: RoundView!
    @IBOutlet weak var classTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var countryCodeTxtFld: FPNTextField!
    @IBOutlet weak var phonNoTxtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTxtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var emaiTxtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var repeatPasswordTxtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordBtnFirst: UIButton!
    @IBOutlet weak var passwordBtnSecond: UIButton!
    @IBOutlet weak var selectquestionTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var yourquestionTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var answerTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var clickterm: UIButton!
    
    var textSecure:Bool = true
    var tickBtn = false
    
    override func viewDidLoad() {
        self.emaiTxtFld.delegate = self
        self.classTextField.delegate = self
        self.passwordTxtFld.delegate = self
        self.repeatPasswordTxtFld.delegate = self
        self.phonNoTxtFld.delegate = self
        self.selectquestionTextField.delegate = self
        self.repeatPasswordTxtFld.delegate = self
        self.yourquestionTextField.delegate = self
        
        super.viewDidLoad()
        super.viewDidLoad()
        shadowColor.layer.shadowColor = UIColor.gray.cgColor
        shadowColor.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        shadowColor.layer.shadowOpacity = 0.7
        shadowColor.layer.shadowRadius = 4.0
        shadowColor.layer.cornerRadius = 5
        
        self.passwordTxtFld.delegate = self
        self.passwordBtnFirst.setImage(UIImage(named: "pass_hide"), for: .normal)
        self.passwordTxtFld.isSecureTextEntry = true
        self.passwordBtnSecond.setImage(UIImage(named: "pass_hide"), for: .normal)
        //            self.clickBtnView.setImage(UIImage(named: "unclickOnTick"), for: .normal)
        self.repeatPasswordTxtFld.isSecureTextEntry = true
        passwordTxtFld.isSecureTextEntry.toggle()
        repeatPasswordTxtFld.isSecureTextEntry.toggle()
        
        
        self.countryCodeTxtFld.delegate = self
        self.countryCodeTxtFld.setFlag(key: .US)
        self.countryCodeTxtFld.placeholder = ""
        self.countryCodeTxtFld.addTarget(self, action: #selector(showCountryList), for: .touchUpInside)
        classTextField.placeholder = "Full Name"
        
        emaiTxtFld.placeholder = "Email"
        
        passwordTxtFld.lineView.isHidden = true
        emaiTxtFld.lineView.isHidden = true
        phonNoTxtFld.lineView.isHidden = true
        repeatPasswordTxtFld.lineView.isHidden = true
        selectquestionTextField.lineView.isHidden = true
        yourquestionTextField.lineView.isHidden = true
        classTextField.lineView.isHidden = true
        answerTextField.lineView.isHidden = true
        
        passwordTxtFld.placeholder = "Password"
        
        repeatPasswordTxtFld.placeholder = "Repeat Password"
        
        selectquestionTextField.placeholder = "Select question"
        yourquestionTextField.placeholder = "Your question"
        answerTextField.placeholder = "answer"
        
        phonNoTxtFld.placeholder = "Phone Number"
        
        navigationController?.isNavigationBarHidden = false
        
        let imgview = UIImageView()
        imgview.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        imgview.image = UIImage(named: "mail")
        
        let leftView = UIBarButtonItem(customView: imgview)
        self.navigationItem.rightBarButtonItem = leftView
    }

    @IBAction func nextBtn(_ sender: Any) {
        let username: String = self.classTextField.text!.trim
        let email: String = self.emaiTxtFld.text!.trim
        let password: String = self.passwordTxtFld.text!
        let phoneNo: String = self.phonNoTxtFld.text!.trim
//        SVProgressHUD.show()
        LoginAndRegistrationReqModel.sharedModel().initSignUp(username:username, email:email, phoneNO: phoneNo, password:password, completion: { (status, response, error) in
            if(status) {
                let success = response!.value(forKey: "success") as! Bool
                let message = response!.value(forKey: "message") as! String
                if(success) {
                    SVProgressHUD.dismiss()
                    uDefaults.set("showTips", forKey: "showTips")
                    uDefaults.synchronize()
                    do {
                        var userJson = response!.value(forKey: "user") as! [String: Any]
                        userJson["unverified_email"] = ""
                        userJson["unverified_phone"] = ""
                        let userdata = try JSONSerialization.data(withJSONObject: userJson, options: [])
                        var user = try Utility.shared().decoder.decode(User.self, from: userdata)
                        SVProgressHUD.showSuccess(withStatus: message)
                        let phone = user.phone
                        user.unverified_phone = phone
                        //                        let email = user.email
                        //                        user.unverified_email = email
                        //                        Utility.setCustomObject(user, forKey: "user")
                        //                        appDelegate!.launchApp(isFromSignin: false)
                    }
                    catch {
                        print(error)
                    }
                }
                else {
                    SVProgressHUD.showError(withStatus: message)
                    print("message", message)
                }
            }
            else {
                print("errorr", error!.localizedDescription)
                SVProgressHUD.showError(withStatus: error!.localizedDescription)
            }
        })
    }
    
    @IBAction func cnfgrationBtn(_ sender: Any) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let signupVC = sb.instantiateViewController(withIdentifier: "Verification") as! Verification
        self.navigationController?.pushViewController(signupVC, animated: true)
        
    }
    @IBAction func clickOnShowBtn(_ sender: UIButton) {
        
        if (tickBtn == false)
        {
            sender.setImage(UIImage(named: "clickOnTick"), for: .normal)
            tickBtn = true
        }
        else
        {
            sender.setImage(UIImage(named: "unclickOnTick"), for: .normal)
            tickBtn = false
            
        }
    }

    @IBAction func passwordShowHideBtn(_ sender: UIButton)
    {
        if(sender.image(for: .normal)==UIImage(named: "pass_hide"))
        {
            sender.setImage(UIImage(named: "pass_show"), for: .normal)
            self.passwordTxtFld.isSecureTextEntry = false
        }
        else
        {
            sender.setImage(UIImage(named: "pass_hide"), for: .normal)
            self.passwordTxtFld.isSecureTextEntry = true
        }
    }
    @IBAction func passwordBtnSecond(_ sender: UIButton) {
        
        if(sender.image(for: .normal)==UIImage(named: "pass_hide"))
        {
            sender.setImage(UIImage(named: "pass_show"), for: .normal)
            self.repeatPasswordTxtFld.isSecureTextEntry = false
        }
        else
        {
            sender.setImage(UIImage(named: "pass_hide"), for: .normal)
            self.repeatPasswordTxtFld.isSecureTextEntry = true
        }
    }
    @objc func showCountryList() {
        let listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
        
        self.countryCodeTxtFld.displayMode = .list
        
        listController.setup(repository: self.countryCodeTxtFld.countryRepository)
        listController.didSelect = { [weak self] country in
            self?.countryCodeTxtFld.setFlag(countryCode: country.code)
        }
    }
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print("ok")
    }
    
    func fpnDidValidatePhoneNumber(textField: FlagPhoneNumber.FPNTextField, isValid: Bool) {
        print("ok")
    }
    
    func fpnDisplayCountryList() {
        print("ok")
    }
    @IBAction func btnnxt(_ sender: Any) {
        guard let username = classTextField.text, !username.isEmpty else {
            showAlert(message: "Please enter your full name")
            return
        }

        guard let email = emaiTxtFld.text, !email.isEmpty else {
            showAlert(message: "Please enter your email")
            return
        }

        guard let password = passwordTxtFld.text, !password.isEmpty else {
            showAlert(message: "Please enter a password")
            return
        }

        guard let repeatPassword = repeatPasswordTxtFld.text, !repeatPassword.isEmpty else {
            showAlert(message: "Please repeat the password")
            return
        }

        guard let phoneNo = phonNoTxtFld.text, !phoneNo.isEmpty else {
            showAlert(message: "Please enter your phone number")
            return
        }

        guard let selectedQuestion = selectquestionTextField.text, !selectedQuestion.isEmpty else {
            showAlert(message: "Please select a security question")
            return
        }

        // Check if the passwords match
        if password != repeatPassword {
            showAlert(message: "Passwords do not match")
            return
        }

        // Check if terms and conditions are accepted
        if !tickBtn {
            showAlert(message: "Please accept the terms and conditions")
            return
        }

        // If all validations pass, send verification code
        SVProgressHUD.dismiss()
                let Phone = self.phonNoTxtFld.text
        
                PhoneAuthProvider.provider().verifyPhoneNumber(Phone!, uiDelegate: nil) { (verificationID, error) in
        
                    if let error = error {
                        print(error)
                        let alert = UIAlertController(title: "Alert", message: "Code Send to the given number", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
        
                        print("error")
                        return
                    }
        
                    if let verificationID = verificationID {
                        print("")
                        UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                        let sb = UIStoryboard.init(name: "Main", bundle: nil)
                        let signupVC = sb.instantiateViewController(withIdentifier: "Verification") as! Verification
                        self.navigationController?.pushViewController(signupVC, animated: true)
                    }
                
        // Code to send verification code goes here...

        // Now, you can move to the next view controller
//        let sb = UIStoryboard.init(name: "Main", bundle: nil)
//        let signupVC = sb.instantiateViewController(withIdentifier: "Verification") as! Verification
//        self.navigationController?.pushViewController(signupVC, animated: true)
    }

    // Helper function to show an alert with a given message
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
        
//        let Phone = self.phonNoTxtFld.text
//        
//        PhoneAuthProvider.provider().verifyPhoneNumber(Phone!, uiDelegate: nil) { (verificationID, error) in
//            
//            if let error = error {
//                print(error)
//                let alert = UIAlertController(title: "Alert", message: "Code Send to the given number", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//                
//                print("error")
//                return
//            }
//            
//            if let verificationID = verificationID {
//                print("")
//                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
//                let sb = UIStoryboard.init(name: "Main", bundle: nil)
//                let signupVC = sb.instantiateViewController(withIdentifier: "Verification") as! Verification
//                self.navigationController?.pushViewController(signupVC, animated: true)
//            }
//        }
        
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            if textField == classTextField {
                classTxtFldView.cornerBorderColor = UIColor(red: 108/255, green: 169/255, blue: 237/255, alpha: 1)
            }
            else {
                
                classTxtFldView.cornerBorderColor = .gray
            }
            if textField == emaiTxtFld {
                self.emailTxtFldView.cornerBorderColor = UIColor(red: 108/255, green: 169/255, blue: 237/255, alpha: 1)
            }
            else {
                self.emailTxtFldView.cornerBorderColor = .gray
            }
            if textField == phonNoTxtFld {
                self.phnNoTxtFldView.cornerBorderColor = UIColor(red: 108/255, green: 169/255, blue: 237/255, alpha: 1)
            }
            else {
                self.phnNoTxtFldView.cornerBorderColor = .gray
            }
            if textField == passwordTxtFld {
                self.paswrdTxtFldView.cornerBorderColor = UIColor(red: 108/255, green: 169/255, blue: 237/255, alpha: 1)
            }
            else {
                self.paswrdTxtFldView.cornerBorderColor = .gray
            }
            if textField == repeatPasswordTxtFld {
                self.rapeatPaswrdTxtFldView.cornerBorderColor = UIColor(red: 108/255, green: 169/255, blue: 237/255, alpha: 1)
            }
            else {
                self.rapeatPaswrdTxtFldView.cornerBorderColor = .gray
            }
            if textField == selectquestionTextField {
                self.slctQuestionTxtFldView.cornerBorderColor = UIColor(red: 108/255, green: 169/255, blue: 237/255, alpha: 1)
            }
            else {
                self.slctQuestionTxtFldView.cornerBorderColor = .gray
            }
            if textField == yourquestionTextField {
                self.yourQuestionTxtFldView.cornerBorderColor = UIColor(red: 108/255, green: 169/255, blue: 237/255, alpha: 1)
            }
            else {
                self.yourQuestionTxtFldView.cornerBorderColor = .gray
            }
            if textField == answerTextField {
                self.answerTxtFldView.cornerBorderColor = UIColor(red: 108/255, green: 169/255, blue: 237/255, alpha: 1)
            }
            else {
                self.answerTxtFldView.cornerBorderColor = .gray
            }
            
        }
    }
}

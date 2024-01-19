//
//  phone.swift
//  SampleOfApp
//
//  Created by Macbook on 18/01/2024.
//


import Firebase
import FirebaseAuth
import UIKit
import SkyFloatingLabelTextField
import FlagPhoneNumber
import LocalAuthentication
import SVProgressHUD

class Forget: UIViewController, FPNTextFieldDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var emailTxtFldView: RoundView!
    @IBOutlet weak var numberTxtFldView: RoundView!
    @IBOutlet weak var emailView_height: NSLayoutConstraint!
    @IBOutlet weak var numberTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var phonNoView_height: NSLayoutConstraint!
    @IBOutlet weak var phonNoView: UIView!
    @IBOutlet weak var flagView: UIView!
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var countryCodeTxtFld: FPNTextField!
    @IBOutlet weak var emailViewline: SkyFloatingLabelTextField!
    
    var isFromEmail = true
    override func viewDidLoad() {
        super.viewDidLoad()
        viewShadow.layer.shadowColor = UIColor.gray.cgColor
        viewShadow.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewShadow.layer.shadowOpacity = 0.5
        viewShadow.layer.shadowRadius = 0.5
        viewShadow.layer.cornerRadius = 5

        navigationController?.isNavigationBarHidden = false
        self.emailViewline.delegate = self
        self.numberTextField.delegate = self
        self.countryCodeTxtFld.delegate = self
        self.countryCodeTxtFld.setFlag(key: .US)
        self.countryCodeTxtFld.placeholder = ""
        self.phonNoView.isHidden = true
        self.flagView.isHidden = true
        
        self.countryCodeTxtFld.addTarget(self, action: #selector(showCountryList), for: .touchUpInside)
        
        
        numberTextField.lineView.isHidden = true
        emailViewline.lineView.isHidden = true
        numberTextField.placeholder = "Phone Number"
        numberTextField.title = "Phone Number"
        
        let imgview = UIImageView()
        imgview.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        imgview.image = UIImage(named: "mail")
        let leftView = UIBarButtonItem(customView: imgview)
        self.navigationItem.rightBarButtonItem = leftView
        
        self.phonNoView.isHidden = false
        //        self.phonNoView_height.constant = 50
        self.flagView.isHidden = false
        //        self.flagView_height.constant = 50
        //        self.emailView.isHidden = true
        self.emailBtn.backgroundColor = .white
        self.emailBtn.setTitleColor(.black, for: .normal)
        self.phoneBtn.backgroundColor = .systemGray6
        self.phoneBtn.setTitleColor(.gray, for: .normal)
        
    }
    
    @IBAction func phoneBtn(_ sender: Any) {
        isFromEmail = false
        self.phonNoView.isHidden = false
        //        self.phonNoView_height.constant = 50
        self.flagView.isHidden = false
        self.emailView.isHidden = true
        self.phoneBtn.backgroundColor = .white
        self.phoneBtn.setTitleColor(.black, for: .normal)
        self.emailBtn.backgroundColor = .systemGray6
        self.emailBtn.setTitleColor(.gray, for: .normal)
    }
    @IBAction func emailBtn(_ sender: Any) {
        isFromEmail = true
        self.phonNoView.isHidden = true
        //        self.phonNoView_height.constant = 0
        self.flagView.isHidden = true
        //        self.flagView_height.constant = 0
        self.emailView.isHidden = false
        //        self.emailView_height.constant = 50
        self.emailBtn.backgroundColor = .white
        self.emailBtn.setTitleColor(.black, for: .normal)
        self.phoneBtn.backgroundColor = .systemGray6
        self.phoneBtn.setTitleColor(.gray, for: .normal)
    }
    // API
    @IBAction func sendEmailCode(_ sender: Any) {
        if(self.emailViewline.text!.trim == "") {
            SVProgressHUD.showError(withStatus: "Please enter email")
        }
        else if(self.emailViewline.text!.trim.isValidEmail == false) {
            SVProgressHUD.showError(withStatus: "Please enter valid an email")
        }
        else {
//            SVProgressHUD.show()
            LoginAndRegistrationReqModel.sharedModel().initForgetEmailCode(email: self.emailViewline.text!, completion: { (status, response, error) in
                if(status) {
                    let message = response!.value(forKey: "message") as! String
                    let success = response!.value(forKey: "success") as! Bool
                    if(success) {
                        SVProgressHUD.showSuccess(withStatus: message)
                        let sb = UIStoryboard.init(name: "Main", bundle: nil)
                        let Controller = sb.instantiateViewController(withIdentifier: "Verification") as! Verification
                        Controller.isFromForgot = true
                        Controller.forgotEmail = self.emailViewline.text!
                        Controller.requestToken = (response!.value(forKey: "request_token") as! String)
                        self.navigationController?.pushViewController(Controller, animated: true)
                    }
                    else {
                        SVProgressHUD.showError(withStatus: message)
                    }
                    print("message", message)
                }
                else {
                    print("errorr", error?.localizedDescription as Any)
                    SVProgressHUD.showError(withStatus: error!.localizedDescription)
                }
            })
        }
    }
    @objc func showCountryList() {
        var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
        
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
    @IBAction func btntouch(_ sender: UIButton) {
        
        guard let email = self.emailViewline.text, !email.isEmpty, let phone = self.numberTextField.text, !phone.isEmpty else {
              showAlert(message: "Please enter your Email and Phone number")
              return
          }

          SVProgressHUD.show()

          if isFromEmail {
              // Email-based password reset
              LoginAndRegistrationReqModel.sharedModel().initForgetEmailCode(email: email) { (status, response, error) in
                  SVProgressHUD.dismiss()

                  if status {
                      let message = response!.value(forKey: "message") as! String
                      let success = response!.value(forKey: "success") as! Bool

                      if success {
                          SVProgressHUD.showSuccess(withStatus: message)
                          let sb = UIStoryboard.init(name: "Main", bundle: nil)
                          let controller = sb.instantiateViewController(withIdentifier: "Verification") as! Verification
                          controller.isFromForgot = true
                          controller.forgotEmail = email
                          controller.requestToken = (response!.value(forKey: "request_token") as! String)
                          self.navigationController?.pushViewController(controller, animated: true)
                      } else {
                          SVProgressHUD.showError(withStatus: message)
                      }
                      print("message", message)
                  } else {
                      print("errorr", error?.localizedDescription as Any)
                      SVProgressHUD.showError(withStatus: error?.localizedDescription)
                  }
              }
          } else {
              // Phone-based password reset
              PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { (verificationID, error) in
                  SVProgressHUD.dismiss()

                  if let verificationID = verificationID {
                      print("")
                      UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                      let sb = UIStoryboard.init(name: "Main", bundle: nil)
                      let signupVC = sb.instantiateViewController(withIdentifier: "Verification") as! Verification
                      self.navigationController?.pushViewController(signupVC, animated: true)
                  }

                  if let error = error {
                      print(error)
                      self.showAlert(message: "Code sent to the given number")
                      print("error")
                      return
                  }
              }
          }
      }

      func showAlert(message: String) {
          let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          self.present(alert, animated: true, completion: nil)
      }
//        let Phone = self.numberTextField.text
//        
//        PhoneAuthProvider.provider().verifyPhoneNumber(Phone!, uiDelegate: nil) { (verificationID, error) in
//            if let verificationID = verificationID {
//                print("")
//                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
//                let sb = UIStoryboard.init(name: "Main", bundle: nil)
//                let signupVC = sb.instantiateViewController(withIdentifier: "Verification") as! Verification
//                self.navigationController?.pushViewController(signupVC, animated: true)
//            }
//            
//            if let error = error {
//                print(error)
//            let alert = UIAlertController(title: "Alert", message: "Code Send to given number", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//           
//                print("error")
//                return
//            }
//        }
//    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailViewline {
            emailTxtFldView.cornerBorderColor = UIColor(red: 108/255, green: 169/255, blue: 237/255, alpha: 1)
        }
        else {
            emailTxtFldView.cornerBorderColor = .gray
            self.numberTxtFldView.cornerBorderColor = UIColor(red: 108/255, green: 169/255, blue: 237/255, alpha: 1)
        }
        if textField == numberTextField {
            self.numberTxtFldView.cornerBorderColor = UIColor(red: 108/255, green: 169/255, blue: 237/255, alpha: 1)
        }
        else {
            self.numberTxtFldView.cornerBorderColor = .gray
        }
    }
}

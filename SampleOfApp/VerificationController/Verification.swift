//
//  Verification.swift
//  SampleOfApp
//
//  Created by Macbook on 18/01/2024.
//

import UIKit
//import DPOTPView
import AEOTPTextField
import FirebaseAuth
import LocalAuthentication
import SkyFloatingLabelTextField
import SVProgressHUD
class Verification: UIViewController, UITextViewDelegate, AEOTPTextFieldDelegate, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var timerBtn: UIButton!
    @IBOutlet weak var otpTxtFld: AEOTPTextField!
    @IBOutlet weak var countdownBtn: UIButton!
    
    private var authUser = Auth.auth().currentUser
    var countTimer:Timer!
    var counter = 6
    var restartTimer = false
    var isTimerRunning = false
    var isFromForgot:Bool = false
    var forgotEmail = ""
    var requestToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.dismiss()
        self.sendVerificationMail()
        otpTxtFld.otpDelegate = self
        otpTxtFld.configure(with: 6)
        otpTxtFld.otpDefaultCharacter = ""
        /// The default background color of the text field slots before entering a character
        otpTxtFld.otpBackgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        /// The default background color of the text field slots after entering a character
        otpTxtFld.otpFilledBackgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        /// The default corner raduis of the text field slots
        otpTxtFld.otpCornerRaduis = 10
        /// The default border color of the text field slots before entering a character
        otpTxtFld.otpDefaultBorderColor = .clear
        /// The border color of the text field slots after entering a character
        otpTxtFld.otpFilledBorderColor = .darkGray
        /// The default border width of the text field slots before entering a character
        otpTxtFld.otpDefaultBorderWidth = 0
        /// The border width of the text field slots after entering a character
        otpTxtFld.otpFilledBorderWidth = 1
        /// The default text color of the text
        otpTxtFld.otpTextColor = .black
        /// The default font size of the text
        otpTxtFld.otpFontSize = 14
        /// The default font of the text
        otpTxtFld.otpFont = UIFont.systemFont(ofSize: 14)
        if isTimerRunning == false {
            startTimer()
            
        }
        navigationController?.isNavigationBarHidden = false
        let imgview = UIImageView()
        imgview.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        imgview.image = UIImage(named: "mail")
        
        let leftView = UIBarButtonItem(customView: imgview)
        self.navigationItem.rightBarButtonItem = leftView
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func didUserFinishEnter(the code: String) {
        print("code",code)
    }
    
    @IBAction func btnTimmerPressed(_ sender: UIButton) {
        print("Ok")
        startTimer()
    }
    
    func startTimer() {
        self.countTimer = Timer.scheduledTimer(timeInterval: 1 , target: self, selector: #selector(changeTitle), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    @objc func changeTitle()
    {
        if counter != 0
        {
            timerBtn.setTitle("\(counter)", for: .normal)
            counter -= 1
            
        }  else {
            countTimer.invalidate()
            timerBtn.setTitle("06", for: .normal)
            counter = 6
        }
    }
    
    
    public func sendVerificationMail() {
        if self.authUser != nil && !self.authUser!.isEmailVerified {
            self.authUser!.sendEmailVerification(completion: { (error) in
                print("useremail",self.authUser?.email as Any)
//                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                let alert = UIAlertController(title: "Alert", message: "Code Send to the given number", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
                print("authUser",self.authUser?.email)
               
                // Notify the user that the mail has sent or couldn't because of an error.
            })
        }
        else {
            // Either the user is not available, or the user is already verified.
        }
    }
    
    @IBAction func BtnNxt(_ sender: Any) {
        
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        let verificationCode = self.otpTxtFld.text

                let credential = PhoneAuthProvider.provider().credential(
                    withVerificationID: verificationID!,
                    verificationCode: verificationCode!)

                Auth.auth().signIn(with: credential) { (user, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        print("OTP entered is incorrect")
                        let alert = UIAlertController(title: "Alert", message: "OTP entered is incorrect", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
//                        complition(false)
                        return
                    }
                    print("OTP entered is correct")
                    let sb = UIStoryboard.init(name: "Main", bundle: nil)
                    let signupVC = sb.instantiateViewController(withIdentifier: "VerificationScreen") as! VerificationScreen
                    self.navigationController?.pushViewController(signupVC, animated: true)
                    let alert = UIAlertController(title: "Alert", message: "Open Successfully", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
//                    complition(true)
                }

    }
    @IBAction func btnReSendPswrd(_ sender: Any) {
        self.sendEmailCode()
    }
    func sendEmailCode()
      {
          if(self.isFromForgot)
          {
              SVProgressHUD.show()
              LoginAndRegistrationReqModel.sharedModel().initForgetEmailCode(email: self.forgotEmail, completion: { (status, response, error) in
                  if(status)
                  {
                      let message = response!.value(forKey: "message") as! String
                      let success = response!.value(forKey: "success") as! Bool
                      if(success)
                      {
                          //self.navigationController?.popViewController(animated: true)
                          self.requestToken = response!.value(forKey: "request_token") as! String
                          SVProgressHUD.showSuccess(withStatus: message)
                      }
                      else
                      {
                          SVProgressHUD.showError(withStatus: message)
                      }
                      print("message", message)
                  }
                  else
                  {
                      print("errorr", error?.localizedDescription as Any)
                      SVProgressHUD.showError(withStatus: error!.localizedDescription)
                  }
              })
          }
          else
          {
              SVProgressHUD.show()
              LoginAndRegistrationReqModel.sharedModel().initSendEmailCode(completion: { (status, response, error) in
                  if(status)
                  {
                      let message = response!.value(forKey: "message") as! String
                      let success = response!.value(forKey: "success") as! Bool
                      if(success)
                      {
                          SVProgressHUD.showSuccess(withStatus: message)
                      }
                      else
                      {
                          SVProgressHUD.showError(withStatus: message)
                      }
                      print("message", message)
                  }
                  else
                  {
                      print("errorr", error?.localizedDescription as Any)
                      SVProgressHUD.showError(withStatus: error!.localizedDescription)
                  }
              })
          }
      }
}


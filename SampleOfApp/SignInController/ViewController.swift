//
//  Utility.swift
//  MobileApp
//
//  Created by Macbook on 5/10/23.
//


import UIKit
import Firebase
import GoogleSignIn
import SkyFloatingLabelTextField
import SVProgressHUD

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTxtFldView: RoundView!
    @IBOutlet weak var passwordTxtFldView: RoundView!
    @IBOutlet weak var gmailTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var passwordTextFld: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var viewForCornerRadius: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var window: UIWindow?
    var signInConfig: GIDConfiguration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewForCornerRadius.layer.cornerRadius = 25
        viewForCornerRadius.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewForCornerRadius.layer.masksToBounds = true
        
        gmailTextField.delegate = self
        passwordTextFld.delegate = self
        navigationController?.isNavigationBarHidden = true
        gmailTextField.lineView.isHidden = true
        passwordTextFld.lineView.isHidden = true
        gmailTextField.placeholder = "Gmail"
        gmailTextField.title = "Gmail"
        passwordTextFld.placeholder = "Password"
        passwordTextFld.largeContentTitle = "Password"
        btnLogin.addTarget(self, action: #selector(getter: btnLogin), for: .touchUpInside)
        self.signInConfig = GIDConfiguration(clientID: "1012107337274-g15mmrte1lmgl3oneeq1ueqbhqv1lj0c.apps.googleusercontent.com")
//        "1033637812380-4hg7oar92jot70667pc8aik6a3hukafb.apps.googleusercontent.com"
    }
    @IBAction func signUpBtn(_ sender: Any) {
                let sb = UIStoryboard.init(name: "Main", bundle: nil)
                let signupVC = sb.instantiateViewController(identifier: "Details") as!
                SignUp
                self.navigationController?.pushViewController(signupVC, animated: true)
            }
//
        @IBAction func forgotPasswordBtn(_ sender: Any) {
            
            let sb = UIStoryboard.init(name: "Main", bundle: nil)
            let signupVC = sb.instantiateViewController(withIdentifier: "phone") as! Forget
            self.navigationController?.pushViewController(signupVC, animated: true)
        }
        @IBAction func logInBtn(_ sender: Any) {
            if(self.gmailTextField.text!.trim == "") {
                SVProgressHUD.showError(withStatus: "Please enter user email")
            }
            else if(self.gmailTextField.text!.trim.isValidEmail == false) {
                SVProgressHUD.showError(withStatus: "Please enter valid email")
            }
            else if(self.passwordTextFld.text! == "") {
                SVProgressHUD.showError(withStatus: "Please enter password")
            }
            else {
                self.view.endEditing(true)
                self.userLogin()
            }
        }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == gmailTextField {
            emailTxtFldView.cornerBorderColor = UIColor(red: 108/255, green: 169/255, blue: 237/255, alpha: 1)
        }
        else {
            emailTxtFldView.cornerBorderColor = .gray
        }
        if textField == passwordTextFld {
            self.passwordTxtFldView.cornerBorderColor = UIColor(red: 108/255, green: 169/255, blue: 237/255, alpha: 1)
        }
        else {
            self.passwordTxtFldView.cornerBorderColor = .gray
          }
     }
    private func userLogin() {
        //self.btnSignIn.loadingIndicator(show: true, strTitleOfButton: "")
        let email: String = self.gmailTextField.text!
        let password: String = self.passwordTextFld.text!
//        SVProgressHUD.show()
        LoginAndRegistrationReqModel.sharedModel().initLogin(strEmail: email, strPassword: password, completion: { (status, response, error) in
            if(status) {
                let success = response!.value(forKey: "success") as! Bool
                let message = response!.value(forKey: "message") as! String
                if(success) {
                    SVProgressHUD.dismiss()
//                    uDefaults.set("showTips", forKey: "showTips")
//                    uDefaults.synchronize()
                    do {
                        var userJson = response!.value(forKey: "user") as! [String: Any]
                        userJson["unverified_email"] = ""
                        userJson["unverified_phone"] = ""
                        let userdata = try JSONSerialization.data(withJSONObject: userJson, options: [])
                        var user = try Utility.shared().decoder.decode(User.self, from: userdata)
                        let phone = user.phone
                        user.unverified_phone = phone
                        let email = user.email
                        user.unverified_email = email
                        SVProgressHUD.showSuccess(withStatus: "Login Sucessfully")
                        if(user.is_email_verified == 0 || user.is_phone_verified == 0)
                        {
                            Utility.setCustomObject(user, forKey: "user")
//                            appDelegate!.launchApp(isFromSignin: true)
                        }
                        
                        else
                        {
//                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                            let Controller: TermsAndConditionsController = storyboard.instantiateViewController(withIdentifier: "TermsAndConditionsController") as! TermsAndConditionsController
//                            Controller.userObject = user
//                            var navigationController = UINavigationController()
//                            navigationController = UINavigationController(rootViewController: Controller)
//                            navigationController.isNavigationBarHidden = true
//                            self.window = UIWindow(frame: UIScreen.main.bounds)
//                            self.window?.rootViewController = navigationController
//                            self.window?.makeKeyAndVisible()
                        }
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
                print("errorr", error?.localizedDescription as Any)
                SVProgressHUD.showError(withStatus: error!.localizedDescription)
            }
        })
    }
}


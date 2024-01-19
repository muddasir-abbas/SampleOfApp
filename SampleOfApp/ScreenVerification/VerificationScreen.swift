//
//  VerificationScreen.swift
//  SampleOfApp
//
//  Created by Macbook on 18/01/2024.
//

import UIKit
import LocalAuthentication
import SkyFloatingLabelTextField


class VerificationScreen: UIViewController {
    
    
    @IBOutlet weak var shadowColor: UIView!
    
    override func viewDidLoad() {
        shadowColor.layer.shadowColor = UIColor.black.cgColor
        shadowColor.layer.shadowOffset = CGSize(width: 3, height: 3)
        shadowColor.layer.shadowOpacity = 0.7
        shadowColor.layer.shadowRadius = 3.0
        shadowColor.layer.cornerRadius = 5

        navigationController?.isNavigationBarHidden = false
        let imgview = UIImageView()
        imgview.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        imgview.image = UIImage(named: "mail")
        let leftView = UIBarButtonItem(customView: imgview)
        self.navigationItem.rightBarButtonItem = leftView
//        shadowClr.layer.shadowColor = UIColor.black.cgColor
//        shadowClr.layer.shadowOpacity = 0.7
//        shadowClr.layer.shadowOffset = CGSize.zero
//        shadowClr.layer.shadowRadius = 4
//        shadowClr.layer.shadowPath = UIBezierPath(rect: shadowClr.bounds).cgPath
        
    }
    

    @IBAction func authenticateUser(_ sender: Any) {
        let context = LAContext()
        
        var error: NSError?
        
        if context.canEvaluatePolicy(
            LAPolicy.deviceOwnerAuthenticationWithBiometrics,
            error: &error) {
            
            // Device can use biometric authentication
            
        } else {
            // Device cannot use biometric authentication
            if let err = error {
                switch err.code{
                    
                case LAError.Code.biometryNotEnrolled.rawValue:
                    notifyUser("User is not enrolled",
                               err: err.localizedDescription)
                    
                case LAError.Code.passcodeNotSet.rawValue:
                    notifyUser("A passcode has not been set",
                               err: err.localizedDescription)
                    
                    
                case LAError.Code.biometryNotAvailable.rawValue:
                    notifyUser("Biometric authentication not available",
                               err: err.localizedDescription)
                default:
                    notifyUser("Unknown error",
                               err: err.localizedDescription)
                }
            }
        }
    }
    func notifyUser(_ msg: String, err: String?) {
        let alert = UIAlertController(title: msg,
                                      message: err,
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true,
                     completion: nil)
    }
    
    @IBAction func EnterBtnNxt(_ sender: Any) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let signupVC = sb.instantiateViewController(withIdentifier: "scanerQRCode") as! scanerQRCode
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @IBAction func authenticateUsr(_ sender: Any) {
        let context = LAContext()
        
        var error: NSError?
        
        if context.canEvaluatePolicy(
            LAPolicy.deviceOwnerAuthenticationWithBiometrics,
            error: &error) {
                    
            // Device can use biometric authentication
            context.evaluatePolicy(
                LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                localizedReason: "Access requires authentication",
                reply: {(success, error) in
                    DispatchQueue.main.async {
                        
                        if let err = error {
                            
                            switch err._code {
                                
                            case LAError.Code.systemCancel.rawValue:
                                self.notifyUser("Session canceled",
                                                err: err.localizedDescription)
                                
                            case LAError.Code.userCancel.rawValue:
                                self.notifyUser("Please try again",
                                                err: err.localizedDescription)
                                
                            case LAError.Code.userFallback.rawValue:
                                self.notifyUser("Authentication",
                                                err: "Password option selected")
                                // Custom code to obtain password here
                                
                            default:
                                self.notifyUser("Authentication failed",
                                                err: err.localizedDescription)
                            }
                            
                        } else {
                            self.notifyUser("Authentication Successful",
                                            err: "You now have full access")
                        }
                    }
            })

        } else {
            // Device cannot use biometric authentication
            if let err = error {
                switch err.code {
                    
                case LAError.Code.biometryNotEnrolled.rawValue:
                    notifyUser("User is not enrolled",
                               err: err.localizedDescription)
                    
                case LAError.Code.passcodeNotSet.rawValue:
                    notifyUser("A passcode has not been set",
                               err: err.localizedDescription)
                    
                    
                case LAError.Code.biometryNotAvailable.rawValue:
                    notifyUser("Biometric authentication not available",
                               err: err.localizedDescription)
                default:
                    notifyUser("Unknown error",
                               err: err.localizedDescription)
                }
            }
        }
    }

}

//
//  PhnNoAuth.swift
//  SampleOfApp
//
//  Created by Macbook on 18/01/2024.
//

import UIKit
import FirebaseAuth
import PhoneVerificationController

class PhnNoAuth: UIViewController {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var forgetPassword: UIButton!
    
    @IBOutlet weak var emailTxtFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 3, height: 3)
        shadowView.layer.shadowOpacity = 0.7
        shadowView.layer.shadowRadius = 4.0

    }
    
    @IBAction func btnLogin(_ sender: Any) {
//        Auth.auth().sendPasswordReset(withEmail: emailTxtFld.text!) { error in
//        DispatchQueue.main.async {
//        if self.emailTxtFld.text?.isEmpty==true || error != nil {
//        let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "Error: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
//        resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        self.present(resetFailedAlert, animated: true, completion: nil)
//        }
//        if error == nil && self.emailTxtFld.text?.isEmpty==false{
//        let resetEmailAlertSent = UIAlertController(title: "Reset Email Sent", message: "Reset email has been sent to your login email, please follow the instructions in the mail to reset your password", preferredStyle: .alert)
//         resetEmailAlertSent.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//         self.present(resetEmailAlertSent, animated: true, completion: nil)
//         }
//        }
//       }
    }
    
}

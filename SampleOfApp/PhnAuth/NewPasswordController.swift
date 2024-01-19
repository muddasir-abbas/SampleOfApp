//
//  NewPasswordController.swift
//  SampleOfApp
//
//  Created by Macbook on 18/01/2024.
//

//
//  NewPasswordController.swift
//  MobileApp
//
//  Created by Macbook on 5/12/23.
//

import UIKit
import SVProgressHUD

class NewPasswordController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtFldPswrd: UITextField!
    
    @IBOutlet weak var txtFldCnfrmPswrd: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var email = ""
    var reset_token = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtFldPswrd.delegate = self
        self.txtFldCnfrmPswrd.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnUpdatePaswrd(_ sender: Any) {
        
        self.updatePassword()
    }
    func updatePassword()
    {
        if(self.txtFldPswrd.text?.trim == "")
        {
            SVProgressHUD.showError(withStatus: "please enter password")
        }
        else if((self.txtFldPswrd.text?.trim.count)!<6)
        {
            SVProgressHUD.showError(withStatus:"This field should be at least 6 characters long")
        }
        else if(self.txtFldCnfrmPswrd.text?.trim == "")
        {
            SVProgressHUD.showError(withStatus: "please enter confirm password")
        }
        else if(self.txtFldPswrd.text?.trim != self.txtFldCnfrmPswrd.text?.trim)
        {
            SVProgressHUD.showError(withStatus: "please enter same password in both fields")
        }
        else
        {
            SVProgressHUD.show()
            LoginAndRegistrationReqModel.sharedModel().initUpdatePassword(email: self.email, password: self.txtFldPswrd.text!, confirm_password: self.txtFldCnfrmPswrd.text!, reset_token: self.reset_token, completion: { (status, response, error) in
                if(status)
                {
                    let message = response!.value(forKey: "message") as! String
                    let success = response!.value(forKey: "success") as! Bool
                    if(success)
                    {
                        SVProgressHUD.showSuccess(withStatus: message)
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    else
                    {
                        SVProgressHUD.showError(withStatus: message)
                    }
                    SVProgressHUD.dismiss()
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

//
//  addDevice.swift
//  SampleOfApp
//
//  Created by Macbook on 18/01/2024.
//

import UIKit
import SkyFloatingLabelTextField
class addDevice: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var Submit: UIButton!
    
    @IBOutlet weak var viewDeviceName: UIView!
    
    @IBOutlet weak var viewAdress: UIView!
    
    @IBOutlet weak var deviceName: SkyFloatingLabelTextField!
    
    @IBOutlet weak var adressName: SkyFloatingLabelTextField!
    
    @IBOutlet weak var deviceNameTxtFldView: RoundView!
    
    @IBOutlet weak var addressNameTxtFldView: RoundView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 3, height: 3)
        shadowView.layer.shadowOpacity = 0.7
        shadowView.layer.shadowRadius = 3.0
        shadowView.layer.cornerRadius = 5
        
        self.deviceName.delegate = self
        self.adressName.delegate = self
        
        let imgview = UIImageView()
        imgview.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        imgview.image = UIImage(named: "mail")
        let leftView = UIBarButtonItem(customView: imgview)
        self.navigationItem.rightBarButtonItem = leftView
        self.deviceName.placeholder = "Device Name"
        self.adressName.placeholder = "Address"
        deviceName.lineView.isHidden = true
        adressName.lineView.isHidden = true
        
        
    }
    
    @IBAction func nXtBtn(_ sender: Any) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let signupVC = sb.instantiateViewController(identifier: "submitDetals") as!
        submitDetals
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == deviceName {
            deviceNameTxtFldView.cornerBorderColor = UIColor(red: 108/255, green: 169/255, blue: 237/255, alpha: 1)
        }
        else {
            
            deviceNameTxtFldView.cornerBorderColor = .gray
        }
        if textField == adressName {
            self.addressNameTxtFldView.cornerBorderColor = UIColor(red: 108/255, green: 169/255, blue: 237/255, alpha: 1)
        }
        else {
            self.addressNameTxtFldView.cornerBorderColor = .gray
        }
    }
}
    

    

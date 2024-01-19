//
//  submitDetals.swift
//  SampleOfApp
//
//  Created by Macbook on 18/01/2024.
//


import UIKit
import SkyFloatingLabelTextField

class submitDetals: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var addresaTextFldView: RoundView!
    
    @IBOutlet weak var dvcNamView: RoundView!
    
    @IBOutlet weak var dvcSrlNoView: RoundView!
    
    @IBOutlet weak var view1: RoundButton!
    
    @IBOutlet weak var view2: RoundButton!
    
    @IBOutlet weak var view3: RoundButton!
    
    @IBOutlet weak var view4: RoundButton!
    
    @IBOutlet weak var dvcSrlNo: SkyFloatingLabelTextField!
    
    @IBOutlet weak var dvcNam: SkyFloatingLabelTextField!
    
    @IBOutlet weak var adress: SkyFloatingLabelTextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dvcNam.delegate = self
        self.dvcSrlNo.delegate = self
        self.adress.delegate = self
    
        
        
        let imgview = UIImageView()
        imgview.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        imgview.image = UIImage(named: "mail")
        let leftView = UIBarButtonItem(customView: imgview)
        self.navigationItem.rightBarButtonItem = leftView
        dvcNam.lineView.isHidden = true
        adress.lineView.isHidden = true
        dvcSrlNo.lineView.isHidden = true
        self.dvcSrlNo.placeholder = "Device Serial Number"
        self.adress.placeholder = "Address"
        self.dvcNam.placeholder = "Device Name"

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == dvcSrlNo {
            dvcSrlNoView.cornerBorderColor = UIColor(red: 108/255, green: 169/255, blue: 237/255, alpha: 1)
        }
        else {

            dvcSrlNoView.cornerBorderColor = .gray
            self.dvcNamView.cornerBorderColor = UIColor(red: 108/255, green: 169/255, blue: 237/255, alpha: 1)
        }
        if textField == dvcNam {
            self.dvcNamView.cornerBorderColor = UIColor(red: 108/255, green: 169/255, blue: 237/255, alpha: 1)
        }
        else {

            
            self.dvcNamView.cornerBorderColor = .gray
        }
        if textField == adress {
            self.addresaTextFldView.cornerBorderColor = UIColor(red: 108/255, green: 169/255, blue: 237/255, alpha: 1)
        }
        else {

            
            self.addresaTextFldView.cornerBorderColor = .gray
        }
    }

}

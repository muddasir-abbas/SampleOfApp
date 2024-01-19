//
//  scanerQRCode.swift
//  SampleOfApp
//
//  Created by Macbook on 18/01/2024.
//


import UIKit
import BarcodeEasyScan
import SkyFloatingLabelTextField

class scanerQRCode: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        let imgview = UIImageView()
        imgview.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        imgview.image = UIImage(named: "mail")
        let leftView = UIBarButtonItem(customView: imgview)
        self.navigationItem.rightBarButtonItem = leftView
    }
    
    @IBAction func buttonCLicked(){
        // Call this controller to open barcode screen
        
        let barcodeViewController =  BarcodeScannerViewController()
        barcodeViewController.delegate = self
        self.present(barcodeViewController, animated: true, completion: {
        })
    }

    
    @IBAction func nxBtn(_ sender: Any) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let signupVC = sb.instantiateViewController(identifier: "addDevice") as!
        addDevice
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
}

extension scanerQRCode:ScanBarcodeDelegate
{
    func userDidScanWith(barcode: String) {
        // This method results the scanned barcode string
        let alert = UIAlertController(title: "THE BARCODE CONTAINS", message: "The scanned string is : \(barcode)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}



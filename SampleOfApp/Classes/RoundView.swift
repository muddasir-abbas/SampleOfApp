//
//  RoundView.swift
//  SampleOfApp
//
//  Created by Macbook on 18/01/2024.
//

import Foundation
import UIKit

@IBDesignable
class RoundView: UIView {
    @IBInspectable var cornerRadiusValue: CGFloat = 10.0 {
        didSet {
            setupView()
            setupBorderView()
            setupBorderColor()
        }
    }
    
    @IBInspectable var cornerBorderValue: CGFloat = 0.0 {
        didSet {
            setupBorderView()
        }
    }
    
    @IBInspectable var cornerBorderColor: UIColor = .white {
        didSet {
            setupBorderColor()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.titleLabel?.adjustsFontSizeToFitWidth = false
        //self.titleLabel?.adjustsFontForContentSizeCategory = true
        //self.titleLabel?.minimumScaleFactor = 0.5
        //self.titleLabel?.font  = UIFont(name: "OpenSans-Semibold", size: 12.0)
        //self.isHighlighted = false
        //self.titleLabel?.numberOfLines = 1
        setupView()
        setupBorderView()
        setupBorderColor()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        //self.titleLabel?.adjustsFontSizeToFitWidth = false
        //self.titleLabel?.adjustsFontForContentSizeCategory = true
        //self.titleLabel?.minimumScaleFactor = 0.5
        //self.titleLabel?.numberOfLines = 1
        setupView()
        setupBorderView()
        setupBorderColor()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.cornerRadiusValue
        self.clipsToBounds = true
    }
    
    func setupBorderView() {
        self.layer.borderWidth = self.cornerBorderValue
    }
    
    func setupBorderColor() {
        self.layer.borderColor = self.cornerBorderColor.cgColor
    }
    
    func setupShadowView() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4.0
        self.clipsToBounds = true
    }
}

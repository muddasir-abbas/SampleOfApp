//
//  ChatBuubleView.swift
//  SampleOfApp
//
//  Created by Macbook on 18/01/2024.
//

import Foundation
import UIKit
struct MyMessage {
    var incoming: Bool = false
    var message: String = ""
    var img_path: String = ""
    var userName: String = ""
    var msg_time: String = ""
    var type:String = ""
    var path:String = ""
}

class ChatBubbleView: UIView {
    
    let bubbleLayer = CAShapeLayer()

    let chatLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textAlignment = .natural
        v.numberOfLines = 0
        v.lineBreakMode = .byWordWrapping
//        v.text = "Sample text"
        return v
    }()
    let imageView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
//        v.numberOfLines = 0
//        v.lineBreakMode = .byWordWrapping
//        v.text = "Sample text"
        return v
    }()
    
    let imageMsgLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textAlignment = .natural
        v.numberOfLines = 0
        v.lineBreakMode = .byWordWrapping
//        v.text = "Sample text"
        return v
    }()
    
    var incoming = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() -> Void {

        // add the bubble layer
        layer.addSublayer(bubbleLayer)

        // add the label
        addSubview(chatLabel)
        addSubview(imageView)
        addSubview(imageMsgLabel)

        // constrain the label with 12-pts padding on all 4 sides
        NSLayoutConstraint.activate([
            chatLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12.0),
            chatLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.0),
            chatLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            chatLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 12.0),
//            imageView.bottomAnchor.constraint(equalTo: imageMsgLabel.topAnchor, constant: 5.0),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
//            imageView.heightAnchor.constraint(equalToConstant: 200.0),
            imageMsgLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5.0),
            imageMsgLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.0),
            imageMsgLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            imageMsgLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0)
            ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = bounds.size.width
        let height = bounds.size.height
        
        let bezierPath = UIBezierPath()
        
        // NOTE: this bezier path is from
        // https://medium.com/@dima_nikolaev/creating-a-chat-bubble-which-looks-like-a-chat-bubble-in-imessage-the-advanced-way-2d7497d600ba
        if incoming {
            chatLabel.textColor = .black
            imageMsgLabel.textColor = .black
            bezierPath.move(to: CGPoint(x: 22, y: height))
            bezierPath.addLine(to: CGPoint(x: width - 17, y: height))
            bezierPath.addCurve(to: CGPoint(x: width, y: height - 17), controlPoint1: CGPoint(x: width - 7.61, y: height), controlPoint2: CGPoint(x: width, y: height - 7.61))
            bezierPath.addLine(to: CGPoint(x: width, y: 17))
            bezierPath.addCurve(to: CGPoint(x: width - 17, y: 0), controlPoint1: CGPoint(x: width, y: 7.61), controlPoint2: CGPoint(x: width - 7.61, y: 0))
            bezierPath.addLine(to: CGPoint(x: 21, y: 0))
            bezierPath.addCurve(to: CGPoint(x: 4, y: 17), controlPoint1: CGPoint(x: 11.61, y: 0), controlPoint2: CGPoint(x: 4, y: 7.61))
            bezierPath.addLine(to: CGPoint(x: 4, y: height - 11))
            bezierPath.addCurve(to: CGPoint(x: 0, y: height), controlPoint1: CGPoint(x: 4, y: height - 1), controlPoint2: CGPoint(x: 0, y: height))
            bezierPath.addLine(to: CGPoint(x: -0.05, y: height - 0.01))
            bezierPath.addCurve(to: CGPoint(x: 11.04, y: height - 4.04), controlPoint1: CGPoint(x: 4.07, y: height + 0.43), controlPoint2: CGPoint(x: 8.16, y: height - 1.06))
            bezierPath.addCurve(to: CGPoint(x: 22, y: height), controlPoint1: CGPoint(x: 16, y: height), controlPoint2: CGPoint(x: 19, y: height))
            bezierPath.close()
        } else {
            chatLabel.textColor = .white
            imageMsgLabel.textColor = .white
            bezierPath.move(to: CGPoint(x: width - 22, y: height))
            bezierPath.addLine(to: CGPoint(x: 17, y: height))
            bezierPath.addCurve(to: CGPoint(x: 0, y: height - 17), controlPoint1: CGPoint(x: 7.61, y: height), controlPoint2: CGPoint(x: 0, y: height - 7.61))
            bezierPath.addLine(to: CGPoint(x: 0, y: 17))
            bezierPath.addCurve(to: CGPoint(x: 17, y: 0), controlPoint1: CGPoint(x: 0, y: 7.61), controlPoint2: CGPoint(x: 7.61, y: 0))
            bezierPath.addLine(to: CGPoint(x: width - 21, y: 0))
            bezierPath.addCurve(to: CGPoint(x: width - 4, y: 17), controlPoint1: CGPoint(x: width - 11.61, y: 0), controlPoint2: CGPoint(x: width - 4, y: 7.61))
            bezierPath.addLine(to: CGPoint(x: width - 4, y: height - 11))
            bezierPath.addCurve(to: CGPoint(x: width, y: height), controlPoint1: CGPoint(x: width - 4, y: height - 1), controlPoint2: CGPoint(x: width, y: height))
            bezierPath.addLine(to: CGPoint(x: width + 0.05, y: height - 0.01))
            bezierPath.addCurve(to: CGPoint(x: width - 11.04, y: height - 4.04), controlPoint1: CGPoint(x: width - 4.07, y: height + 0.43), controlPoint2: CGPoint(x: width - 8.16, y: height - 1.06))
            bezierPath.addCurve(to: CGPoint(x: width - 22, y: height), controlPoint1: CGPoint(x: width - 16, y: height), controlPoint2: CGPoint(x: width - 19, y: height))
            bezierPath.close()
        }
        
        bubbleLayer.fillColor = incoming ? UIColor.white.cgColor :  UIColor(red: 42.0/255, green: 109.0/255, blue: 230.0/255, alpha: 1.0).cgColor
        
        bubbleLayer.path = bezierPath.cgPath
        
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        if self.incoming {
//            self.roundCorners(topLeft: 0, topRight: 5, bottomLeft: 21, bottomRight: 5)
//            self.chatLabel.textColor = .black
//            self.chatLabel.font = UIFont(name: "Roboto-regular", size: CGFloat(14.0))!
//        } else {
//            self.roundCorners(topLeft: 5, topRight: 0, bottomLeft: 5, bottomRight: 21)
//            self.chatLabel.textColor = .white
//            self.chatLabel.font = UIFont(name: "Roboto-regular", size: CGFloat(14.0))!
//        }
//        bubbleLayer.path = (self.layer.mask! as! CAShapeLayer).path! // Reuse the Bezier path
////        bubbleLayer.strokeColor = UIColor.red.cgColor
//        bubbleLayer.fillColor = self.incoming ? UIColor(red: 231.0/255, green: 245.0/255, blue: 252.0/255, alpha: 1.0).cgColor :UIColor(red: 48.0/255, green: 102.0/255, blue: 176.0/255, alpha: 1.0).cgColor
////        bubbleLayer.lineWidth = 5
//        bubbleLayer.frame = self.bounds
//        print("bounds==",self.frame as Any)
//    }
}
//extension UIBezierPath {
//    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGSize = .zero, topRightRadius: CGSize = .zero, bottomLeftRadius: CGSize = .zero, bottomRightRadius: CGSize = .zero){
//
//        self.init()
//
//        let path = CGMutablePath()
//
//        let topLeft = rect.origin
//        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
//        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
//        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
//
//        if topLeftRadius != .zero{
//            path.move(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
//        } else {
//            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
//        }
//
//        if topRightRadius != .zero{
//            path.addLine(to: CGPoint(x: topRight.x-topRightRadius.width, y: topRight.y))
//            path.addCurve(to:  CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height), control1: CGPoint(x: topRight.x, y: topRight.y), control2:CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height))
//        } else {
//             path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
//        }
//
//        if bottomRightRadius != .zero{
//            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y-bottomRightRadius.height))
//            path.addCurve(to: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y), control1: CGPoint(x: bottomRight.x, y: bottomRight.y), control2: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y))
//        } else {
//            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
//        }
//
//        if bottomLeftRadius != .zero{
//            path.addLine(to: CGPoint(x: bottomLeft.x+bottomLeftRadius.width, y: bottomLeft.y))
//            path.addCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height), control1: CGPoint(x: bottomLeft.x, y: bottomLeft.y), control2: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height))
//        } else {
//            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
//        }
//
//        if topLeftRadius != .zero{
//            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y+topLeftRadius.height))
//            path.addCurve(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y) , control1: CGPoint(x: topLeft.x, y: topLeft.y) , control2: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
//        } else {
//            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
//        }
//
//        path.closeSubpath()
//        cgPath = path
//    }
//}
//extension UIView{
//    func roundCorners(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {//(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
//        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
//        let topRightRadius = CGSize(width: topRight, height: topRight)
//        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
//        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
//        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
//        let shape = CAShapeLayer()
//        shape.path = maskPath.cgPath
//        layer.mask = shape
//    }
//}

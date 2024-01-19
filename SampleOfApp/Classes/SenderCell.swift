//
//  SenderCell.swift
//  SampleOfApp
//
//  Created by Macbook on 18/01/2024.
//

import UIKit

class SenderCell: UITableViewCell {

    @IBOutlet weak var msgView: UIView!
    
    let bubbleView: ChatBubbleView = {
        let v = ChatBubbleView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let nameLbl: UILabel =
    {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = .black
        v.font = UIFont(name: "Roboto-bold", size: CGFloat(14.0))!
        v.textAlignment = .left
        return v
    }()
    
    let timeLbl: UILabel =
    {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = .black
        v.font = UIFont(name: "Roboto-regular", size: CGFloat(14.0))!
        v.textAlignment = .right
        return v
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        commonInit()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func commonInit() -> Void {
        bubbleView.layoutSubviews()
        self.msgView.addSubview(bubbleView)
        self.contentView.addSubview(nameLbl)
        self.contentView.addSubview(timeLbl)
        NSLayoutConstraint.activate([
            nameLbl.bottomAnchor.constraint(equalTo: msgView.topAnchor, constant: -5),
            nameLbl.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: 0),
            nameLbl.leadingAnchor.constraint(lessThanOrEqualTo: bubbleView.leadingAnchor, constant: 0),
            nameLbl.widthAnchor.constraint(lessThanOrEqualTo: msgView.widthAnchor, multiplier: 0.66),
            bubbleView.topAnchor.constraint(equalTo: msgView.topAnchor, constant: 0),
            bubbleView.bottomAnchor.constraint(equalTo: timeLbl.topAnchor, constant: -5),
            bubbleView.widthAnchor.constraint(lessThanOrEqualTo: msgView.widthAnchor, multiplier: 0.66),
            bubbleView.trailingAnchor.constraint(equalTo: msgView.trailingAnchor, constant: 0),
            timeLbl.bottomAnchor.constraint(equalTo: msgView.bottomAnchor, constant: 0),
            timeLbl.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -2),
            timeLbl.widthAnchor.constraint(lessThanOrEqualTo: msgView.widthAnchor, multiplier: 0.66)
        ])
    }
}

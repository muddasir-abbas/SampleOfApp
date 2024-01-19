//
//  ReceiverCell.swift
//  SampleOfApp
//
//  Created by Macbook on 18/01/2024.
//


import UIKit

class ReceiverCell: UITableViewCell {
    

    @IBOutlet weak var MsgView: UIView!
    
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
        v.textAlignment = .left
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
        // add the bubble view
        bubbleView.layoutSubviews()
        self.MsgView.addSubview(bubbleView)
        self.contentView.addSubview(nameLbl)
        self.contentView.addSubview(timeLbl)
        // constrain width to lessThanOrEqualTo 2/3rds (66%) of the width of the cell
        NSLayoutConstraint.activate([
            nameLbl.bottomAnchor.constraint(equalTo: MsgView.topAnchor, constant: -5),
            nameLbl.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 2),
            nameLbl.widthAnchor.constraint(lessThanOrEqualTo: MsgView.widthAnchor, multiplier: 0.66),
            bubbleView.topAnchor.constraint(equalTo: MsgView.topAnchor, constant: 0),
            bubbleView.bottomAnchor.constraint(equalTo: timeLbl.topAnchor, constant: -5),
            bubbleView.widthAnchor.constraint(lessThanOrEqualTo: MsgView.widthAnchor, multiplier: 0.66),
            bubbleView.leadingAnchor.constraint(equalTo: MsgView.leadingAnchor, constant: 0),
            timeLbl.bottomAnchor.constraint(equalTo: MsgView.bottomAnchor, constant: 0),
            timeLbl.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 2),
            timeLbl.widthAnchor.constraint(lessThanOrEqualTo: MsgView.widthAnchor, multiplier: 0.66)
        ])
    }
}

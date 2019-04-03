//
//  ChatMessageCell.swift
//  bubble-messages
//
//  Created by Diego Oruna on 4/3/19.
//  Copyright © 2019 Diego Oruna. All rights reserved.
//

import UIKit

class ChatMessageCell: UITableViewCell {

    let messageLabel = UILabel()
    let backgroundBubble = UIView()
    
    var leadingConstraint:NSLayoutConstraint!
    var trailingConstraint:NSLayoutConstraint!
    
    var chatMessage:ChatMessage!{
        didSet{
            backgroundBubble.backgroundColor = chatMessage.isIncoming ? .white : UIColor(red: 0/255, green: 128/255, blue: 255/255, alpha: 1)
            messageLabel.textColor = chatMessage.isIncoming ? .black : .white
            messageLabel.text = chatMessage.text
            
            if chatMessage.isIncoming {
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
            } else {
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        
        backgroundBubble.backgroundColor = .blue
        backgroundBubble.layer.cornerRadius = 12
        addSubview(backgroundBubble)
        addSubview(messageLabel)
        
        messageLabel.numberOfLines = 0
        
        backgroundBubble.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        let constraints = [
        messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
        messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
        messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
        
        backgroundBubble.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
        backgroundBubble.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
        backgroundBubble.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
        backgroundBubble.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

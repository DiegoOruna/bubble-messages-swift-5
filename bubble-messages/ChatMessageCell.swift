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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundBubble.backgroundColor = .green
        backgroundBubble.layer.cornerRadius = 7
        addSubview(backgroundBubble)
        addSubview(messageLabel)
        
        messageLabel.numberOfLines = 0
        
        backgroundBubble.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
        messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
        messageLabel.widthAnchor.constraint(equalToConstant: 250),
        messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        
        backgroundBubble.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
        backgroundBubble.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
        backgroundBubble.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
        backgroundBubble.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

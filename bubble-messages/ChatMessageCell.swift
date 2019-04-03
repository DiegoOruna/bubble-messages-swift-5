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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(messageLabel)
        messageLabel.backgroundColor = .red
        messageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        messageLabel.text = "This is only a test text to probe the cells"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

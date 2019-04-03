//
//  ViewController.swift
//  bubble-messages
//
//  Created by Diego Oruna on 4/3/19.
//  Copyright © 2019 Diego Oruna. All rights reserved.
//

import UIKit

struct ChatMessage {
    let text:String
    let isIncoming:Bool
    let date:Date
}

extension Date {
    static func dateFromCustomString(customString:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: customString) ?? Date()
    }
}

class ViewController: UITableViewController {
    
    let cellId = "cellId"
    
//    let chatMessages = [
//        [
//            ChatMessage(text: "This is very short text", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2019")),
//            ChatMessage(text: "This is very short text only for demonstrate the autosizing tableview, but this is not the only feature inside this awesome app", isIncoming: true, date: Date.dateFromCustomString(customString: "09/03/2019"))
//        ],
//        [
//            ChatMessage(text: "This is very short text", isIncoming: false, date: Date.dateFromCustomString(customString: "10/03/2019")),
//            ChatMessage(text: "This is another text from me, and only me in the current application writed in Swift 5 for all the comunity in Github, another commit is incoming", isIncoming: false, date: Date.dateFromCustomString(customString: "11/03/2019")),
//            ChatMessage(text: "🤓", isIncoming: true, date: Date.dateFromCustomString(customString: "12/03/2019"))
//        ],
//        [
//            ChatMessage(text: "I love this awesome app 💙💙", isIncoming: true, date: Date.dateFromCustomString(customString: "13/03/2019"))
//        ]
//    ]
    
    let messagesFromServer = [
        ChatMessage(text: "This is very short text", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2019")),
        ChatMessage(text: "This is very short text only for demonstrate the autosizing tableview, but this is not the only feature inside this awesome app", isIncoming: true, date: Date.dateFromCustomString(customString: "09/03/2019")),
        ChatMessage(text: "This is very short text", isIncoming: false, date: Date.dateFromCustomString(customString: "10/03/2019")),
        ChatMessage(text: "This is another text from me, and only me in the current application writed in Swift 5 for all the comunity in Github, another commit is incoming", isIncoming: false, date: Date.dateFromCustomString(customString: "11/03/2019")),
        ChatMessage(text: "🤓", isIncoming: true, date: Date.dateFromCustomString(customString: "12/03/2019"))
    ]
    
    var chatMessages = [[ChatMessage]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Bubble Messages 💙"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }
    
    class DateHeaderLabel: UILabel {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .blue
            textColor = .white
            textAlignment = .center
            font = UIFont.boldSystemFont(ofSize: 14)
            translatesAutoresizingMaskIntoConstraints = false
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override var intrinsicContentSize: CGSize{
            let originalContentSize = super.intrinsicContentSize
            let height = originalContentSize.height + 12
            layer.cornerRadius = height/2
            layer.masksToBounds = true
            
            return CGSize(width: originalContentSize.width + 16, height: height)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let firstMessageInSection = chatMessages[section].first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let dateString = dateFormatter.string(from: firstMessageInSection.date)
            
            
            let label = DateHeaderLabel()
            label.text = dateString
            
            let containerView = UIView()
            containerView.addSubview(label)
            
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            
            return containerView
        }
        
        return nil
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
        let chatMessage = chatMessages[indexPath.section][indexPath.row]
        cell.chatMessage = chatMessage
        
        return cell
    }
    
    


}


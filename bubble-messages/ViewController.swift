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
}

class ViewController: UITableViewController {
    
    let cellId = "cellId"
    
    let chatMessages = [
        ChatMessage(text: "This is very short text", isIncoming: true),
        ChatMessage(text: "This is very short text only for demonstrate the autosizing tableview, but this is not the only feature inside this awesome app", isIncoming: true),
        ChatMessage(text: "This is very short text", isIncoming: false),
        ChatMessage(text: "This is very short text", isIncoming: true),
        ChatMessage(text: "This is another text from me, and only me in the current application writed in Swift 5 for all the comunity in Github, another commit is incoming", isIncoming: false)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Bubble Messages 💙"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
        
        let chatMessage = chatMessages[indexPath.row]
        
        cell.chatMessage = chatMessage
        
        return cell
    }
    
    


}


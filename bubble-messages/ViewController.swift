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
    
    var iconsContainerView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        let iconHeight:CGFloat = 43
        let padding:CGFloat = 6
        
        let images = [UIImage(named: "blue_like"), UIImage(named: "red_heart"), UIImage(named: "surprised"), UIImage(named: "cry_laugh"), UIImage(named: "cry"), UIImage(named: "angry")]
        
        let arrangedSubviews = images.map({ (image) -> UIImageView in
            let imageView = UIImageView(image: image)
            imageView.layer.cornerRadius = iconHeight / 2
            //required for hit testing
            imageView.isUserInteractionEnabled = true
            return imageView
        })
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.distribution = .fillEqually
        
        stackView.spacing = padding
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        view.addSubview(stackView)
        
        let numIcons = CGFloat(arrangedSubviews.count)
        let width = numIcons * iconHeight + (numIcons + 1) * padding
        
        view.frame = CGRect(x: 0, y: 0, width: width, height: iconHeight + 2 * padding)
        view.layer.cornerRadius = view.frame.height / 2
        
        //Shadowlayer
        view.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        stackView.frame = view.frame
        
        return view
    }()
    
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
        ChatMessage(text: "This is another text from the same date", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2019")),
        ChatMessage(text: "This is very short text only for demonstrate the autosizing tableview, but this is not the only feature inside this awesome app", isIncoming: true, date: Date.dateFromCustomString(customString: "09/03/2019")),
        ChatMessage(text: "This is very short text", isIncoming: false, date: Date.dateFromCustomString(customString: "10/03/2019")),
        ChatMessage(text: "This is another text from me, and only me in the current application writed in Swift 5 for all the comunity in Github, another commit is incoming", isIncoming: false, date: Date.dateFromCustomString(customString: "11/03/2019")),
        ChatMessage(text: "🤓", isIncoming: true, date: Date.dateFromCustomString(customString: "12/03/2019"))
    ]
    
    var chatMessages = [[ChatMessage]]()

    fileprivate func attemptToAssembleGroupedMessages() {

        let groupedMessages = Dictionary(grouping: messagesFromServer) { (element) -> Date in
            return element.date
        }
        
        let sortedKeys = groupedMessages.keys.sorted()
        sortedKeys.forEach { (key) in
            let values = groupedMessages[key]
            chatMessages.append(values ?? [])
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        attemptToAssembleGroupedMessages()
    }
    
    fileprivate func setupStyle(){
        navigationItem.title = "Bubbles 💙"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }
    
    @objc fileprivate func handleLongPress(gesture:UILongPressGestureRecognizer){
        
        if gesture.state == .began {
            handleGestureBegan(gesture: gesture)
        } else if gesture.state == .ended {
            handleGestureEnd()
        } else if gesture.state == .changed {
            handleGestureChange(gesture: gesture)
        }
        
    }
    
    fileprivate func handleGestureEnd(){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            let stackView = self.iconsContainerView.subviews.first
            stackView?.subviews.forEach({ (UIImageView) in
                UIImageView.transform = .identity
            })
            
            self.iconsContainerView.transform = self.iconsContainerView.transform.translatedBy(x: 0, y: 50)
            self.iconsContainerView.alpha = 0
            
        }) { (_) in
            self.iconsContainerView.removeFromSuperview()
        }
    }
    
    fileprivate func handleGestureChange(gesture:UILongPressGestureRecognizer){
        
        let pressedLocation = gesture.location(in: self.iconsContainerView)
        let fixedYLocation = CGPoint(x: pressedLocation.x, y: self.iconsContainerView.frame.height / 2)
        
        let hitTestView = iconsContainerView.hitTest(fixedYLocation, with: nil)
        
        if hitTestView is UIImageView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                let stackView = self.iconsContainerView.subviews.first
                stackView?.subviews.forEach({ (UIImageView) in
                    UIImageView.transform = .identity
                })
                
                hitTestView?.transform = CGAffineTransform(translationX: 0, y: -50)
                
            })

        }
    }
    
    fileprivate func handleGestureBegan(gesture:UILongPressGestureRecognizer){
        
        view.addSubview(iconsContainerView)
        
        let pressedLocation = gesture.location(in: self.view)
        
        let centeredX = (view.frame.width - iconsContainerView.frame.width) / 2
        
        iconsContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y)
        iconsContainerView.alpha = 0
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.iconsContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y - self.iconsContainerView.frame.height)
            self.iconsContainerView.alpha = 1
        }, completion: nil)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }
    
    class DateHeaderLabel: UILabel {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .gray
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
        cell.backgroundBubble.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
        return cell
    }
    

}


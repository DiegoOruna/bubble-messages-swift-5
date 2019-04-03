//
//  ViewController.swift
//  bubble-messages
//
//  Created by Diego Oruna on 4/3/19.
//  Copyright © 2019 Diego Oruna. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Bubble Messages 💙"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
        cell.messageLabel.numberOfLines = 0
        return cell
    }
    
    


}


//
//  NotificationViewController.swift
//  U-CITY
//
//  Created by JayJay on 2/2/19.
//  Copyright © 2019 semon12694. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "NoitificationTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "AdminNotiCellCreat")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdminNotiCellCreat", for: indexPath) as! NoitificationTableViewCell
        return cell
        
    }

}

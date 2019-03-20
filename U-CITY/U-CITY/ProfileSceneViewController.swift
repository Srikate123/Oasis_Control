//
//  ProfileSceneViewController.swift
//  U-CITY
//
//  Created by JayJay on 2/4/19.
//  Copyright © 2019 semon12694. All rights reserved.
//

import UIKit

class ProfileSceneViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "ProfileCustomTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "profileCell")
            tableView.dataSource = self
            tableView.delegate = self
        
        
       
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! ProfileCustomTableViewCell
        return cell
    }
    
}

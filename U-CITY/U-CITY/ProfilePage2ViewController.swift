//
//  ProfilePage2ViewController.swift
//  U-CITY
//
//  Created by semon12694 on 25/4/2561 BE.
//  Copyright © 2561 semon12694. All rights reserved.
//

import UIKit

class ProfilePage2ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var Page2TableView:UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Page2Cell", for: indexPath)
        cell.textLabel?.text = "P2"
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

   

}

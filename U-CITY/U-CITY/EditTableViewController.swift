//
//  EditTableViewController.swift
//  U-CITY
//
//  Created by JayJay on 5/29/18.
//  Copyright © 2018 semon12694. All rights reserved.
//

import UIKit

class EditTableViewController: UITableViewController{

    @IBOutlet weak var EditPageTableview: TableViewEdit!
    override func numberOfSections(in tableView: UITableView) -> Int {
        
            return 1
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return 10
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditCell", for: indexPath)
        cell.textLabel?.text = "P1"
        return cell
    }
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

  
}

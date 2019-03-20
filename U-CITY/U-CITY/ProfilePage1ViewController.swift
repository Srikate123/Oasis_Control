//
//  ProfilePage1ViewController.swift
//  U-CITY
//
//  Created by semon12694 on 24/4/2561 BE.
//  Copyright © 2561 semon12694. All rights reserved.
//

import UIKit
import Firebase


class ProfilePage1ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var Page1tableview:UITableView!
    


    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Page1_Cell", for: indexPath)
        cell.textLabel?.text = "P1"
        return cell
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

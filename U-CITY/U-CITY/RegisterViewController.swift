//
//  RegisterViewController.swift
//  U-CITY
//
//  Created by semon12694 on 17/4/2561 BE.
//  Copyright © 2561 semon12694. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var EmailTextfield: UITextField!
    @IBOutlet weak var PasswordTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func RegisterClicked(_ sender: Any) {
        Auth.auth().createUser(withEmail: EmailTextfield.text!, password: PasswordTextfield.text!) { (user, error) in
            if error == nil {
                  ConstAlertBox().showAlertBox(title:"Error",message:"Log in สำเร็จ",ViewController:self)
                
            }else{
                ConstAlertBox().showAlertBox(title:"Error",message:"Log in สำเร็จ",ViewController:self)
                
            }
        }
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

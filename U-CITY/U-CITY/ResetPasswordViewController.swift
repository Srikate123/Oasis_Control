//
//  ResetPasswordViewController.swift
//  U-CITY
//
//  Created by semon12694 on 18/4/2561 BE.
//  Copyright © 2561 semon12694. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var EmailTextfield: UITextField!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.EmailTextfield.delegate = self
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //ปิดคีย์บอร์ดเมื่อทัชหน้าจอ
      
        
    }
    ////////////เมื่อกดปุ่มreturnบนแป้นพิมพ์///////////////
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()



        return true
    }
    
    @IBAction func ResetPasswordClicked(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: EmailTextfield.text!) { (error) in
            if error == nil{
                 self.EmailTextfield.backgroundColor = UIColor.white
                let alert = UIAlertController(title: "Succeed", message: "ResetPassword ได้ถูกส่งไปที่ E-mail ของคุณแล้ว", preferredStyle: .alert)
                let resultAlert = UIAlertAction(title: "OK", style: .cancel, handler: { (alertAction) in
                   self.navigationController?.popViewController(animated: true)
                    
                })
                alert.addAction(resultAlert)
                self.present(alert, animated: true, completion: nil)
                return
                
            
                
            }else{
                self.EmailTextfield.backgroundColor = UIColor.orange
                ConstAlertBox().showAlertBox(title:"Error",message:"E-mail ไม่ถูกต้อง",ViewController:self)
                
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

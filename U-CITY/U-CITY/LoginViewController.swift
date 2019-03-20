
import UIKit
import Firebase
import FirebaseAuth

import FBSDKCoreKit
import FBSDKLoginKit







class LoginViewController: UIViewController,UITextFieldDelegate{
    @IBOutlet weak var EmailTextfield: UITextField!
    @IBOutlet weak var PasswordTextfield: UITextField!
    @IBOutlet weak var OpenMenu:UIBarButtonItem!
    
   
    var userdatabaseRefer: DatabaseReference!
    var databaseHandle:DatabaseHandle!
    
   
     var timestamp: Double!
     var time:String!
   
    var emailUser:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.EmailTextfield.delegate = self
        self.PasswordTextfield.delegate = self
        
       
        if(Auth.auth().currentUser != nil)
        {
            self.performSegue(withIdentifier: "LoginPage", sender: nil)
            
        }
       
        
       
        //FirebaseApp.configure()
        OpenMenu.target = self.revealViewController()
        OpenMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        print("123")
       ////////////////////////facebook login
     //   let btnFBLogin = FBSDKLoginButton()
     //   btnFBLogin.readPermissions = ["public_profile","email"]
       // btnFBLogin.frame = CGRect(x: 15, y: 60, width: -30, height: 30)
       
//        btnFBLogin.center = self.view.center
//        self.view.addSubview(btnFBLogin)
        
    //    btnFBLogin.delegate = self
     /////////
    }
    //จัดการkeyborad//
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.revealViewController() != nil) {
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.navigationItem.leftBarButtonItem?.target = revealViewController()
            self.navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
        }
        self.view.endEditing(true) //ซ่อนคีย์บอร์ด
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() 
        if(PasswordTextfield.text != "" && EmailTextfield.text != ""){
        Auth.auth().signIn(withEmail: EmailTextfield.text!, password: PasswordTextfield.text!,completion: { (user, error) in
            if error ==  nil {
                //print("fgsfrg")
                self.performSegue(withIdentifier: "LoginPage", sender: nil)
                
            }else{
                self.EmailTextfield.backgroundColor = UIColor.orange
                self.PasswordTextfield.backgroundColor = UIColor.orange
                ConstAlertBox().showAlertBox(title:"Error",message:"Email หรือ Password ไม่ถูกต้อง",ViewController:self)
                
                
            }
            
        })
        }
        
        
    
        return true
    }
    //////////////////////
    ///เช็คเงื่อนไขในการ Login///
    @IBAction func LoginClicked(_ sender:Any)  {
       // FBSDKLoginManager().logOut()
        
        //print("555678")
        if(EmailTextfield.text!.count < 6){
            EmailTextfield.backgroundColor = UIColor.orange
            ConstAlertBox().showAlertBox(title:"Error",message:"Username ต้องมากกว่า 6 ตัวอักษร",ViewController:self)
            return
        }
        else{
            //EmailTextfield.backgroundColor = UIColor.white
            
        }
        if (PasswordTextfield.text!.count < 6){
            PasswordTextfield.backgroundColor = UIColor.orange
             ConstAlertBox().showAlertBox(title:"Error",message:"Password ต้องมากกว่า 6 ตัวอักษร",ViewController:self)
            return
        }
        else {
            //PasswordTextfield.backgroundColor = UIColor.white
        }
        Auth.auth().signIn(withEmail: EmailTextfield.text!, password: PasswordTextfield.text!,completion: { (user, error) in
            if error ==  nil {
                //print("fgsfrg")
                //self.LastLoginAt()
                
                self.performSegue(withIdentifier: "LoginPage", sender: nil)
               
            }else{
                self.EmailTextfield.backgroundColor = UIColor.orange
                self.PasswordTextfield.backgroundColor = UIColor.orange
                ConstAlertBox().showAlertBox(title:"Error",message:"Email หรือ Password ไม่ถูกต้อง",ViewController:self)
                
                
            }
            
        })
       
    
        
    }
    
    
    
    
   
    
    
    
    
    
    
    ///facebook login
  
    
    @IBAction func FBLoginClicked(_ sender:Any){
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                
                print("condition true")
                
                // if user cancel the login
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                    
                {
                    let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                    Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                        if error != nil {
                            print("Erorrนิ่")
                            print(error!.localizedDescription)
                            return
                        }else{
                        print("Log in sucseed")
                             let userUID = Auth.auth().currentUser?.uid
                            
       // tokenLoginFacebook              //      let accessToken = FBSDKAccessToken.current().tokenString
                           // print("token"+accessToken!)
                           
                            self.getFBUserData(userUID!)
                        }
                    }
                }
            }else{
                print("error is not null")
            }
        }
    }
    
    func getFBUserData(_ userUID:String){
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name,last_name, email, picture.type(large),relationship_status"]).start(completionHandler: { (connection, result, error) -> Void in
            if (error == nil){
                let fbDetails = result as! NSDictionary
               // let name = fbDetails["name"] as! String
                guard let Info = result as? [String: Any] else { return }
                if let imageURL = ((Info["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {
                self.savedataIntoDatabase(fbDetails, userUID,imageURL)
            
               // print(fbDetails)
                }
            }
        })

    }
    
    
    func savedataIntoDatabase(_ fbDetails:NSDictionary,_ userUID:String,_ imageURL:String){
        self.LastLoginAt()
        let name = fbDetails["name"] as! String
        let id = fbDetails["id"] as! String
        let Firstname = fbDetails["first_name"] as! String
        let Lastname = fbDetails["last_name"] as! String
        let userEmail = fbDetails["email"] as! String
        let userImageUrl = imageURL
        
        let dataProfile = ["Email":userEmail,"Firstname":Firstname,"Lastname":Lastname,"FBUserId":id,"Name":name,"userImageUrl":userImageUrl,"Provider":"Facebook","LassLoginAt":self.time]
        userdatabaseRefer = Database.database().reference()
        userdatabaseRefer.child("users").child(userUID).setValue(dataProfile)
        
        self.performSegue(withIdentifier: "LoginPage", sender: nil)
        
        
       
    }
    func LastLoginAt(){
        self.timestamp = Date().timeIntervalSince1970
        let lassLogintime = Date(timeIntervalSince1970: self.timestamp)
        let formatter =  DateFormatter()
        formatter.dateFormat = "dd. MMM yyyy H:mm:ss"
        let lastLogin = formatter.string(from: lassLogintime)
        self.time = lastLogin
    }
    
    
    //////////

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
   
    

  
}

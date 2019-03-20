//
//  Register_ViewController.swift
//  U-CITY
//
//  Created by semon12694 on 18/4/2561 BE.
//  Copyright © 2561 semon12694. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import Foundation
import FirebaseStorage

class Register_ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var EmailTextfield: UITextField!
    @IBOutlet weak var PasswordTextfield: UITextField!
    @IBOutlet weak var CheckPasswordTextfield: UITextField!
    @IBOutlet weak var FirstNameTextfield: UITextField!
    @IBOutlet weak var LastNameTextfield: UITextField!
    @IBOutlet weak var MaleSexTik1_Image: UIImageView!
    @IBOutlet weak var FamaleSexTic2_Image: UIImageView!
    @IBOutlet weak var DateTableView: UITableView!
    @IBOutlet weak var MonthTableView:UITableView!
    @IBOutlet weak var YearTableView: UITableView!
    @IBOutlet weak var PhoneTableView: UITableView!
    @IBOutlet weak var DateTextfield: UITextField!
    @IBOutlet weak var MonthTextfiled: UITextField!
    @IBOutlet weak var YearTextfield: UITextField!
    @IBOutlet weak var PhoneTextfiled: UITextField!
    @IBOutlet weak var PhoneNumTextfield:UITextField!
    @IBOutlet weak var ProfileImageView:UIImageView!
    
    
    
    var userdatabaseRefer: DatabaseReference!
    var databaseHandle: DatabaseHandle!
   // var imagePicker:UIImagePickerController!
    
    let storageRef = Storage.storage().reference()
    let databaseRef = Database.database().reference()
    
    var timestamp:Double! //get time now
    
    
    var profileImagePicker:UIImage!
   
   // let token = InstanceID.instanceID().token()!

    
    //////TableView//////
    let DateArray = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
    let MonthArray = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    let YearsArray = ["1990","1991","1992","1993","1994","1995","1996","1997","1998","1999"]
    let PhoneArray = ["ไทย 66","Eng 90"]
    
    @IBAction func DateClicked(_ sender: Any){
        self.view.endEditing(true)
        
        
        DateTableView.isHidden = !DateTableView.isHidden
        if(DateTableView.isHidden == false){
        MonthTableView.isHidden = !DateTableView.isHidden
        YearTableView.isHidden = !DateTableView.isHidden
        PhoneTableView.isHidden = !DateTableView.isHidden
        }
    }
    @IBAction func MonthClicked(_ sender: Any){
        self.view.endEditing(true)
        
        MonthTableView.isHidden = !MonthTableView.isHidden
        if(MonthTableView.isHidden == false){
        DateTableView.isHidden = !MonthTableView.isHidden
        YearTableView.isHidden = !MonthTableView.isHidden
        PhoneTableView.isHidden = !MonthTableView.isHidden
        }
    }
    @IBAction func YearClicked(_ sender: Any){
        self.view.endEditing(true)
        
        YearTableView.isHidden = !YearTableView.isHidden
        if(YearTableView.isHidden == false) {
        DateTableView.isHidden = !YearTableView.isHidden
        MonthTableView.isHidden = !YearTableView.isHidden
        PhoneTableView.isHidden = !YearTableView.isHidden
        }
    }
    @IBAction func PhoneClicked(_ sender: Any){
        self.view.endEditing(true)
        
        PhoneTableView.isHidden = !PhoneTableView.isHidden
        if(PhoneTableView.isHidden == false){
        DateTableView.isHidden = !PhoneTableView.isHidden
        MonthTableView.isHidden = !PhoneTableView.isHidden
        YearTableView.isHidden = !PhoneTableView.isHidden
        }
    }
    
    
   
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if(tableView == DateTableView){
            return DateArray.count
        }
        else if(tableView == MonthTableView){
            return MonthArray.count
        }
        else if(tableView == YearTableView){
            return YearsArray.count
        }
        else{
            return PhoneArray.count
        }
        
    }
    
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if(tableView == DateTableView){
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! TableViewDate
            cell.textLabel?.text = DateArray[indexPath.row]
            return cell

        }else if(tableView == MonthTableView){
            let cell = tableView.dequeueReusableCell(withIdentifier: "MonthCell", for: indexPath) as! TableViewMonth
            cell.textLabel?.text = MonthArray[indexPath.row]
            return cell
        }else if(tableView == YearTableView){
            let cell = tableView.dequeueReusableCell(withIdentifier: "YearCell", for: indexPath) as! TableViewYear
            cell.textLabel?.text = YearsArray[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneCell", for: indexPath) as! TableViewPhone
            cell.textLabel?.text = PhoneArray[indexPath.row]
            return cell
        }

  }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == DateTableView){
            let cell = tableView.cellForRow(at: indexPath) as! TableViewDate
            DateTextfield.text = cell.textLabel?.text
            self.DateTableView.isHidden = true
        }
        if(tableView == MonthTableView){
            let cell = tableView.cellForRow(at: indexPath) as! TableViewMonth
            MonthTextfiled.text = cell.textLabel?.text
            self.MonthTableView.isHidden = true
        }
        if(tableView == YearTableView){
            let cell = tableView.cellForRow(at: indexPath) as! TableViewYear
            YearTextfield.text = cell.textLabel?.text
            self.YearTableView.isHidden = true
        }
        if(tableView == PhoneTableView){
            let cell = tableView.cellForRow(at: indexPath) as! TableViewPhone
            PhoneTextfiled.text = cell.textLabel?.text
            self.PhoneTableView.isHidden = true
        }
    }
    //จัดการkeyborad//
          //ตรวจจับการสัมผัสบนหน้าจอ//
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //ปิดคีย์บอร์ดเมื่อทัชหน้าจอ
        DateTableView.isHidden = true
        MonthTableView.isHidden = true
        YearTableView.isHidden = true
        PhoneTableView.isHidden = true
        
    }
        ////////////เมื่อกดปุ่มreturnบนแป้นพิมพ์///////////////
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        
        return true
    }
    //////////////////////
    
    
    
    
   
   
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    /////////////เลือกเพศ /////////////
    var SexStatus = false
    var Status = true
  
    @IBAction func maleClicked(_ sender: Any) {
        MaleSexTik1_Image.isHidden = SexStatus
        FamaleSexTic2_Image.isHidden = !SexStatus
        
        DateTableView.isHidden = true
        MonthTableView.isHidden = true
        YearTableView.isHidden = true
        PhoneTableView.isHidden = true
        
    }
   
    @IBAction func FamaleClicked(_ sender: Any) {
        MaleSexTik1_Image.isHidden = !SexStatus
        FamaleSexTic2_Image.isHidden = SexStatus
        
        DateTableView.isHidden = true
        MonthTableView.isHidden = true
        YearTableView.isHidden = true
        PhoneTableView.isHidden = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        MaleSexTik1_Image.isHidden = SexStatus
        FamaleSexTic2_Image.isHidden = !SexStatus
        
        self.FirstNameTextfield.delegate = self
        self.LastNameTextfield.delegate = self
        self.DateTextfield.delegate = self
        self.MonthTextfiled.delegate = self
        self.YearTextfield.delegate = self
        self.EmailTextfield.delegate = self
        self.PasswordTextfield.delegate = self
        self.CheckPasswordTextfield.delegate = self
        self.PhoneTextfiled.delegate = self
        self.PhoneNumTextfield.delegate = self
        
        
        DateTableView.isHidden = Status
        MonthTableView.isHidden = Status
        YearTableView.isHidden = Status
        PhoneTableView.isHidden = Status
       
        //setupProfile()
       // saveChanges()
        //WritheDataDatabase
//        databaseRefer = Database.database().reference()
//        databaseRefer.child("name").childByAutoId().setValue("Jay")
//        databaseRefer.child("name").childByAutoId().setValue("klear")
//        //ReadDataDatabase
//        databaseHandle = databaseRefer.child("name").observe(.childAdded, with: { (data) in
//            let name: String = (data.value as? String)!
//            debugPrint(name)
//        })
        //print("token =>"+token)
        
       
        
        
        
        
       
    }
    
    //สิ่งที่จะทำเมื่อกดปุ่ม Register //////////////////////////
    @IBAction func RegisterClicked(_ sender: Any) {
        let cost = ""
        if(FirstNameTextfield.text! == cost ){
            FirstNameTextfield.backgroundColor = UIColor.orange
            ConstAlertBox().showAlertBox(title:"Error",message:"ต้องตั้งชื่อผู้ใช้",ViewController:self)
                return
        
        }
        else{
            FirstNameTextfield.backgroundColor = UIColor.clear
        }
        if(LastNameTextfield.text! == cost ){
            LastNameTextfield.backgroundColor = UIColor.orange
            ConstAlertBox().showAlertBox(title:"Error",message:"ต้องตั้งชื่อผู้ใช้",ViewController:self)
            return
        }
        else{
            LastNameTextfield.backgroundColor = UIColor.clear
        }
        if(DateTextfield.text == ""){
            DateTextfield.backgroundColor = UIColor.orange
             ConstAlertBox().showAlertBox(title:"Error",message:"กรุณาเลือกวันที่",ViewController:self)
            return
        }else{
            DateTextfield.backgroundColor = UIColor.white
        }
        if(MonthTextfiled.text == ""){
            MonthTextfiled.backgroundColor = UIColor.orange
             ConstAlertBox().showAlertBox(title:"Error",message:"กรุณาเลือกเดือน",ViewController:self)
            return
        }else{
            MonthTextfiled.backgroundColor = UIColor.white
        }
        if(YearTextfield.text == ""){
            YearTextfield.backgroundColor = UIColor.orange
             ConstAlertBox().showAlertBox(title:"Error",message:"กรุณาเลือกปี",ViewController:self)
            return
            
        }else{
            YearTextfield.backgroundColor = UIColor.white
        }
        
        if(EmailTextfield.text!.count < 6){
            EmailTextfield.backgroundColor = UIColor.orange
            ConstAlertBox().showAlertBox(title:"Error",message:"Username ต้องมากกว่า 6 ตัวอักษร",ViewController:self)
           return
        }
        else{
            EmailTextfield.backgroundColor = UIColor.clear
            
        }
        if (PasswordTextfield.text!.count < 6){
            PasswordTextfield.backgroundColor = UIColor.orange
            ConstAlertBox().showAlertBox(title:"Error",message:"Password ต้องมากกว่า 6 ตัวอักษร",ViewController:self)
            return
        }
        else{
             PasswordTextfield.backgroundColor = UIColor.clear
        }
        if (CheckPasswordTextfield.text!.count < 6){
            
            CheckPasswordTextfield.backgroundColor = UIColor.orange
            ConstAlertBox().showAlertBox(title:"Error",message:"Password ต้องมากกว่า 6 ตัวอักษร",ViewController:self)
            return
        }
        else{
            CheckPasswordTextfield.backgroundColor = UIColor.clear
        }
        if  (PasswordTextfield.text!.hasPrefix(CheckPasswordTextfield.text!)){
            //ถ้า Password  เหมือนกัน
        }
        else{
            CheckPasswordTextfield.backgroundColor = UIColor.orange
            ConstAlertBox().showAlertBox(title:"Error",message:"Password ต้องเหมือนกัน",ViewController:self)
            return
        }
   
        
        
        
        
        
        
        
        
        
     //////CreateUserIntoFirebase//////////////
        
        Auth.auth().createUser(withEmail: EmailTextfield.text!, password: PasswordTextfield.text!,completion: { (user, error) in
            if error ==  nil {
                let alert = UIAlertController(title: "Succeed", message: "ลงทะเบียนเรียบร้อย", preferredStyle: .alert)
                let resultAlert = UIAlertAction(title: "OK", style: .cancel, handler: { (alertAction) in
                    self.performSegue(withIdentifier: "LoginPage", sender: nil)
                })
                alert.addAction(resultAlert)
                self.present(alert, animated: true, completion: nil)
                
                let userUID = Auth.auth().currentUser?.uid //get UID by firebase
               
           //    let createAt = Auth.auth().currentUser?.metadata.creationDate
               
             //Get time createdUsers for database///
                self.timestamp = Date().timeIntervalSince1970
                let lasstime = Date(timeIntervalSince1970: self.timestamp)
                let formatter =  DateFormatter()
                formatter.dateFormat = "dd. MMM yyyy H:mm:ss"
                let createdAt = formatter.string(from: lasstime)
             ////////////////////////////////////////////////////
                if(self.profileImagePicker != nil){
                 self.uploadImagePicker(self.profileImagePicker, userUID!)
                }
                
                
                if(self.MaleSexTik1_Image.isHidden == false){
                    
                                self.savedataIntoDatabase(false,userUID!,createdAt)
                    return
                }
                
                    self.savedataIntoDatabase(true,userUID!,createdAt)
                
                return
                
            }else{
                self.EmailTextfield.backgroundColor = UIColor.orange
                self.PasswordTextfield.backgroundColor = UIColor.orange
                ConstAlertBox().showAlertBox(title:"Error",message:"Email หรือ Password ไม่ถูกต้อง",ViewController:self)
                
                
            
            }
            
        })
        ////////////////////////////////
        //let userID: String = User.uid
  //        let userEmail: String = self.EmailTextfield.text!
  //        let userPassword: String = self.PasswordTextfield.text!
//        let firstname: String = self.FirstNameTextfield.text!
//        let lassname: String = self.LastNameTextfield.text!
//        let phoneNumber: String = self.PhoneTextfiled.text!
//
//
//        self.ref.child("Users").child(User?.uid).setValue(["Email":userEmail,"Password": userPassword,"Firstname":firstname,"Lassname":lassname,"PhoneNumber":phoneNumber])
//        print("succeesfull")
        
        
        
    }
   
 
    
    
    func savedataIntoDatabase(_ sexStatus: Bool,_ userUID:String,_ createdAt:String){
        let userEmail: String = self.EmailTextfield.text!
        let userPassword: String = self.PasswordTextfield.text!
        let firstname: String = self.FirstNameTextfield.text!
        let lassname: String = self.LastNameTextfield.text!
        //let phoneNumber: String = self.PhoneNumTextfield.text!
        let date: String = self.DateTextfield.text!
        let month: String = self.MonthTextfiled.text!
        let years: String = self.YearTextfield.text!
        
        
        
    
        
        
        
        userdatabaseRefer = Database.database().reference()
        
        if(sexStatus == false){
            let dataProfile = ["Email":userEmail,"Password":userPassword,"Firstname":firstname,"Lastname":lassname,"Birthday":"Day "+date+" Month "+month+" Years "+years,"Sex":"Male","CreatedAt":createdAt]
            
            userdatabaseRefer.child("users").child(userUID).setValue(dataProfile)
            return
        }else{
            let dataProfile = ["Email":userEmail,"Password":userPassword,"Firstname":firstname,"Lastname":lassname,"Birthday":"Day "+date+" Month "+month+" Years "+years,"Sex":"faMale","CreatedAt":createdAt]
            
            userdatabaseRefer.child("users").child(userUID).setValue(dataProfile)
        }
        
        //How to update data into firebase//
//       let ref = Database.database().reference()
//        ref.child("users").child("-LOls33w6xwx1w1Lw3gR").child("user2").updateChildValues(["firstname":"kong"])
        
        //How to delete data into firebase//
//        let ref = Database.database().reference()
//        ref.child("users").child("-LOls33w6xwx1w1Lw3gR").child("user2").removeValue()
//        return
        
        return
        
        
    }

    
    /////////////////////////////////////////////

    
////////////ใส่รูปภาพจากภายนอก (Picker)///////
//
  @IBAction func openImagePicker(_ sender: UIButton) {
      let picker = UIImagePickerController()
      picker.delegate = self
      picker.allowsEditing = true
      picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
      self.present(picker, animated: true, completion: nil)
   }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFronPicker: UIImage?
        if let editdImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFronPicker = editdImage
            self.profileImagePicker = editdImage
            self.setupProfile()
        }
        else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFronPicker = originalImage
            self.profileImagePicker = originalImage
            self.setupProfile()
        }
        if let selectedImage = selectedImageFronPicker{
            ProfileImageView.image = selectedImage
            self.setupProfile()
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    ///save ImagePicker URL into firebase//////
    
    func uploadImagePicker(_ img1 : UIImage,_ userUID:String){
         var data = NSData()
         data = UIImageJPEGRepresentation(img1, 0.8)! as NSData
         let metaData =  StorageMetadata()
         metaData.contentType = "imgage/jpg"
         self.storageRef.child("imageUsersProfile").child(userUID).putData(data as Data, metadata: metaData){(metaData,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }else{
                     print("Success upload!")
                let imageURL = (metaData?.downloadURLs?[0].absoluteString)!
                 self.databaseRef.child("users").child(userUID).updateChildValues(["userImageUrl": imageURL])

            }
        }

    }

    func Check(_ stringNumber: String) -> Bool {

        if let _ = Int(stringNumber) {
        return true
        }
        return false
        }
    


    func setupProfile(){
        ProfileImageView.layer.cornerRadius = ProfileImageView.frame.size.width/2
        ProfileImageView.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

    

}

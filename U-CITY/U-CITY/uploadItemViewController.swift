//
//  uploadutemshopViewController.swift
//  U-CITY
//
//  Created by Piyawat on 1/4/2562 BE.
//  Copyright © 2562 semon12694. All rights reserved.
//
import UIKit
import Firebase
import FirebaseDatabase
import Kingfisher

class uploadItemViewController:UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var itemname:UITextField!
    @IBOutlet weak var detail: UITextView!
    @IBOutlet weak var price: UITextField!
    
    var ImagePicker:UIImage!
    var textPost:String!
    let storageRef = Storage.storage().reference()
    let databaseRef = Database.database().reference()
    var timestamp:Double! //get time now
    var userdatabaseRefer: DatabaseReference!
    var databaseHandle: DatabaseHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    //จัดการkeyborad//
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true) //ซ่อนคีย์บอร์ด
        
    }
    
   
    @IBAction func uploadphoto(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        //  picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFronPicker: UIImage?
        if let editdImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFronPicker = editdImage
            self.ImagePicker = editdImage
        }
        else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFronPicker = originalImage
            self.ImagePicker = originalImage
        }
        if let selectedImage = selectedImageFronPicker{
            imageview.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func generateRandomStirng() -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< 8 {
            let random = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(random))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
    
    func uploadImagePicker(_ img1 : UIImage,_ randomItemID:String){
        var data = NSData()
        data = UIImageJPEGRepresentation(img1, 0.8)! as NSData
        let metaData =  StorageMetadata()
        metaData.contentType = "imgage/jpg"
        self.storageRef.child("item").child(randomItemID).putData(data as Data, metadata: metaData){(metaData,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }else{
                print("\n\nSuccess upload!")
                let imageURL = (metaData?.downloadURLs?[0].absoluteString)!
                self.databaseRef.child("Item").child(randomItemID).updateChildValues(["imageItemURL": imageURL])
                
            }
        }
        
    }
    
    
    @IBAction func uploadall(_ sender: Any) {
        let title = self.itemname.text!
        let price2 = self.price.text!
        let detail2 = self.detail.text!
        let randomItemID = generateRandomStirng()
         self.userdatabaseRefer = Database.database().reference()
        
        ///////get time now/////////
        self.timestamp = Date().timeIntervalSince1970
        let lasstime = Date(timeIntervalSince1970: self.timestamp)
        let formatter =  DateFormatter()
        formatter.dateFormat = "dd. MMM yyyy H:mm:ss"
        
        let createdAt = formatter.string(from: lasstime)
        let DetailItem = ["DetailItem": detail2,"ItemName":title,"Price":price2,"CreateAt":createdAt]
       self.userdatabaseRefer.child("Item").child(randomItemID).setValue(DetailItem)
        if(self.imageview.image != nil)
        {
            uploadImagePicker(self.ImagePicker, randomItemID)
        }
    }
    
}

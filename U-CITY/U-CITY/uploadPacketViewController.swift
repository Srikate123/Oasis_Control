//
//  uploadPacketViewController.swift
//  U-CITY
//
//  Created by JayJay on 4/14/19.
//  Copyright © 2019 semon12694. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class uploadPacketViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate  {

    @IBOutlet weak var packetImageView: UIImageView!
    
    @IBOutlet weak var packetName: UITextField!
    @IBOutlet weak var deletePacketImage: UIButton!
    @IBOutlet weak var packetDetail: UITextView!
    @IBOutlet weak var packetPrice: UITextField!
    @IBOutlet weak var insertPacketbtn: UIButton!
    
    var ImagePicker:UIImage!
    var timestamp:Double! //get time now
    let storageRef = Storage.storage().reference()
    let databaseRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.deletePacketImage.isHidden = true
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //ปิดคีย์บอร์ดเมื่อทัชหน้าจอ
    }
    
    
    
    
    ///////import rewards image/////////
    @IBAction func importImage(_ sender: Any) {
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
            packetImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
        self.deletePacketImage.isHidden = false
        self.insertPacketbtn.isHidden = true
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
   
    
    
    @IBAction func deletePacketImageButton(_ sender: Any) {
        self.packetImageView.image = nil
        self.packetImageView.isHidden = true
        self.insertPacketbtn.isHidden = false
    }
    
    
    @IBAction func uploadPacket(_ sender: Any) {
        let databaseRef = Database.database().reference()
        ///////get time now/////////
        self.timestamp = Date().timeIntervalSince1970
        let lasstime = Date(timeIntervalSince1970: self.timestamp)
        let formatter =  DateFormatter()
        formatter.dateFormat = "dd. MMM yyyy H:mm:ss"
        let createdAt = formatter.string(from: lasstime)
        let randomPacketID = self.generateRandomStirng()
        let packetArr = ["packetName":self.packetName.text,"packetDetail":self.packetDetail.text,"packetPrice":self.packetPrice.text]
        databaseRef.child("packet").child(randomPacketID).setValue(packetArr)
        self.databaseRef.child("packet").child(randomPacketID).updateChildValues(["createAt": createdAt])
        self.databaseRef.child("packet").child(randomPacketID).updateChildValues(["packetID": randomPacketID])
        
        if(packetImageView.image != nil){
            uploadImagePicker(self.ImagePicker, randomPacketID)
        }
        
    }
    
    
    func uploadImagePicker(_ img1 : UIImage,_ randomPacketID:String){
        var data = NSData()
        data = UIImageJPEGRepresentation(img1, 0.8)! as NSData
        let metaData =  StorageMetadata()
        metaData.contentType = "imgage/jpg"
        self.storageRef.child("packet").child(randomPacketID).putData(data as Data, metadata: metaData){(metaData,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }else{
                print("\n\nSuccess upload!")
                let imageURL = (metaData?.downloadURLs?[0].absoluteString)!
                self.databaseRef.child("packet").child(randomPacketID).updateChildValues(["imageURL": imageURL])
                
            }
        }
        
    }
    
    //////generate rewards key///////////
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
}



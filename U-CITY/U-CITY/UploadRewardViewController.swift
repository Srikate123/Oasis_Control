//
//  UploadRewardViewController.swift
//  U-CITY
//
//  Created by JayJay on 4/6/19.
//  Copyright © 2019 semon12694. All rights reserved.
//

import UIKit
import Firebase

class UploadRewardViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var rewardImageView: UIImageView!
    
    @IBOutlet weak var rewardName: UITextField!
    @IBOutlet weak var deleteRewardImage: UIButton!
    @IBOutlet weak var rewardDetail: UITextView!
    @IBOutlet weak var rewardPrice: UITextField!
    @IBOutlet weak var insertRewardbtn: UIButton!
    
    var ImagePicker:UIImage!
    var timestamp:Double! //get time now
    let storageRef = Storage.storage().reference()
    let databaseRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.deleteRewardImage.isHidden = true

        
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
            rewardImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
        self.deleteRewardImage.isHidden = false
        self.insertRewardbtn.isHidden = true
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //ปิดคีย์บอร์ดเมื่อทัชหน้าจอ
    }
    
    
    @IBAction func deleteRewardImageButton(_ sender: Any) {
        self.rewardImageView.image = nil
        self.deleteRewardImage.isHidden = true
        self.insertRewardbtn.isHidden = false
    }
    
    
    @IBAction func uploadReward(_ sender: Any) {
        let databaseRef = Database.database().reference()
        ///////get time now/////////
        self.timestamp = Date().timeIntervalSince1970
        let lasstime = Date(timeIntervalSince1970: self.timestamp)
        let formatter =  DateFormatter()
        formatter.dateFormat = "dd. MMM yyyy H:mm:ss"
        let createdAt = formatter.string(from: lasstime)
        let randomRewardID = self.generateRandomStirng()
         let rewardArr = ["rewardName":self.rewardName.text,"rewardDetail":self.rewardDetail.text,"rewardPrice":self.rewardPrice.text]
        databaseRef.child("reward").child(randomRewardID).setValue(rewardArr)
        self.databaseRef.child("reward").child(randomRewardID).updateChildValues(["createAt": createdAt])
        self.databaseRef.child("reward").child(randomRewardID).updateChildValues(["rewardID": randomRewardID])
        
        if(rewardImageView.image != nil){
            uploadImagePicker(self.ImagePicker, randomRewardID)
        }
        
    }
    
    
    func uploadImagePicker(_ img1 : UIImage,_ randomRewardID:String){
        var data = NSData()
        data = UIImageJPEGRepresentation(img1, 0.8)! as NSData
        let metaData =  StorageMetadata()
        metaData.contentType = "imgage/jpg"
        self.storageRef.child("reward").child(randomRewardID).putData(data as Data, metadata: metaData){(metaData,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }else{
                print("\n\nSuccess upload!")
                let imageURL = (metaData?.downloadURLs?[0].absoluteString)!
                self.databaseRef.child("reward").child(randomRewardID).updateChildValues(["imageURL": imageURL])
                
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

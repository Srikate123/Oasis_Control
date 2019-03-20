
import UIKit
import Firebase
import FirebaseDatabase
import Kingfisher

class WritePostViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var writePostTextView: UITextView!
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var writePostImageView: UIImageView!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var userName: UIButton!
    
    var ImagePicker:UIImage!
    var textPost:String!
    let storageRef = Storage.storage().reference()
    let databaseRef = Database.database().reference()
    var timestamp:Double! //get time now
    var userdatabaseRefer: DatabaseReference!
    var databaseHandle: DatabaseHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImage()
        
        
        
        

    }
    
    func setImage(){
         let userUID = Auth.auth().currentUser?.uid
        
    
        
       
       let databaseRef = Database.database().reference()
       databaseRef.child("users").child(userUID!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                let userDict = snapshot.value as! [String: Any]
        
        
                let usernameText = userDict["Firstname"] as! String
        
                self.userName.setTitle(usernameText, for: .normal)
        if(userDict["userImageUrl"]  != nil){
                let profileImageUrl = userDict["userImageUrl"] as! String
                self.imageUser.kf.indicatorType = .activity
                self.imageUser.kf.setImage(with: URL(string: profileImageUrl),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
                self.imageUser.layer.cornerRadius = self.imageUser.frame.size.width/2
                self.imageUser.clipsToBounds = true
        }
        })
    }
    
    
    
    
  
    
    
    
    @IBAction func addImage(_ sender: Any) {
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
            writePostImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
        self.deleteBtn.isHidden = false
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //ปิดคีย์บอร์ดเมื่อทัชหน้าจอ
    }
    
    @IBAction func postClicked(_ sender: Any) {
        if(self.writePostTextView.text.isEmpty == false || self.writePostImageView.image != nil){
            
        let userUID = Auth.auth().currentUser?.uid
        let randomPostID = self.generateRandomStirng()
        ///////read username && userImage
        let databaseRef = Database.database().reference()
        var userNameOwnerPost = "name"
        var profileImageOwnerPost = "imageUserUrl"
        databaseRef.child("users").child(userUID!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                let userDict = snapshot.value as! [String: Any]
                let postOwnerName = userDict["Firstname"] as! String
                userNameOwnerPost = postOwnerName
                print("\n\n\n\(userNameOwnerPost)\n\n\n")
                if(userDict["userImageUrl"]  != nil){
                let profileImageUrl = userDict["userImageUrl"] as! String
                    profileImageOwnerPost = profileImageUrl
                    self.userdatabaseRefer = Database.database().reference()
                    //Get time createdUsers for database///
                    self.timestamp = Date().timeIntervalSince1970
                    let lasstime = Date(timeIntervalSince1970: self.timestamp)
                    let formatter =  DateFormatter()
                    formatter.dateFormat = "dd. MMM yyyy H:mm:ss"
                    let createdAt = formatter.string(from: lasstime)
                    ////////////////////////////////////////////////////
                    let numberOfHaveFun = "0"
                   // let statusHavefun = "true"
                                self.textPost = self.writePostTextView.text!
                    
                    
                                let PostData_1 = ["text":self.textPost,"CreatedAt":createdAt,"PostOwnerId":userUID,"PostID":randomPostID,"userName":  userNameOwnerPost,"profileImage": profileImageOwnerPost]
                                self.userdatabaseRefer.child("Post").child(randomPostID).setValue(PostData_1)
                self.databaseRef.child("Post").child(randomPostID).child("Havefun").updateChildValues(["NumberOfHaveFun": numberOfHaveFun])
            }
                else {
                    self.userdatabaseRefer = Database.database().reference()
                    //Get time createdUsers for database///
                    self.timestamp = Date().timeIntervalSince1970
                    let lasstime = Date(timeIntervalSince1970: self.timestamp)
                    let formatter =  DateFormatter()
                    formatter.dateFormat = "dd. MMM yyyy H:mm:ss"
                    let createdAt = formatter.string(from: lasstime)
                    ////////////////////////////////////////////////////
                    let numberOfHaveFun = "0"
                    // let statusHavefun = "true"
                    self.textPost = self.writePostTextView.text!
                    
                    
                    let PostData_1 = ["text":self.textPost,"CreatedAt":createdAt,"PostOwnerId":userUID,"PostID":randomPostID,"userName":  userNameOwnerPost]
                    self.userdatabaseRefer.child("Post").child(randomPostID).setValue(PostData_1)
                    self.databaseRef.child("Post").child(randomPostID).child("Havefun").updateChildValues(["NumberOfHaveFun": numberOfHaveFun])
            }
            
        })
            
         //"userName":  userNameOwnerPost,"profileImage": profileImageOwnerPost
            
            
            
//            self.databaseRef.child("Post").child(randomPostID).child("statusPostID").child(userUID!).updateChildValues(["statusHavefun": statusHavefun])
        if(writePostImageView.image != nil){
            uploadImagePicker(self.ImagePicker, randomPostID)
        
           
            
            
            
           // self.performSegue(withIdentifier: "feedID", sender: nil)
            
        }
       
        }
    }
    
    func uploadImagePicker(_ img1 : UIImage,_ randomPostID:String){
        var data = NSData()
        data = UIImageJPEGRepresentation(img1, 0.8)! as NSData
        let metaData =  StorageMetadata()
        metaData.contentType = "imgage/jpg"
        self.storageRef.child("Post").child("image").child(randomPostID).putData(data as Data, metadata: metaData){(metaData,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }else{
                print("\n\nSuccess upload!")
                let imageURL = (metaData?.downloadURLs?[0].absoluteString)!
                self.databaseRef.child("Post").child(randomPostID).updateChildValues(["imageURL": imageURL])
                
            }
        }
        
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
    
    @IBAction func deleteImage(_ sender: Any) {
        self.writePostImageView.image = nil
        self.deleteBtn.isHidden = true
    }
}

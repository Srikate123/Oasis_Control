//
//  FeedViewController.swift
//  U-CITY
//
//  Created by JayJay on 1/10/19.
//  Copyright © 2019 semon12694. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Kingfisher
class FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var tableView:UITableView!
    

    var userdatabaseRefer: DatabaseReference!
    let storageRef = Storage.storage().reference()
    let databaseRef = Database.database().reference()
    var databaseHandle: DatabaseHandle!
    var postDataArr = [PostData]()
    var userUID:NSArray = []
    
    var postID = String()

    
    var Case = 0

    
   
    @IBAction func logOutClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut()

        } catch let error as NSError{
            print(error.localizedDescription)
            
        }
    }
    
    func showPostData(){
        
        let databaseRef = Database.database().reference().child("Post")
        databaseRef.queryOrdered(byChild: "CreatedAt").observe(DataEventType.value, with: { (Snapshot) in
            if Snapshot.childrenCount>0{
                self.postDataArr.removeAll()
                for Post in Snapshot.children.allObjects as! [DataSnapshot]{
                    let postObject = Post.value as? [String: AnyObject]
                    let createdAtData = postObject?["CreatedAt"]
                    let postOwnerId = postObject?["PostOwnerId"] as! String
                    let postID = postObject?["PostID"] as! String
                    let userName = postObject?["userName"] as! String
                    let profileImageUrl = postObject?["profileImage"] as? String
                    let NumberOfHaveFun = postObject?["NumberOfHaveFun"] as? String
                    self.Case = 0
                    var statusHavefunClicked = "false"
                    
                    
                    print("\(NumberOfHaveFun)4444444")
                    
                    
                    
                    
//                    let databaseReference = Database.database().reference().child("Post").child(postID).child("statusPostID")
//                    let userUID = Auth.auth().currentUser?.uid
//                    databaseReference.child(userUID!).observeSingleEvent(of: .value, with: { Snapshot in
//                        if let statusHavefun = Snapshot.value as? [String: AnyObject]{
//                            statusHavefunClicked = statusHavefun["statusHavefun"] as! String
//                            print("\n\n\n\(statusHavefunClicked)555\n\n\n")
//                        }
//                    })
                  
                    if(postObject?["imageURL"]  != nil && postObject?["text"] != nil){
                        self.Case = 1
                        let postImageUrlData = postObject?["imageURL"] as! String
                        let postTextData = postObject?["text"] as! String
                        let Data = PostData(postText: postTextData,postImageURL: postImageUrlData,createAt: createdAtData as! String?,Case: self.Case,postOwnerID: postOwnerId,postID: postID,statusHavefunClicked: statusHavefunClicked,userName:  userName,profileImageUrl: profileImageUrl,NumberOfHaveFun: NumberOfHaveFun)
                        self.postDataArr.insert(Data, at: 0) //sort Data มากไปน้อย
                        self.tableView.reloadData()
                                                }
                        
                    else if(postObject?["imageURL"]  == nil && postObject?["text"] != nil){
                        self.Case = 2
                        let postTextData = postObject?["text"] as! String
                        let Data = PostData(postText: postTextData,createAt: createdAtData as! String?,Case:self.Case,postOwnerID: postOwnerId,postID: postID,statusHavefunClicked: statusHavefunClicked,userName: userName,profileImageUrl: profileImageUrl,NumberOfHaveFun: NumberOfHaveFun)
                        self.postDataArr.insert(Data, at: 0) //sort Data มากไปน้อย
                        self.tableView.reloadData()
                    }
                        
                    else if(postObject?["imageURL"]  != nil && postObject?["text"] == nil){
                        self.Case = 3
                        let postImageUrlData = postObject?["imageURL"] as! String
                        let Data = PostData(postImageURL: postImageUrlData,createAt: createdAtData as! String?,Case:self.Case,postOwnerID: postOwnerId,postID: postID,statusHavefunClicked: statusHavefunClicked,userName: userName,profileImageUrl: profileImageUrl,NumberOfHaveFun: NumberOfHaveFun)
                        self.postDataArr.insert(Data, at: 0) //sort Data มากไปน้อย
                        self.tableView.reloadData()
                            }
                   
                    
                    
                        }
                
                
           }
                        
            
         
          
        })
        
                
                
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "postCell")
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        showPostData()
        
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
       
         let Data: PostData
       
        Data = postDataArr[indexPath.row]
        if(Data.Case == 2){
            cell.userName.setTitle(Data.userName, for: .normal)
            cell.postIDLabel.text = Data.postID
           
                 cell.haveFunLabel.text = " Have fun"
           
            
            let statusHavefun = Bool(Data.statusHavefunClicked)
            if(statusHavefun == true){
                cell.imageHavefun.image = UIImage(named: "smile")
            }
            else{
                cell.imageHavefun.image = UIImage(named: "smile (1)")
            }
           // cell.haveFunLabel.text = Data.NumberOfHaveFun
          
            if(Data.profileImage?.isEmpty == false){
                cell.profileImage.kf.indicatorType = .activity
                cell.profileImage.kf.setImage(with: URL(string: Data.profileImage!),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
                cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width/2
                cell.profileImage.clipsToBounds = true
            }
            else{
                cell.profileImage.kf.indicatorType = .activity
                cell.profileImage.kf.setImage(with: URL(string: "http://www.singaporetennisschool.com/assets/news/1470035223_579ef517aa5ed_profile_icon.png"),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
                cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width/2
                cell.profileImage.clipsToBounds = true
            }

            cell.postText.text = Data.postText
            cell.postImage.image = nil
           
            
           

            cell.createAt.text = Data.createAt
            return cell
        }
        else if(Data.Case == 1){
         cell.userName.setTitle(Data.userName, for: .normal)
         cell.postIDLabel.text = Data.postID
         cell.haveFunLabel.text = " Have fun"
            
         let statusHavefun = Bool(Data.statusHavefunClicked)
         if(statusHavefun == true){
                cell.imageHavefun.image = UIImage(named: "smile")
            }
         else{
            cell.imageHavefun.image = UIImage(named: "smile (1)")
            }
            
            //cell.haveFunLabel.text = Data.NumberOfHaveFun
         
         if(Data.profileImage?.isEmpty == false){
                cell.profileImage.kf.indicatorType = .activity
                cell.profileImage.kf.setImage(with: URL(string: Data.profileImage!),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
                cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width/2
                cell.profileImage.clipsToBounds = true
            }
         else{
                cell.profileImage.kf.indicatorType = .activity
                cell.profileImage.kf.setImage(with: URL(string: "http://www.singaporetennisschool.com/assets/news/1470035223_579ef517aa5ed_profile_icon.png"),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
                cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width/2
                cell.profileImage.clipsToBounds = true
            }

            
         cell.postText.text = Data.postText
         cell.createAt.text = Data.createAt
         cell.postImage.kf.indicatorType = .activity
         cell.postImage.kf.setImage(with: URL(string: Data.postImageViewURL!),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
        
            
            return cell
        }
        
       else if(Data.Case == 3){
            cell.userName.setTitle(Data.userName, for: .normal)
            cell.postIDLabel.text = Data.postID
            cell.haveFunLabel.text = " Have fun"
            let statusHavefun = Bool(Data.statusHavefunClicked)
            if(statusHavefun == true){
                cell.imageHavefun.image = UIImage(named: "smile")
            }
            else{
                cell.imageHavefun.image = UIImage(named: "smile (1)")
            }
            
            // cell.haveFunLabel.text = Data.NumberOfHaveFun
            if(Data.profileImage?.isEmpty == false){
                cell.profileImage.kf.indicatorType = .activity
                cell.profileImage.kf.setImage(with: URL(string: Data.profileImage!),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
                cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width/2
                cell.profileImage.clipsToBounds = true
            }
            else {
                cell.profileImage.kf.indicatorType = .activity
                cell.profileImage.kf.setImage(with: URL(string: "http://www.singaporetennisschool.com/assets/news/1470035223_579ef517aa5ed_profile_icon.png"),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
                cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width/2
                cell.profileImage.clipsToBounds = true
            }

          
            cell.createAt.text = Data.createAt
            cell.postImage.kf.indicatorType = .activity
            cell.postImage.kf.setImage(with: URL(string: Data.postImageViewURL!),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
            cell.postImage.layer.cornerRadius = cell.postImage.frame.size.width/4
           
           
            return cell
        }


        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        print("333")
        print("444")
        print("555")
        print("12หห3")
        print("321")
        print("333")
        print("435")
        print("11111")
        print("789")
        print("233111")
        
        
    }
    


}




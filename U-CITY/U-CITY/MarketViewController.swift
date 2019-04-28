//
//  MarketViewController.swift
//  U-CITY
//
//  Created by JayJay on 2/20/19.
//  Copyright © 2019 semon12694. All rights reserved.
//

import UIKit
import Firebase

class MarketViewController: UIViewController,UICollectionViewDataSource , UICollectionViewDelegate {
    
     @IBOutlet weak var itemCollectionView: UICollectionView!
    
    @IBOutlet weak var Level: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var coinLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemCollectionView.dataSource = self
        self.itemCollectionView.delegate = self
        showItem()
        showCoin()
        showLevel()
        showDataProfile()
       
    }
   
    // setting collecttionViewCell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ItemdataArr.count;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketShop", for: indexPath) as! MarketCollectionViewCell
        let itemshop:itemshop
        itemshop = ItemdataArr[indexPath.row]
        cell.itemTitle.text = itemshop.ItemName
        cell.itemCost.text =  itemshop.ItemPrice
        cell.itemImage.kf.indicatorType = .activity
        cell.itemImage.kf.setImage(with:URL(string: itemshop.ImageItem),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
        // cell.itemTitle.text = ""
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let cell = collectionView.cellForItem(at: indexPath)
        //        self.selectedItem = itemsArray[indexPath.row]
        //        cell?.backgroundColor = UIColor.green
        self.performSegue(withIdentifier: "DetailView", sender: nil)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //   let cell = collectionView.cellForItem(at: indexPath)
        // cell?.backgroundColor = UIColor.orange
    }
    
    
    func showCoin(){
        let userUID = Auth.auth().currentUser?.uid
        
        
        
        
        let databaseRef = Database.database().reference()
        databaseRef.child("Inventory").child(userUID!).child("asset").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let userDict = snapshot.value as! [String: Any]
            
            
            let coinText = userDict["Coin"] as! String
            
            self.coinLabel.text = coinText
            
            
        })
    }
    
    func showLevel(){
        let userUID = Auth.auth().currentUser?.uid
        
        
        
        
        let databaseRef = Database.database().reference()
        databaseRef.child("Inventory").child(userUID!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let userDict = snapshot.value as! [String: Any]
            if(userDict["Level"] != nil){
            let Level = userDict["Level"] as! String
            self.Level.text = "Lv. "+Level
            }
            
        })
    }
    
    func showDataProfile(){
        let userUID = Auth.auth().currentUser?.uid
        
        
        
        
        let databaseRef = Database.database().reference()
        databaseRef.child("users").child(userUID!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let userDict = snapshot.value as! [String: Any]
            
            let Username = userDict["Firstname"] as! String
            self.userName.text = Username
            if(userDict["userImageUrl"] != nil){
                let Image = userDict["userImageUrl"] as? String
                self.imageUser.kf.indicatorType = .activity
                self.imageUser.kf.setImage(with: URL(string: Image!),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
                self.imageUser.layer.cornerRadius = self.imageUser.frame.size.width/2
                self.imageUser.clipsToBounds = true
            }
            
            
        })
    }
    
    
    
    
    
    var  ItemdataArr = [itemshop]()
    
    func showItem(){
        let databaseRef = Database.database().reference().child("Item") //เป็นการเรียกdatabase โดยระบุหัวตารางที่ชื่อ  item
      /*queryoder เรียง */  databaseRef.queryOrdered(byChild: "CreatedAt").observe(DataEventType.value, with: { (Snapshot) in
            if Snapshot.childrenCount>0{
                self.ItemdataArr.removeAll()
                for Item in Snapshot.children.allObjects as! [DataSnapshot]{
                    let ItemObject = Item.value as? [String: AnyObject]
                   
                    let ItemName = ItemObject?["ItemName"] as!  String
                    let Price = ItemObject?["Price"] as?  String
                    
                   // let CreateAt = ItemObject?["CreateAt"] as?  String
                    if(ItemObject?["imageItemURL"] != nil){
                        let ImageItem = ItemObject?["imageItemURL"] as? String
                        let Data = itemshop(ItemName: ItemName, ItemPrice: Price, ImageItem: ImageItem)
                        self.ItemdataArr.insert(Data, at: 0) //sort Data มากไปน้อย
                      
                        self.itemCollectionView.reloadData()
                    }
                    
                }
            }
            
            
        })
    }
    

}

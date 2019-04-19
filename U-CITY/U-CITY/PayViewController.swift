//
//  PayViewController.swift
//  U-CITY
//
//  Created by JayJay on 4/14/19.
//  Copyright © 2019 semon12694. All rights reserved.
//

import Firebase
import UIKit
import Kingfisher
class PayViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    override func viewDidLoad()
        { super.viewDidLoad()
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
            showpack();
            // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                    return packArr.count
                
            }
            
            
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "payView", for: indexPath) as! PayCollectionViewCell
                let pay1:pay
                pay1 = packArr[indexPath.row]
                cell.imageView.kf.indicatorType = .activity
                cell.imageView.kf.setImage(with:URL(string:pay1.imageView),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
                return cell
                
            }
            
            
            var packArr = [pay]()
            
            func showpack() {
                
                    let databaseRef = Database.database().reference().child("packet") //เป็นการเรียกdatabase โดยระบุหัวตารางที่ชื่อ item /*queryoder เรียง */
                    databaseRef.queryOrdered(byChild:"CreatedAt").observe(DataEventType.value, with: { (Snapshot) in if Snapshot.childrenCount>0{
                    self.packArr.removeAll()
                        for packet in Snapshot.children.allObjects as! [DataSnapshot]{
                            let PayObject = packet.value as? [String: AnyObject] //
                           // let CreateAt = PayObject?["CreateAt"] as? String
                            if(PayObject?["imageURL"] != nil){
                                let Imagepay1 = PayObject?["imageURL"] as? String
                                let Data = pay(imageView: Imagepay1)
                                self.packArr.insert(Data, at: 0)
                                self.collectionView.reloadData()
                                
                            }
                            
                        }
                        
                        }
                        
                    })
                    
            }
            
}




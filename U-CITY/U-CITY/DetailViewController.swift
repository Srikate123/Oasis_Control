//
//  DetailViewController.swift
//  U-CITY
//
//  Created by JayJay on 2/22/19.
//  Copyright © 2019 semon12694. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class DetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var rewardPrice: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
   var image = " "
   var name = ""
   var Detail = ""
   var price = ""
   var rewardID = ""

  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsSelection = false  //setting is not selected Row isside tableView
        
//        RewardDataArr.removeAll()
//       // let Data = RewardDetailClass(rewardName: name, rewardDetail: Detail)
//        self.RewardDataArr.insert(Data, at: 0)
        
    
        
        rewardPrice.text = price
//        rewardImage.kf.indicatorType = .activity
//        rewardImage.kf.setImage(with: URL(string: image),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureCell") as! FeatureCell
            cell.RewardName.text = name
            cell.RewardDetail.text = Detail
            
            
            
            return cell
        }
    }
  
    
     var rewardDataArr = [rewardShop]()
    
//    func showRewardDeatail(){
//      //  let rewardData: rewardShop
//        //rewardData = rewardDataArr[indexPath.row]
//        rewardNameLabel = rewardDetailClass.rewardName
//        self.rewardDetail.text = rewardData.rewardDetail
//        self.rewardPrice.text = rewardData.rewardPrice
//    }

    func showDetail(rewardID: String!){
      
        
        
        
        let databaseRef = Database.database().reference()
        databaseRef.child("reward").child(rewardID!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let userDict = snapshot.value as! [String: Any]
            let Level = userDict["rewardName"] as! String
            print(Level)
           /// self.levelLabel.text = Level
        })
    }
    
    @IBAction func buyClicked(_ sender: Any) {
        
        
        
    }
    
   
    
}

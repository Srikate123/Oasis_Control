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

class DetailViewController: UIViewController {

    @IBOutlet weak var rewardImage: UIImageView!
    @IBOutlet weak var rewardName: UILabel!
    @IBOutlet weak var rewardDetail: UITextView!
    @IBOutlet weak var rewardPrice: UILabel!
    var rewardNameLabel:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
     var rewardDataArr = [rewardShop]()
    
//    func showRewardDeatail(){
//      //  let rewardData: rewardShop
//        //rewardData = rewardDataArr[indexPath.row]
//        rewardNameLabel = rewardDetailClass.rewardName
//        self.rewardDetail.text = rewardData.rewardDetail
//        self.rewardPrice.text = rewardData.rewardPrice
//    }

    
    @IBAction func buyClicked(_ sender: Any) {
        
        
        
    }
    
    
}

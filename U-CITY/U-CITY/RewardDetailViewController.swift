//
//  RewardDetailViewController.swift
//  U-CITY
//
//  Created by JayJay on 4/6/19.
//  Copyright © 2019 semon12694. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class RewardDetailViewController: UIViewController {
    @IBOutlet weak var rewardImage: UIImageView!
    @IBOutlet weak var rewardName: UILabel!
    
    @IBOutlet weak var rewardPrice: UILabel!
    @IBOutlet weak var rewardDetail: UILabel!
    var rewardName2 = "item"
    
    var rewardDataArr = [rewardShop]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            rewardName.text = rewardName2
        
    }
  
    

   

}

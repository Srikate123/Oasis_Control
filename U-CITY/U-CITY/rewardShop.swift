//
//  rewardShop.swift
//  U-CITY
//
//  Created by JayJay on 4/6/19.
//  Copyright © 2019 semon12694. All rights reserved.
//

import Foundation

class rewardShop {
    var rewardName:String?
    var rewardDetail:String?
    var rewardPrice:String?
    var rewardImage:String!
    var rewardID:String!
    
    init(rewardName:String!,rewardDetail:String!,rewardPrice:String!,rewardImage:String!,rewardID:String!){
        self.rewardName = rewardName
        self.rewardDetail = rewardDetail
        self.rewardPrice = rewardPrice
        self.rewardImage = rewardImage
        self.rewardID = rewardID
    
    }
}

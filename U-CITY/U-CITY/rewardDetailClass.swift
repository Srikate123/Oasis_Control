//
//  rewardDetailClass.swift
//  U-CITY
//
//  Created by JayJay on 4/23/19.
//  Copyright © 2019 semon12694. All rights reserved.
//

import Foundation
import Firebase
import Kingfisher

class rewardDetailClass {
    var rewardName: String?
    var rewardPrice: String?
    var rewardDetail:String?
    var rewardImageUrl:String?
    
    init(rewardName:String!,rewardPrice:String!,rewardDetail:String!,rewardImageUrl:String!) {
        
       
            
            self.rewardName = rewardName
            self.rewardPrice = rewardPrice
            self.rewardDetail = rewardDetail
            self.rewardImageUrl = rewardImageUrl
            
            print(rewardName)
            print(rewardDetail)
            print(rewardPrice)
            print(rewardImageUrl)
            
            
            
       
        
    }
}

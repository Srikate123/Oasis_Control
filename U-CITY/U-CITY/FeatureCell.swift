//
//  FeatureCell.swift
//  U-CITY
//
//  Created by JayJay on 4/27/19.
//  Copyright © 2019 semon12694. All rights reserved.
//

import UIKit

class FeatureCell: UITableViewCell {
    @IBOutlet weak var RewardDetail: UILabel!
    
    @IBOutlet weak var RewardName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}

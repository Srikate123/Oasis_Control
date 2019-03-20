//
//  ProfileTableViewCell.swift
//  U-CITY
//
//  Created by JayJay on 2/4/19.
//  Copyright © 2019 semon12694. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var imageBg: UIImageView!
    @IBOutlet weak var imageBtn: UIButton!
    @IBOutlet weak var barName: UIImageView!
    @IBOutlet weak var refil: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var inventoryBtn: UIButton!
    @IBOutlet weak var rewardBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  SettingCollectionViewCell.swift
//  U-CITY
//
//  Created by semon12694 on 27/4/2561 BE.
//  Copyright © 2561 semon12694. All rights reserved.
//

import Foundation
class SettingColectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image1:UIImage!
    var setting:setting!{
        didSet {
            image1.images = setting.image1
        }
    }
}

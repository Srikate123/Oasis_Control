//
//  ProductsCollection.swift
//  U-CITY
//
//  Created by JayJay on 4/27/19.
//  Copyright © 2019 semon12694. All rights reserved.
//

import UIKit
import Kingfisher

class ProductsCollection: UICollectionView,UICollectionViewDataSource,UICollectionViewDelegate {

    
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        return cell
    }
}

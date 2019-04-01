//
//  MarketViewController.swift
//  U-CITY
//
//  Created by JayJay on 2/20/19.
//  Copyright © 2019 semon12694. All rights reserved.
//

import UIKit

class MarketViewController: UIViewController,UICollectionViewDataSource , UICollectionViewDelegate {
    
     @IBOutlet weak var itemCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemCollectionView.dataSource = self
        self.itemCollectionView.delegate = self
 
       
    }
   
    // setting collecttionViewCell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketShop", for: indexPath) as! MarketCollectionViewCell
        
        // cell.itemTitle.text = ""
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let cell = collectionView.cellForItem(at: indexPath)
        //        self.selectedItem = itemsArray[indexPath.row]
        //        cell?.backgroundColor = UIColor.green
        self.performSegue(withIdentifier: "DetailView", sender: nil)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //   let cell = collectionView.cellForItem(at: indexPath)
        // cell?.backgroundColor = UIColor.orange
    }
    
    

}

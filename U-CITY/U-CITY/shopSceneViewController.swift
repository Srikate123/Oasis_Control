

import UIKit

class shopSceneViewController: UIViewController,UICollectionViewDataSource , UICollectionViewDelegate {
    @IBOutlet weak var itemCollectionView: UICollectionView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemCollectionView.dataSource = self
        self.itemCollectionView.delegate = self
        
    
    }
   
    
    
    
    
    // setting collecttionViewCell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemShop", for: indexPath) as! shopCollectionViewCell
        
       // cell.itemTitle.text = ""
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        self.selectedItem = itemsArray[indexPath.row]
//        cell?.backgroundColor = UIColor.green
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
     //   let cell = collectionView.cellForItem(at: indexPath)
       // cell?.backgroundColor = UIColor.orange
    }
}

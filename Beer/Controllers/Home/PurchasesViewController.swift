//
//  PurchasesViewController.swift
//  Beer
//
//  Created by Melanie on 11/2/18.
//

import UIKit

class PurchasesViewController: UIViewController {
    @IBOutlet weak var purchasesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
extension PurchasesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.layer.cornerRadius = 8
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
    
    
}

//
//  CartProductsViewController.swift
//  Beer
//
//  Created by Melanie on 10/31/18.
//

import UIKit

class CartProductsViewController: UIViewController {

    @IBOutlet weak var cartProductsCollectionView: UICollectionView!
    private let cellIdentifier = "cartProductCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cartProductsCollectionView.register(UINib(nibName: "CartProductsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
}

extension CartProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CartProductsCollectionViewCell
        return cell
    }
}

extension CartProductsCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if  UIScreen.main.bounds.width <= 320 {
            return CGSize(width: 300, height: 160)
        }else {
            return CGSize(width: collectionView.bounds.width, height: 160)
        }
    }
}

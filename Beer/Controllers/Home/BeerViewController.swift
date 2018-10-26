//
//  BeerViewController.swift
//  Beer
//
//  Created by Melanie on 10/26/18.
//

import UIKit
import SDWebImage

class BeerViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var heights: [CGFloat] = []
    private var products: [Product]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        for url in urls {
        //            let url = URL(string: url)
        //            let data = try? Data(contentsOf: url!)
        //            images.append(UIImage(data: data!)!)
        //        }
        
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        getData()
        //        collectionView.scrollToItem(at: IndexPath(row: 8, section: 0), at: UICollectionView.ScrollPosition.top, animated: false)
    }
    
    private func getData() {
        BeerEndPoint.getDrinks { (receivedProducts, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let newProducts = receivedProducts {
                self.products = newProducts
                self.collectionView.reloadData()
                for _ in 0..<self.products.count {
                    self.heights.append(CGFloat.random(in: 130.5...300.0))
                }                
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: UICollectionView.ScrollPosition.top, animated: false)
    }
    
}

extension BeerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ProductCollectionViewCell
        cell.imagen.sd_setImage(with: URL(string: products[indexPath.row].image), placeholderImage: UIImage(named: "imagen"), options: [.continueInBackground, .progressiveDownload], completed: nil)
        cell.layer.cornerRadius = 5
        cell.descuentoView.layer.cornerRadius = 4
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.layer.shadowOpacity = 1
        cell.layer.shadowRadius = 1.0
        cell.clipsToBounds = false
        cell.layer.masksToBounds = false
        cell.nameProductLabel.text = products[indexPath.row].name
        if products[indexPath.row].isOffer == true && products[indexPath.row].offer > 0{
            cell.discountLabel.text = "\(products[indexPath.row].offer)%"
        }else {
            cell.descuentoView.isHidden = true
        }
        return cell
    }
}

extension BeerViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return heights[indexPath.row]
    }
}

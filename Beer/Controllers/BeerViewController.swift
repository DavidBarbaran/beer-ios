//
//  BeerViewController.swift
//  Beer
//
//  Created by Melanie on 10/15/18.
//

import UIKit
import GlidingCollection
import Hero

class BeerViewController: UIViewController {
    
    @IBOutlet weak var glidingView: GlidingCollection!
    fileprivate var collectionView: UICollectionView!
    fileprivate var items = ["cerveza", "boots"]
    fileprivate var images: [[UIImage?]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

// MARK: - Setup
extension BeerViewController {
    
    func setup() {
        setupGlidingCollectionView()
        loadImages()
    }
    
    private func setupGlidingCollectionView() {
        glidingView.dataSource = self
        
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        collectionView = glidingView.collectionView
        collectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = glidingView.backgroundColor
    }
    
    private func loadImages() {
        for item in items {
            let imageURLs = FileManager.default.fileUrls(for: "jpeg", fileName: item)
            var images: [UIImage?] = []
            for url in imageURLs {
                guard let data = try? Data(contentsOf: url) else { continue }
                let image = UIImage(data: data)
                images.append(image)
            }
            self.images.append(images)
        }
    }
    
}

// MARK: - CollectionView 🎛
extension BeerViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = glidingView.expandedItemIndex
        return images[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        let section = glidingView.expandedItemIndex
        let image = images[section][indexPath.row]
        cell.productImageView.image = image
        cell.contentView.clipsToBounds = true
        cell.hero.id = String(indexPath.row)
        let layer = cell.layer
        let config = GlidingConfig.shared
        layer.shadowOffset = config.cardShadowOffset
        layer.shadowColor = config.cardShadowColor.cgColor
        layer.shadowOpacity = config.cardShadowOpacity
        layer.shadowRadius = config.cardShadowRadius
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = glidingView.expandedItemIndex
        let item = indexPath.item
        print("Selected item #\(item) in section #\(section)")
        
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "productDetail") as! ProductDetailViewController
        detailVC.hero.isEnabled = true
        let image = images[section][indexPath.row]
        detailVC.contentView.frame = CGRect(x: 30, y: 100, width: 200, height: 300)
        detailVC.contentView.hero.id = String(indexPath.row)
        detailVC.contentView.image = image
        let layer = detailVC.contentView.layer
        let config = GlidingConfig.shared
        layer.shadowOffset = config.cardShadowOffset
        layer.shadowColor = config.cardShadowColor.cgColor
        layer.shadowOpacity = config.cardShadowOpacity
        layer.shadowRadius = config.cardShadowRadius
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
         self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
}

// MARK: - Gliding Collection 🎢
extension BeerViewController: GlidingCollectionDatasource {
    
    func numberOfItems(in collection: GlidingCollection) -> Int {
        return items.count
    }
    
    func glidingCollection(_ collection: GlidingCollection, itemAtIndex index: Int) -> String {
        return "☛  " + items[index]
    }
    
}

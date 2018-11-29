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
        let rightGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.backOnSwipe(_:)))
        self.view.addGestureRecognizer(rightGesture)
    }
    
    @objc func backOnSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func buyProducts(_ sender: Any) {
        if let user = UserDefaults.standard.object(forKey: Constants.USER) as? [String: String], Utils.productsCart.count > 0 {
            var parameters: [[String: Any]] = []
            for item in Utils.productsCart {
                parameters.append(["cantidad" : item.quantity,"item": item.id])
            }
            BeerEndPoint.addToCart(userID: user["userID"]!, items: parameters) { (message, error) in
                if let error = error {
                    let alert = Utils.showAlert(withTitle: Constants.ERROR, message: error)
                    self.present(alert, animated: true)
                    return
                }
                
                if let _ = message {
                    let alert = Utils.showAlert(withTitle: Constants.NOTICE, message: "Compra realizada")
                    self.present(alert, animated: true)
                    Utils.productsCart.removeAll()
                }
            }
        }else {
            let alert = Utils.showAlert(withTitle: Constants.ERROR, message: "No ha agregado ni un producto aún")
            self.present(alert, animated: true)
        }
    }
}

extension CartProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Utils.productsCart.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CartProductsCollectionViewCell
        cell.productImageView.image = Utils.productsCart[indexPath.row].image
        cell.cantLabel.text = String(Utils.productsCart[indexPath.row].quantity)
        cell.priceLabel.text = String(Utils.productsCart[indexPath.row].price)
        cell.productNameLabel.text = Utils.productsCart[indexPath.row].id
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

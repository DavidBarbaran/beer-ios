//
//  ProductDetailViewController.swift
//  Beer
//
//  Created by Melanie on 10/16/18.
//

import UIKit
import Hero

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var productDescriptionTextView: UITextView!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var addProductButton: UIButton!
    @IBOutlet weak var newProductButton: UIButton!
    @IBOutlet weak var decreaseProductButton: UIButton!
    @IBOutlet weak var cantProductLabel: UILabel!
    
    let contentView = UIImageView()
    private var productCount = Int()
//    let newProductButton = SSBadgeButton()
    var prodcut: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        contentView.frame = CGRect(x: 0, y: 0, width: productView.bounds.width, height: productView.bounds.height)
        view.addSubview(contentView)
        productView.addSubview(contentView)
        productView.layer.cornerRadius = 10
        
//        addProductButton.layer.cornerRadius = addProductButton.bounds.width/2.0
//        addProductButton.layer.shadowColor = UIColor.lightGray.cgColor
//        addProductButton.layer.shadowOffset = CGSize(width: 3, height: 3)
//        addProductButton.layer.shadowOpacity = 1
//        addProductButton.layer.shadowRadius = 1.0
//        addProductButton.clipsToBounds = false
//        addProductButton.layer.masksToBounds = false
                
        if let product = prodcut {
            productDescriptionTextView.text = product.description
            amountLabel.text = "S/.\(product.price)"
            categoryLabel.text = product.category
            
            if product.isOffer {
                discountLabel.isHidden = false
                let totalPrice = product.price - (product.price*Double(product.offer)/100)
                discountLabel.text = "S/.\(totalPrice)"
            }

        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func addNewProductAction(_ sender: UIButton) {
        productCount+=1
        cantProductLabel.text = "\(productCount)"
        
//        if productCount == 0 {
//            newProductButton.badgeLabel.isHidden = true
//        }else {
//            newProductButton.badge = "\(productCount)"
//        }
//
//        addProductButton.addSubview(newProductButton)
    }
    
    @IBAction func decreaseProductAction(_ sender: UIButton) {
        if productCount == 0 {
            return
        }
        productCount-=1
        cantProductLabel.text = "\(productCount)"
    }
    
    
    @IBAction func backAction(_ sender: Any) {
       self.navigationController?.popViewController(animated: true)
    }
    
    
}

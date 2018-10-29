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
    
    let contentView = UIImageView()
    var prodcut: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        contentView.layer.cornerRadius = 10
//        contentView.layer.masksToBounds = false
        contentView.frame = CGRect(x: 0, y: 0, width: productView.bounds.width, height: productView.bounds.height)
        view.addSubview(contentView)
        productView.addSubview(contentView)
        productView.layer.cornerRadius = 10
        
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
    
    @IBAction func backAction(_ sender: Any) {
       self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

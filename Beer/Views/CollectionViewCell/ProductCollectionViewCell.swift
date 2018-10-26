//
//  ProductCollectionViewCell.swift
//  Beer
//
//  Created by Melanie on 10/26/18.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var nameProductLabel: UILabel!
    @IBOutlet weak var descuentoView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var discountLabel: UILabel!
    
    override func awakeFromNib() {
        self.containerView.layer.cornerRadius = 5
        self.containerView.layer.masksToBounds  = true
    }
    
}

//
//  CollectionViewCell.swift
//  VapingApp
//
//  Created by iOSayed on 16/12/2022.
//

import UIKit

class ProductsCell: UICollectionViewCell {
    
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
        
    @IBOutlet weak var imageHeightConstrant: NSLayoutConstraint!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    
    func setData(from product :ProductModel ) {
         setImageFromUrl(from: product.image.url)
        self.productPriceLabel.text = "\(product.price)$"
        self.productPriceLabel.numberOfLines = 0
        self.productDescriptionLabel.text = product.productDescription
        self.imageHeightConstrant.constant = CGFloat(product.image.height)
        self.imageWidthConstraint.constant = CGFloat(product.image.width)
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight]
     }
    
    override func layoutSubviews() {
       self.layoutIfNeeded()
      }
    
    
}
extension ProductsCell {
    func setImageFromUrl (from url:String){
        if let url = URL(string: url){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                }else{
                    guard let imageData = data else { return }
                
                DispatchQueue.main.async {
                    self.productImageView.image = UIImage(data: imageData)
                }
            }
        }.resume()
        }
        
    }
    
}

//
//  DetailsVC.swift
//  VapingApp
//
//  Created by iOSayed on 17/12/2022.
//

import UIKit

class DetailsVC: UIViewController  {
    
    var product:ProductModel?
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var productDetailsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Products Details"
        view.alpha = 1
        fillData()
    }
    

    @IBAction func backButtonClicked(_ sender: UIButton) {
         dismissDetail()
    
    }
    
    
    
    //MARK: Functions
    
    private func fillData(){
        if let url = product?.image.url , let price = product?.price , let description = product?.productDescription {
          
            DispatchQueue.main.async {
                self.setImageFromUrl(from:url )
                self.priceLabel.text = "Price   \(price) $"
                self.productDetailsLabel.text = description

            }
        }
    }
    
}
extension DetailsVC {
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

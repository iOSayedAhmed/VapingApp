//
//  ProductsLoadingFooter.swift
//  VapingApp
//
//  Created by iOSayed on 17/12/2022.
//

import UIKit

class ProductsLoadingFooter: UICollectionReusableView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .darkGray
        spinner.startAnimating()
        
        let label = UILabel()
        label.text = "Loading More ..."
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 17)
        
        let stackView = UIStackView(arrangedSubviews: [spinner , label])
        stackView.spacing = 2
        stackView.axis = .vertical
        
        stackView.frame = self.frame
        addSubview(stackView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

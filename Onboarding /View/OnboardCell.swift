//
//  OnboardCell.swift
//  VapingApp
//
//  Created by iOSayed on 16/12/2022.
//

import UIKit

class OnboardCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var ValuePropositionsLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var slideImageView: UIImageView!
    
    func setUp(_ slide : SlideModel) {
        self.titleLabel.text = slide.title
        self.ValuePropositionsLabel.text = slide.ValueProposition
        self.slideImageView.image = slide.image
        self.subTitleLabel.text = slide.subTitle
    }
}

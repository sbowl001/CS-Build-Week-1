//
//  SquareCollectionViewCell.swift
//  Game of Life
//
//  Created by Stephanie Bowles on 6/19/20.
//  Copyright © 2020 Stephanie Bowles. All rights reserved.
//

import UIKit

class SquareCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var squareView: UIView!

    override func layoutSubviews() {
        super.layoutSubviews()
        squareView.layer.cornerRadius = squareView.bounds.size.width/2
    }
    
    func configureWithState(_ isAlive: Bool) {
        self.squareView.backgroundColor = isAlive ?  UIColor.mintColor : UIColor.purpleColor
    }
}

//
//  ImageUICollectionViewCell.swift
//  CHTWaterfallSwift
//
//  Created by Sophie Fader on 3/21/15.
//  Copyright (c) 2015 Sophie Fader. All rights reserved.
//

import UIKit

class ImageUICollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
	@IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		self.image.contentMode = UIViewContentMode.ScaleAspectFill
    }

}

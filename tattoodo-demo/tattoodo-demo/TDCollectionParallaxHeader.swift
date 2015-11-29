//
//  TDCollectionParallaxHeader.swift
//  SwiftDemo
//

import UIKit

class TDCollectionParallaxHeader: UICollectionReusableView {


	var imageView : UIImageView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGrayColor()

        self.clipsToBounds = true

        let bounds = CGRectMake(0, 0, CGRectGetMaxX(frame), CGRectGetMaxY(frame))

        let imageView = UIImageView(frame: bounds)
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.image = UIImage(named: "success-baby")
        self.imageView = imageView
        self.addSubview(imageView)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = self.bounds
    }
    
}

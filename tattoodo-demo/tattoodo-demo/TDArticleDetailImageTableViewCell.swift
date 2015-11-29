//
//  TDArticleDetailImageTableViewCell.swift
//  tattoodo-demo
//
//  Created by Tudor Dragan on 29/11/15.
//  Copyright © 2015 [tudor dev]. All rights reserved.
//

import UIKit

class TDArticleDetailImageTableViewCell: UITableViewCell {

	@IBOutlet weak var imageViewArticleImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	/*
	- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view
	{
	CGRect rectInSuperview = [tableView convertRect:self.frame toView:view];
	
	float distanceFromCenter = CGRectGetHeight(view.frame)/2 - CGRectGetMinY(rectInSuperview);
	float difference = CGRectGetHeight(self.parallaxImage.frame) - CGRectGetHeight(self.frame);
	float move = (distanceFromCenter / CGRectGetHeight(view.frame)) * difference;
	
	CGRect imageRect = self.parallaxImage.frame;
	imageRect.origin.y = -(difference/2)+move;
	self.parallaxImage.frame = imageRect;
	}
	*/
	
	func cellOnTableViewDidScrollOnView (tableView: UITableView, view: UIView){
		let rectInSuperview = tableView.convertRect(self.frame, toView: view)
		
		let distanceFromCenter = CGRectGetHeight(view.frame)/2 - CGRectGetMinY(rectInSuperview);
		let difference = CGRectGetHeight(self.imageViewArticleImage.frame) - CGRectGetHeight(self.frame);
		let move = (distanceFromCenter / CGRectGetHeight(view.frame)) * difference;

		var imageRect = self.imageViewArticleImage.frame;
		imageRect.origin.y = -(difference/2)+move;
		self.imageViewArticleImage.frame = imageRect;
		
	}

}

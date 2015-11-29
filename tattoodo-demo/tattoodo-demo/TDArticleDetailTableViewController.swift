//
//  TDArticleDetailTableViewController.swift
//  tattoodo-demo
//
//  Created by Tudor Dragan on 28/11/15.
//  Copyright © 2015 [tudor dev]. All rights reserved.
//

import UIKit
import RMPZoomTransitionAnimator

class TDArticleDetailTableViewController: UIViewController {

	
	@IBOutlet weak var imageViewFeaturedImage: UIImageView!
	var articleData : NSMutableDictionary?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.imageViewFeaturedImage.contentMode = UIViewContentMode.ScaleAspectFill
		self.imageViewFeaturedImage.image = self.articleData!["image_file"] as? UIImage
		self.title = self.articleData!["title"] as? String
		
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
	
	}

}

//
//  TDArticleDetailTableViewController.swift
//  tattoodo-demo
//
//  Created by Tudor Dragan on 28/11/15.
//  Copyright © 2015 [tudor dev]. All rights reserved.
//

import UIKit
import RMPZoomTransitionAnimator

class TDArticleDetailTableViewController: UIViewController,RMPZoomTransitionAnimating,RMPZoomTransitionDelegate {
	
	var destinationImageView: UIImageView?

	var featuredImage : UIImage?
	
	@IBOutlet weak var imageViewFeaturedImage: UIImageView!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewWillAppear(animated: Bool) {
		self.imageViewFeaturedImage.image = featuredImage
	}

	/*
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/
	
	// MARK: - Zoom Transition Animator Delegate
	func transitionSourceImageView() -> UIImageView! {
		let imageView: UIImageView = UIImageView(image: self.imageViewFeaturedImage.image)
		imageView.contentMode = self.imageViewFeaturedImage.contentMode
		imageView.clipsToBounds = true
		imageView.userInteractionEnabled = false
		imageView.frame = self.imageViewFeaturedImage.frame
		return imageView
	}

	func transitionSourceBackgroundColor() -> UIColor! {
		return self.view.backgroundColor
	}
	
	func transitionDestinationImageViewFrame() -> CGRect {
		return self.imageViewFeaturedImage!.frame
	}
	
	func zoomTransitionAnimator(animator: RMPZoomTransitionAnimator!, didCompleteTransition didComplete: Bool, animatingSourceImageView imageView: UIImageView!) {
		self.imageViewFeaturedImage.image = imageView.image
	}
	
}

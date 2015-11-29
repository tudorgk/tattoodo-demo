//
//  TDArticleDetailTableViewController.swift
//  tattoodo-demo
//
//  Created by Tudor Dragan on 28/11/15.
//  Copyright © 2015 [tudor dev]. All rights reserved.
//

import UIKit
import CSStickyHeaderFlowLayout
import Kingfisher
class TDArticleDetailCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

	
	@IBOutlet weak var imageViewFeaturedImage: UIImageView!
	var articleData : NSMutableDictionary?
	
	private var layout : CSStickyHeaderFlowLayout? {
		return self.collectionView?.collectionViewLayout as? CSStickyHeaderFlowLayout
	}

	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.collectionView?.delegate = self
		self.collectionView?.dataSource = self
		self.title = self.articleData!["title"] as? String
		
		// Setup Header
		self.collectionView?.registerClass(TDCollectionParallaxHeader.self, forSupplementaryViewOfKind: CSStickyHeaderParallaxHeader, withReuseIdentifier: "parallaxHeader")
		self.layout?.parallaxHeaderReferenceSize = CGSizeMake(self.view.frame.size.width, 200)

		
		
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
	
	}
	
	//MARK: - CollectionView Delegate Methods
	
	
	//** Number of Cells in the CollectionView */
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return ((self.articleData!["content"] as! NSMutableArray)).count
	}
	
	
	//** Create a basic CollectionView Cell */
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		
		
		if(((((self.articleData!["content"] as! NSMutableArray)).objectAtIndex(indexPath.row) as! NSDictionary).objectForKey("type") as! String) == "text"){
			// Create the cell and return the cell
				let textCell = collectionView.dequeueReusableCellWithReuseIdentifier("textCell", forIndexPath: indexPath) as! TDArticleDetailTextCollectionViewCell

				textCell.labelArticleText.text =
					((((self.articleData!["content"] as! NSMutableArray))
					.objectAtIndex(indexPath.row) as! NSDictionary)
					.objectForKey("content") as! String)
				return textCell
		}
		if(((((self.articleData!["content"] as! NSMutableArray)).objectAtIndex(indexPath.row) as! NSDictionary).objectForKey("type") as! String) == "image"){
			let imageCell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as! TDArticleDetailImageCollectionViewCell
			
			imageCell.imageViewArticlePhoto.kf_setImageWithURL(NSURL(string:
				((((self.articleData!["content"] as! NSMutableArray))
					.objectAtIndex(indexPath.row) as! NSDictionary)
					.objectForKey("image_url") as! String))!)

			return imageCell
		}
		
		let textCell = collectionView.dequeueReusableCellWithReuseIdentifier("textCell", forIndexPath: indexPath) as! TDArticleDetailTextCollectionViewCell
		return textCell
	}
	
	
	override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
		
		if kind == CSStickyHeaderParallaxHeader {
			let view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "parallaxHeader", forIndexPath: indexPath) as! TDCollectionParallaxHeader
			view.imageView?.image = self.articleData!["image_file"] as? UIImage
			view.imageView!.frame = CGRectMake(0, 0, ((self.articleData!["image_file"] as? UIImage)?.size.width)!,( (self.articleData!["image_file"] as? UIImage)?.size.height)!)
			

			return view
		} 
		
		return UICollectionReusableView()
		
	}

	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		
		let articleElement :NSDictionary = (((self.articleData!["content"] as! NSMutableArray)).objectAtIndex(indexPath.row) as! NSDictionary)
		
		if ((articleElement["type"] as! String) == "image"){
			return CGSizeMake(320, 200)
		}else{
			return CGSizeMake(320, 100)
		}
		
	}

}




//
//  TDAppDataViewController.swift
//  tattoodo-demo
//
//  Created by Tudor Dragan on 28/11/15.
//  Copyright © 2015 [tudor dev]. All rights reserved.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import AMScrollingNavbar
import Kingfisher

class TDAppDataCollectionViewController: UICollectionViewController, CHTCollectionViewDelegateWaterfallLayout ,UINavigationControllerDelegate {
	
	let dataSource : TDAppDataSource = TDAppDataSource()
	let placeHolderImage : UIImage = UIImage(named: "image1")!
	let uiRefresh = UIRefreshControl()
	var selectedIndexParth : NSIndexPath?
	var destinationImageView : UIImageView?
	
	//MARK: - View Controller Lifecycle
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		self.title = "Articles"
		
		// Attach datasource and delegate
		self.collectionView!.dataSource  = self
		self.collectionView!.delegate = self
		self.clearsSelectionOnViewWillAppear = true	
		//Layout setup
		setupCollectionView()
		
		//Register nibs
		registerNibs()
		
		addRefreshControl()
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadAppDataCollectionView:", name: "ArticlesArrayChanged", object: nil)
	}

	
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		if let navigationController = self.navigationController as? ScrollingNavigationController {
			navigationController.followScrollView(self.collectionView!, delay: 0)
		}
	}
	
	override func viewDidDisappear(animated: Bool) {
		super.viewDidDisappear(animated)
		
		
		if let navigationController = self.navigationController as? ScrollingNavigationController {
			navigationController.stopFollowingScrollView()
		}
	}

	
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func addRefreshControl(){
		self.uiRefresh.addTarget(self, action: "reloadButtonPressed:", forControlEvents: UIControlEvents.ValueChanged)
		self.collectionView!.addSubview(self.uiRefresh)
	}
	
	@IBAction func reloadButtonPressed(sender: AnyObject) {
		let dateToSearch:NSDate = NSDate.init(timeIntervalSince1970: 1446465616)
		dataSource.retrieveArticlesAfterDate(dateToSearch)
		self.uiRefresh.endRefreshing()
	}
	
	func reloadAppDataCollectionView(sender: AnyObject?){
		debugPrint("reloadCollectionView")
		self.collectionView?.reloadData()
	}
	
	//MARK: - CollectionView UI Setup
	func setupCollectionView(){
		
		// Create a waterfall layout
		let layout = CHTCollectionViewWaterfallLayout()
		
		// Change individual layout attributes for the spacing between cells
		layout.minimumColumnSpacing = 10.0
		layout.minimumInteritemSpacing = 10.0
		layout.columnCount = 2;
		layout.sectionInset = UIEdgeInsetsMake(10,10, 10, 10)
		
		// Collection view attributes
		self.collectionView!.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
		self.collectionView!.alwaysBounceVertical = true
		
		// Add the waterfall layout to your collection view
		self.collectionView!.collectionViewLayout = layout
	}
	
	// Register CollectionView Nibs
	func registerNibs(){
		
		// attach the UI nib file for the ImageUICollectionViewCell to the collectionview
		let viewNib = UINib(nibName: "ImageUICollectionViewCell", bundle: nil)
		self.collectionView!.registerNib(viewNib, forCellWithReuseIdentifier: "cell")
	}
	
	
	
	
	//MARK: - CollectionView Delegate Methods
	
	
	//** Number of Cells in the CollectionView */
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		//		return dataSource.articlesArray.count
		return dataSource.articlesArray.count
	}
	
	
	//** Create a basic CollectionView Cell */
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		
		// Create the cell and return the cell
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ImageUICollectionViewCell
		
		// Add image to cell
		cell.image.image = self.dataSource.articlesArray.objectAtIndex(indexPath.row).objectForKey("image_file") as? UIImage
		cell.labelTitle.text = self.dataSource.articlesArray.objectAtIndex(indexPath.row).objectForKey("title") as? String
		return cell
	}
	
	
	//MARK: - CollectionView Waterfall Layout Delegate Methods (Required)
	
	//** Size for the cells in the Waterfall Layout */
	func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
		
		// create a cell size from the image size, and return the size
		//		let imageSize = model.images[indexPath.row].size
		//		let imageSize = 10;
		
		return (self.dataSource.articlesArray.objectAtIndex(indexPath.row).objectForKey("image_file") as! UIImage).size
	}
	
	override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		// Create the cell and return the cell
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ImageUICollectionViewCell
		self.selectedIndexParth = indexPath
		
		let articleDetailVC : TDArticleDetailTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("articleDetailVC") as! TDArticleDetailTableViewController
		articleDetailVC.articleData = NSMutableDictionary(dictionary: (self.dataSource.articlesArray.objectAtIndex(indexPath.row) as? NSMutableDictionary)!)
		
		cell.selected = false
		
		self.navigationController?.pushViewController(articleDetailVC, animated: true)
	}
	
	
	
}


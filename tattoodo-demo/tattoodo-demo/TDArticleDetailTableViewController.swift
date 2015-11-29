//
//  TDArticleDetailTableViewController.swift
//  tattoodo-demo
//
//  Created by Tudor Dragan on 29/11/15.
//  Copyright © 2015 [tudor dev]. All rights reserved.
//

import UIKit
import Kingfisher
class TDArticleDetailTableViewController: UITableViewController {

	@IBOutlet weak var imageViewFeaturedImage: UIImageView!
	var articleData : NSMutableDictionary?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.rowHeight = UITableViewAutomaticDimension
		self.tableView.estimatedRowHeight = 160.0
		self.tableView.scrollEnabled = true
		self.title = self.articleData!["title"] as? String
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return ((self.articleData!["content"] as! NSMutableArray)).count
	}

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let articleElement :NSDictionary = (((self.articleData!["content"] as! NSMutableArray)).objectAtIndex(indexPath.row) as! NSDictionary)
 
		if(articleElement["type"] as? String == "text"){
		
			let cell :TDArticleDetailTextTableViewCell = (tableView.dequeueReusableCellWithIdentifier("textCell", forIndexPath: indexPath) as? TDArticleDetailTextTableViewCell)!

			cell.labelArticleText!.text = articleElement["content"] as? String

        return cell
			
		}else{
			let cell :TDArticleDetailImageTableViewCell = (tableView.dequeueReusableCellWithIdentifier("imageCell", forIndexPath: indexPath) as? TDArticleDetailImageTableViewCell)!
			
			cell.imageViewArticleImage.kf_setImageWithURL(NSURL(string:
				((((self.articleData!["content"] as! NSMutableArray))
					.objectAtIndex(indexPath.row) as! NSDictionary)
					.objectForKey("image_url") as! String))!)

			return cell
		}
	
	}
	
	override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 160;
	}



}

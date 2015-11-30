//
//  TDArticleDetailTableViewController.swift
//  tattoodo-demo
//
//  Created by Tudor Dragan on 29/11/15.
//  Copyright © 2015 [tudor dev]. All rights reserved.
//

import UIKit
import Kingfisher
import XCDYouTubeKit
class TDArticleDetailTableViewController: UITableViewController {

	@IBOutlet weak var imageViewFeaturedImage: UIImageView!
	var articleData : NSMutableDictionary?
	let placeHolderImage : UIImage = UIImage(named: "placeholder1")!
	
	var cachedCells : NSMutableDictionary = NSMutableDictionary()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.rowHeight = 200
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
 
		let cachedCell : UITableViewCell? = self.cachedCells.objectForKey(indexPath) as? UITableViewCell
		
		if (cachedCell != nil){
			return cachedCell!
		}else{
		
		if(articleElement["type"] as? String == "text"){
		

			
			let cell :TDArticleDetailTextTableViewCell = (tableView.dequeueReusableCellWithIdentifier("textCell", forIndexPath: indexPath) as? TDArticleDetailTextTableViewCell)!

			cell.labelArticleText!.text = articleElement["content"] as? String

			cell.layoutIfNeeded()
			
			cachedCells[indexPath] = cell;
			
        return cell
			
		}else if(articleElement["type"] as? String == "image"){
			let cell :TDArticleDetailImageTableViewCell = (tableView.dequeueReusableCellWithIdentifier("imageCell", forIndexPath: indexPath) as? TDArticleDetailImageTableViewCell)!
			
			if (articleElement["image_file"] == nil){
				cell.imageViewArticleImage.kf_setImageWithURL(NSURL(string:
					((((self.articleData!["content"] as! NSMutableArray))
						.objectAtIndex(indexPath.row) as! NSDictionary)
						.objectForKey("image_url") as! String))!,placeholderImage: self.placeHolderImage)
			}
			
			cell.layoutIfNeeded()
			
			cachedCells[indexPath] = cell;

			return cell
		}else {
			let cell :TDArticleDetailYoutubeTableViewCell = (tableView.dequeueReusableCellWithIdentifier("videoCell", forIndexPath: indexPath) as? TDArticleDetailYoutubeTableViewCell)!
			let videoPlayerVC : XCDYouTubeVideoPlayerViewController = XCDYouTubeVideoPlayerViewController(videoIdentifier: (articleElement["video_url"] as? String)?.componentsSeparatedByString("v=")[1])
			videoPlayerVC.presentInView(cell.youtubePlayerView)
			videoPlayerVC.moviePlayer.play()
			
			cachedCells[indexPath] = cell;

			
			return cell;
		}
		}
	}
	
	override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 200;
	}
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		let articleElement :NSDictionary = (((self.articleData!["content"] as! NSMutableArray)).objectAtIndex(indexPath.row) as! NSDictionary)
		
		if(articleElement["type"] as? String == "text"){
			
			let cell = tableView.cellForRowAtIndexPath(indexPath)
			
			return 150
		}else{
			return 200
		}
	}

}

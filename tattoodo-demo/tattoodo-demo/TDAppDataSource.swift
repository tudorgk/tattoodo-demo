//
//  TDAppDataSource.swift
//  tattoodo-demo
//
//  Created by Tudor Dragan on 28/11/15.
//  Copyright © 2015 [tudor dev]. All rights reserved.
//

import UIKit

class TDAppDataSource: NSObject {
	var articlesArray = NSMutableArray()
	
	let urlString : String = "http://blog.tattoodo.com/wp-json/add_posts/v1/app_data"
	
	override init() {
		super.init()
		
	}
	
	convenience init(data: NSArray){
		self.init()
		articlesArray = NSMutableArray(array: data)
	}
	
	internal func retrieveArticlesAfterDate(date: NSDate?){

		var afterDate : NSDate?
		
		if (date == nil) {
			afterDate = NSDate()
		}else{
			afterDate = date
		}
	
		TDRequestManager.sharedInstance.getAppData(urlString, after: afterDate!, completion: {[weak self]completion, data in
			if(completion){
				self!.articlesArray = CFPropertyListCreateDeepCopy(nil, data as! NSArray, CFPropertyListMutabilityOptions.MutableContainersAndLeaves.rawValue) as! NSMutableArray
				var index: Int
				for index = 0; index < self!.articlesArray.count; ++index {
					(self!.articlesArray[index] as! NSMutableDictionary)["featured_image_url"] = self!.findFeaturedImageForArticle(self!.articlesArray[index]["content"] as! NSArray)
				}
				
				NSNotificationCenter.defaultCenter().postNotificationName("ArticlesArrayChanged", object: nil)
				
			}
		})

		
	}
	
	private func findFeaturedImageForArticle(contentArray: NSArray) ->  NSURL?{
		var foundFeatured :Bool = false
		var featuredImageURLString : NSURL? = nil
		
		while(foundFeatured == false){
			foundFeatured = true
			var index: Int
			for index = 0; index < contentArray.count; ++index {
				if (contentArray[index]["featured_image"] as! Bool == true){
					featuredImageURLString = NSURL(string: contentArray[index]["image_url"] as! String )
					break
				}
			}
		}
		return featuredImageURLString
	}
	
}

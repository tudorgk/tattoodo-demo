//
//  TDAppDataSource.swift
//  tattoodo-demo
//
//  Created by Tudor Dragan on 28/11/15.
//  Copyright © 2015 [tudor dev]. All rights reserved.
//

import UIKit

class TDAppDataSource: NSObject {
	var articlesArray = NSArray()
	
	let urlString : String = "http://blog.tattoodo.com/wp-json/add_posts/v1/app_data"
	
	override init() {
		super.init()
		
	}
	
	convenience init(data: NSArray){
		self.init()
		articlesArray = data
	}
	
	internal func retrieveArticlesAfterDate(date: NSDate?){

		if let afterDate:NSDate = date {
			TDRequestManager.sharedInstance.getAppData(urlString, after: afterDate, completion: {[weak self]completion, data in
				if(completion){
					self!.articlesArray = data as! NSArray
					debugPrint("articles = \(self!.articlesArray)")
					NSNotificationCenter.defaultCenter().postNotificationName("ArticlesArrayChanged", object: nil)
				}
			})
		}else{
			TDRequestManager.sharedInstance.getAppData(urlString, after: NSDate(), completion: {[weak self]completion, data in
				if(completion){
					self!.articlesArray = data as! NSArray;
					NSNotificationCenter.defaultCenter().postNotificationName("ArticlesArrayChanged", object: nil)
					debugPrint("articles = \(self!.articlesArray)")
				}
				})
		}
		
		
	}
	
}

//
//  TDAppDataSource.swift
//  tattoodo-demo
//
//  Created by Tudor Dragan on 28/11/15.
//  Copyright © 2015 [tudor dev]. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire

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
		UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
		TDRequestManager.sharedInstance.getAppData(urlString, after: afterDate!, completion: {[weak self]completion, data in
			if(completion){
				
				let auxArray : NSMutableArray = CFPropertyListCreateDeepCopy(nil, data as! NSArray, CFPropertyListMutabilityOptions.MutableContainersAndLeaves.rawValue) as! NSMutableArray
				var downloadCount : Int = auxArray.count
				var index: Int
				for index = 0; index < auxArray.count; index++ {
					(auxArray[index] as! NSMutableDictionary)["featured_image_url"] = self!.findFeaturedImageForArticle(auxArray[index]["content"] as! NSArray)
					
					let imageUrl : String = ((auxArray[index] as! NSMutableDictionary)["featured_image_url"] as! NSURL).absoluteString
					
					let imageDict : NSMutableDictionary = (auxArray[index] as! NSMutableDictionary)
					
					Alamofire.request(.GET, imageUrl, parameters: nil)
						.responseData { response in
							var downloadedImage : UIImage! = nil
							
							if let responseData : NSData = response.data! as NSData{
								downloadedImage = UIImage(data: responseData)
							}else{
								downloadedImage = UIImage(named: "image1")
							}
							
							downloadedImage = TDImageToolbox.resizeImage(downloadedImage, newSize: CGSizeMake(downloadedImage.size.width/4,downloadedImage.size.height/4))
							
							imageDict["image_file"] = downloadedImage
							downloadCount--
							if (downloadCount == 0 ){
								self!.articlesArray = auxArray
								UIApplication.sharedApplication().networkActivityIndicatorVisible = false;
								NSNotificationCenter.defaultCenter().postNotificationName("ArticlesArrayChanged", object: nil)
							}
							
					}
				}
				
				
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

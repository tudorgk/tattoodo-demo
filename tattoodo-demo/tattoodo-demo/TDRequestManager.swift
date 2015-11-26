//
//  TDRequestManager.swift
//  tattoodo-demo
//
//  Created by Tudor Dragan on 26/11/15.
//  Copyright © 2015 [tudor dev]. All rights reserved.
//

import UIKit
import Alamofire

class TDRequestManager: NSObject {
	
	static let sharedInstance = TDRequestManager()
	
	override init() {
		super.init()
	}
	
	
	internal func getAppData (url: String, after: NSDate, completion: ((Bool,AnyObject?) -> Void)?){
		
		let enUSPOSIXLocale = NSLocale(localeIdentifier: "en_US_POSIX")
		
		let rfc3339DateFormatter = NSDateFormatter()
		rfc3339DateFormatter.locale = enUSPOSIXLocale
		rfc3339DateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'"
		rfc3339DateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
		
		let afterString = rfc3339DateFormatter.stringFromDate(after)
		
		Alamofire.request(.GET, url, parameters: ["after": afterString])
			.validate()
			.responseJSON { response in
				switch response.result {
				case .Success(let data):
					
					let array : NSArray = data as! NSArray
					
					/*
					print("request \(response.request) \n")  // original URL request
					print("response \(response.response) \n") // URL response
					print("data \(response.data) \n")     // server data
					print("result \(response.result) \n")   // result of response serialization
						
					*/
					if(completion != nil){
						completion!(true,array)
					}
					
				case .Failure(let error):
					print(error)
					if(completion != nil){
						completion!(false,nil)
					}
				}
		}
	}
}

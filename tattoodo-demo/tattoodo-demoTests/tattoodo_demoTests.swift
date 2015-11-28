//
//  tattoodo_demoTests.swift
//  tattoodo-demoTests
//
//  Created by Tudor Dragan on 25/11/15.
//  Copyright © 2015 [tudor dev]. All rights reserved.
//

import XCTest
import Alamofire

@testable import tattoodo_demo

class tattoodo_demoTests: XCTestCase {
	
	let requestManager : TDRequestManager = TDRequestManager.sharedInstance
	
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAppDataRequest() {
		let expectation = expectationWithDescription("app data expectation")
		
		
		let dateToSearch:NSDate = NSDate.init(timeIntervalSince1970: 1446465616)
		
		requestManager.getAppData("http://blog.tattoodo.com/wp-json/add_posts/v1/app_data", after: dateToSearch,
			completion: {success,response in
				if(success){
					print("success: \(success) with \(response)")
					expectation.fulfill()
				}
				
		})
		waitForExpectationsWithTimeout(5.0, handler: nil)
	}
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}

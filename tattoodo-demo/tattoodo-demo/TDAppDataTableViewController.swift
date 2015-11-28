//
//  ViewController.swift
//  tattoodo-demo
//
//  Created by Tudor Dragan on 25/11/15.
//  Copyright © 2015 [tudor dev]. All rights reserved.
//

import UIKit
import DGActivityIndicatorView
import AMScrollingNavbar

class TDAppDataTableViewController: UITableViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		/*
		DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeDoubleBounce tintColor:[UIColor whiteColor] size:20.0f];
		activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, 50.0f, 50.0f);
		[self.view addSubview:activityIndicatorView];
		[activityIndicatorView startAnimating];
		*/
		let activityView : DGActivityIndicatorView = DGActivityIndicatorView.init(type: DGActivityIndicatorAnimationType.TriplePulse, tintColor: UIColor.darkGrayColor(), size: 20.0)
		activityView.frame = CGRectMake(0, 0, 50, 50);
		self.view.addSubview(activityView)
		activityView.startAnimating()
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		if let navigationController = self.navigationController as? ScrollingNavigationController {
			navigationController.followScrollView(self.tableView, delay: 50.0)
		}
	}
	
	override func viewDidDisappear(animated: Bool) {
		super.viewDidDisappear(animated)
		
		if let navigationController = self.navigationController as? ScrollingNavigationController {
			navigationController.stopFollowingScrollView()
		}
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 20
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")!
		
		cell.textLabel!.text = "Text"
		return cell
	}


}


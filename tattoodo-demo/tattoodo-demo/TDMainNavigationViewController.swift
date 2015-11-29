//
//  TDMainNavigationViewController.swift
//  tattoodo-demo
//
//  Created by Tudor Dragan on 27/11/15.
//  Copyright © 2015 [tudor dev]. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import RMPZoomTransitionAnimator
class TDMainNavigationViewController: ScrollingNavigationController, UINavigationControllerDelegate{

	let customNavigationController : TDCustomNavigationAnimationController = TDCustomNavigationAnimationController()
	let customInteractionController : TDCustomInteractionController = TDCustomInteractionController()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		if operation == .Push {
			customInteractionController.attachToViewController(toVC)
		}
		customNavigationController.reverse = operation == .Pop
		return customNavigationController
	}
	
}

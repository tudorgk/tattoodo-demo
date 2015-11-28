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

    override func viewDidLoad() {
        super.viewDidLoad()
		self.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	//MARK: UINavigationController Delegate
	
	func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		let animator: RMPZoomTransitionAnimator = RMPZoomTransitionAnimator.init()
		animator.goingForward = (operation == UINavigationControllerOperation.Push)
		
		let source : protocol<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>= fromVC as! protocol<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>
		let destination : protocol<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>= toVC as! protocol<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>
		
		animator.sourceTransition = source
		animator.destinationTransition = destination
		return animator
	}

	

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

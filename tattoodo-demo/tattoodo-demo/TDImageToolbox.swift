//
//  TDImageToolbox.swift
//  tattoodo-demo
//
//  Created by Tudor Dragan on 28/11/15.
//  Copyright © 2015 [tudor dev]. All rights reserved.
//

import UIKit

class TDImageToolbox: NSObject {
	internal static func resizeImage(image: UIImage, newSize: CGSize) -> (UIImage) {
		let newRect = CGRectIntegral(CGRectMake(0,0, newSize.width, newSize.height))
		let imageRef = image.CGImage
		
		UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
		let context = UIGraphicsGetCurrentContext()
		
		// Set the quality level to use when rescaling
		CGContextSetInterpolationQuality(context, CGInterpolationQuality.High)
		let flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height)
		
		CGContextConcatCTM(context, flipVertical)
		// Draw into the context; this scales the image
		CGContextDrawImage(context, newRect, imageRef)
		
		let newImageRef = CGBitmapContextCreateImage(context)! as CGImage
		let newImage = UIImage(CGImage: newImageRef)
		
		// Get the resized image from the context and a UIImage
		UIGraphicsEndImageContext()
		
		return newImage
	}
}

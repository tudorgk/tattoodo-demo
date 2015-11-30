//
//  TDYoutubeWebView.swift
//  tattoodo-demo
//
//  Created by Tudor Dragan on 30/11/15.
//  Copyright © 2015 [tudor dev]. All rights reserved.
//

import UIKit

class TDYoutubeWebView: UIWebView {

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	convenience init (url : String, frame:CGRect){
		self.init(frame: frame)
		let ytStringHTML : String = "<body style=\"margin:0\"><embed id=\"yt\" src=\"\(url)\" type=\"application/x-shockwave-flash\" width=\"\(frame.size.width)\" height=\"\(frame.size.height)\"></embed></body></html>"
		self.loadHTMLString(ytStringHTML, baseURL: nil)
	}
	
}

//
//  Constants.swift
//  Y0uTube
//
//  Created by Gary on 2017/3/13.
//  Copyright © 2017年 Gary. All rights reserved.
//

import Foundation

struct globalConstants {
    // request needed
    static let url = "https://www.googleapis.com/youtube/v3/videos"
    static let parameters = ["part" : "snippet", "chart" : "mostPopular", "key" : "AIzaSyAhFrjERFPedjVK6W3l0w-E2yB9cDUUCP4"]
    static let headers = ["X-Ios-Bundle-Identifier":"com.iOS.Y0uTube"]
}

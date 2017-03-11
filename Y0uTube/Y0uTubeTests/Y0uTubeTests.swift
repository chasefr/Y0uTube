//
//  Y0uTubeTests.swift
//  Y0uTubeTests
//
//  Created by Gary on 2017/2/19.
//  Copyright © 2017年 Gary. All rights reserved.
//

import XCTest
import Google
import Alamofire
@testable import Y0uTube

class Y0uTubeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGoogleAPI() {
        let headers = ["X-Ios-Bundle-Identifier":"com.iOS.Y0uTube"]
        Alamofire.request("https://www.googleapis.com/youtube/v3/videos?id=7lCDEYXw3mM&key=AIzaSyAhFrjERFPedjVK6W3l0w-E2yB9cDUUCP4&part=snippet,contentDetails,statistics,status", headers: headers).responseJSON{ response in
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
}

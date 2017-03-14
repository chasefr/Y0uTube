//
//  VideoItems.swift
//  Y0uTube
//
//  Created by Gary on 2017/3/13.
//  Copyright © 2017年 Gary. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class VideoItem {
    let thumbnail: UIImageView
    let title: String
    let duration: Int
    
    //MARK: init
    init(thumbnail: UIImageView, title: String, duration: Int) {
        self.thumbnail = thumbnail
        self.title = title
        self.duration = duration
    }
    
    class func getVideoItmes(completionHandler: @escaping ([[String : AnyObject]]) -> (Void), errorHandler: @escaping (String) -> (Void)) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        var items = [[String : AnyObject]]()
        Alamofire.request(globalConstants.url, parameters:globalConstants.parameters, headers:globalConstants.headers).responseJSON { response in
            if response.error != nil {
                //handle the request error
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                errorHandler(response.error.debugDescription)
//                print(response.error.debugDescription)
                return
            }
            let responseJSON = JSON(response.result.value!)
            responseJSON["items"].arrayValue.forEach({
                let imageurl = $0["snippet"]["thumbnails"]["default"]["url"].stringValue
                let image = UIImage.imageWithURL(url: imageurl)
                let imageView = UIImageView(image: image)
                let dic = ["thumbnails" : imageView, "title" : $0["snippet"]["title"].stringValue, "duration" : 4] as [String : Any]
                
                items.append(dic as [String : AnyObject])
            })
            completionHandler(items)
        }
    }
    
    //display
    class func cellAt(at: Int, fromList: Array<[String : AnyObject]>, completion: @escaping (VideoItem, Int) -> (Void)) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        DispatchQueue.global(qos:.userInteractive).async { 
            let item = fromList[at]
            let title = item["title"] as! String
            let thumbnail = item["thumbnails"] as! UIImageView
            let video = VideoItem.init(thumbnail: thumbnail, title: title, duration: 4)
            completion(video, at)
        }
    }
}

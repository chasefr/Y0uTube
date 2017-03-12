//
//  extensions.swift
//  Y0uTube
//
//  Created by Gary on 2017/3/12.
//  Copyright © 2017年 Gary. All rights reserved.
//

import UIKit

//封装下载图片的方法
extension UIImage {
    class func imageWithURL(url: String) -> UIImage {
        let imageUrl = URL.init(string: url)!
        var image = UIImage()
        do {
            let data = try Data(contentsOf: imageUrl)
            image = UIImage(data: data)!
        }catch _ {
            print("error finding image!")
        }
        return image;
    }
}

//色彩
extension UIColor {
    class func rbg(r: CGFloat, g: CGFloat, b:CGFloat) -> UIColor {
        let color = UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
        return color
    }
}

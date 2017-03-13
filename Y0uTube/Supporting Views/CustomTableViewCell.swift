//
//  CustomTableViewCell.swift
//  Y0uTube
//
//  Created by Gary on 2017/3/13.
//  Copyright © 2017年 Gary. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    var videoPic: UIImageView!
    var videoTitle = UILabel()
    var videoDuration: UILabel!
    
    func customization() {
        videoDuration.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        videoDuration.layer.borderWidth = 0.5
        videoDuration.layer.borderColor = UIColor.white.cgColor
        videoDuration.sizeToFit()
    }
    
    func setupCell(cellItems: VideoItem) {
        videoPic = cellItems.thumbnail
        videoPic.frame = CGRect(x: 0, y: 0, width: 120, height: 90)
        videoTitle.frame = CGRect(x: 130, y:0, width: self.frame.width - 130, height:90)
        videoTitle.text = cellItems.title
        videoTitle.numberOfLines = 0
        videoTitle.lineBreakMode = .byWordWrapping
        addSubview(videoPic)
        addSubview(videoTitle)
    }
}

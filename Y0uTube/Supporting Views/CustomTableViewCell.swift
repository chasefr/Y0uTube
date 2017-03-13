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
        self.videoPic = cellItems.thumbnail
        self.videoPic.frame = CGRect(x: 10, y: 0, width: 120, height: 90)
        self.videoTitle.frame = CGRect(x: 140, y:0, width: self.frame.width - 140, height:90)
        self.videoTitle.text = cellItems.title
        addSubview(videoPic)
        addSubview(videoTitle)
    }
}

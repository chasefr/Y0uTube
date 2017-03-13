//
//  ViewController.swift
//  Y0uTube
//
//  Created by Gary on 2017/2/19.
//  Copyright © 2017年 Gary. All rights reserved.
//

import UIKit
import GoogleSignIn
import Alamofire
import GTMOAuth2
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GIDSignInUIDelegate {


    var signInButton: GIDSignInButton!
    var signOutButton: UIBarButtonItem!
    var items: [Int : VideoItem]!
    var itemsList: [[String : AnyObject]]!
    
    @IBOutlet weak var subsriptionTableView: MySubsriptionTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set delegation
        
        subsriptionTableView.dataSource = self;
        subsriptionTableView.delegate = self;
        GIDSignIn.sharedInstance().uiDelegate = self;
        items = [Int : VideoItem]();
        itemsList = [[String : AnyObject]]()
        subsriptionTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "videoitems")
        subsriptionTableView.separatorStyle = .none
        refresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //init display things
        
        signOutButton = UIBarButtonItem(title: "SignOut", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ViewController.tapOut(_:)))
        //add GIDSignInButton to NavigationBar
        signInButton = GIDSignInButton(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 40, height: 40)))
        signInButton.style = GIDSignInButtonStyle.iconOnly
        signInButton.colorScheme = GIDSignInButtonColorScheme.light
        
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: signInButton)
        navigationItem.rightBarButtonItem = signOutButton
    }
    
    //refresh display contents
    func refresh() {
        VideoItem.getVideoItmes(completionHandler: {
            $0.forEach({dic in
                self.itemsList.append(dic)
            })
            DispatchQueue.main.async(execute: {
                self.subsriptionTableView.separatorStyle = .singleLine
                self.subsriptionTableView.reloadData()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
        })
    }
    
    //log out
    func tapOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
    }
    
    //MARK UITableViewDataSource Methods
    
    @available(iOS 2.0, *)
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90;
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "videoitems"
        
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomTableViewCell
        if let video = items[indexPath.item] {
            tableViewCell.setupCell(cellItems: video)
        }else {
            VideoItem.cellAt(at: indexPath.item, fromList: itemsList, completion: { (video, index) in
                self.items[index] = video;
                DispatchQueue.main.async(execute: { 
                    tableView.reloadData()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                })
            })
        }
        return tableViewCell
    }
    
}


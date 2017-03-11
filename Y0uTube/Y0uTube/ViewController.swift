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
    var items: Array<UIImage>!      //直观一些，后面会more generic，使用泛型
    
    @IBOutlet weak var subsriptionTableView: MySubsriptionTableView!
    
    var displayItems: Array<UIImage> {
        get {
            return items;
        }
        set {
            items = newValue
            subsriptionTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set delegation
        subsriptionTableView.dataSource = self;
        subsriptionTableView.delegate = self;
        GIDSignIn.sharedInstance().uiDelegate = self;
        items = [UIImage]();
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refresh();
    }
    
    //refresh display contents
    func refresh() {
        let parameters = ["part" : "snippet", "chart" : "mostPopular", "key" : "your api key"]
        let spinner = UIActivityIndicatorView(frame: CGRect(x : 0, y : 0, width : 40, height : 40));
        spinner.activityIndicatorViewStyle = .gray;
        spinner.center = view.center;
        spinner.startAnimating()
        spinner.backgroundColor = UIColor.white
        var array = [UIImage]()
        
        //bring to front
        view.addSubview(spinner)
        DispatchQueue.global(qos: .background).async {
            () -> Void in
            Alamofire.request("https://www.googleapis.com/youtube/v3/videos", parameters: parameters, headers:["X-Ios-Bundle-Identifier":"com.iOS.Y0uTube"]).responseJSON{ response in
                let responseJSON = JSON(response.result.value!)
                responseJSON["items"].arrayValue.forEach({
                    let imageUrl = $0["snippet"]["thumbnails"]["default"]["url"].stringValue
                    let urlStr = URL(string: imageUrl)
                    do {
                        let data = try Data(contentsOf: urlStr!)
                        let image = UIImage(data: data)
                        array.append(image!)
                    }catch {
                        print("fetch error!")
                    }
                })
                self.displayItems = array
            }
            DispatchQueue.main.async {
                () -> Void in
                spinner.removeFromSuperview()
            }
        }
    }
    
    //log out
    func tapOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
    }
    
    //MARK UITableViewDataSource Methods
    
    @available(iOS 2.0, *)
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90;
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "videoitems"
        
        var tableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if tableViewCell == nil {
            tableViewCell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        tableViewCell?.accessoryView = UIImageView(image: items![indexPath.item])
        return tableViewCell!
    }
    
}


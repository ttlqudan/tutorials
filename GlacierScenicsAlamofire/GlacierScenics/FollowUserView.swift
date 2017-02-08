//
//  FollowUserView.swift
//  GlacierScenics
//
//  Created by ant.man on 2017. 2. 8..
//  Copyright © 2017년 Todd Kramer. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import AlamofireObjectMapper

class FollowUserView : UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var headerText = String()
    
    var users : [User] = []
    
    override func viewDidLoad() {
        headLabel.text = headerText
        
        loadFollow()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func loadFollow() {
        // https://test.owltree.us/follower/U158564A0AF0US2/followlist?access_token=9cd741d9-10a2-4bc7-955c-3dc1b2ddf60b
        let url = "https://test.owltree.us/follower/U158564A0AF0US2/followlist"
        
        let parameters: Parameters = [
            "access_token": "9cd741d9-10a2-4bc7-955c-3dc1b2ddf60b"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseObject { (response: DataResponse<FollowData>) in
            
            guard response.result.isSuccess else {
                print("Error while request : \(response.result.error)")
                return
            }
            
            let followData = response.result.value
            guard ((followData?.data) != nil) else {
                return
            }
            
            for follow in (followData?.data)! {
                if (self.headerText == "follower" && follow.bitStatus! % 2 == 1) {
                    self.users.append(follow.userB!)
                } else if (self.headerText == "following" && follow.bitStatus! / 2 == 1) {
                    self.users.append(follow.userB!)
                }
            }
            
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VisitorCell", for: indexPath) as! VisitorCell
        cell.VisitorLable.text = users[indexPath.row].name;
        
        let url = URL(string: (users[indexPath.row].picture) ?? "http://www.apple.com/euro/ios/ios8/a/generic/images/og.png")
        cell.imageView?.af_setImage(withURL: url!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row is " , indexPath.row)
    }

}


extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

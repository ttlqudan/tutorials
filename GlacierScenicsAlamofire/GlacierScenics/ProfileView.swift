//
//  ProfileView.swift
//  GlacierScenics
//
//  Created by ant.man on 2017. 2. 8..
//  Copyright © 2017년 Todd Kramer. All rights reserved.
//

import UIKit
import Alamofire

class ProfileView: UIViewController {

    @IBOutlet weak var followingCntLabel: UILabel!
    @IBOutlet weak var followerCntLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadUser() {
        // https://test.owltree.us/users/U158564A0AF0US2?access_token=9cd741d9-10a2-4bc7-955c-3dc1b2ddf60b
        let url = "https://test.owltree.us/users/U158564A0AF0US2"
        
        let parameters: Parameters = [
            "access_token": "9cd741d9-10a2-4bc7-955c-3dc1b2ddf60b"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseObject { (response: DataResponse<User>) in
            
            guard response.result.isSuccess else {
                print("Error while request : \(response.result.error)")
                return
            }
            
            let user = response.result.value
            
            print ((user?.followingNum ?? 0))
            self.followingCntLabel.text = String(user?.followingNum ?? 0)
            self.followerCntLabel.text = String(user?.followerNum ?? 0)
            
            
            self.followerCntLabel.reloadInputViews()
            self.followingCntLabel.reloadInputViews()
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ( segue.identifier == "follower" || segue.identifier == "following" ) {
            let destViewController : FollowUserView = segue.destination as! FollowUserView
            destViewController.headerText = segue.identifier!
        }
    }
}

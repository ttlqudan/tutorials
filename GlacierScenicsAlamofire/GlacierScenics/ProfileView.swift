//
//  ProfileView.swift
//  GlacierScenics
//
//  Created by ant.man on 2017. 2. 8..
//  Copyright © 2017년 Todd Kramer. All rights reserved.
//

import UIKit

class ProfileView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ( segue.identifier == "follower" || segue.identifier == "following" ) {
            let destViewController : FollowUserView = segue.destination as! FollowUserView
            destViewController.headerText = segue.identifier!
        }
    }
}

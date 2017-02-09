//
//  TabBarController.swift
//  GlacierScenics
//
//  Created by ant.man on 2017. 2. 10..
//  Copyright © 2017년 Todd Kramer. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.tabBar.frame = CGRect(origin: CGPoint(x: 0,y :64), size: CGSize(width: 400, height: 50))
        
        let rect = self.tabBar.frame;
        self.tabBar.frame  = rect.insetBy(dx: 0, dy:  -view.frame.height + self.tabBar.frame.height + (self.navigationController?.navigationBar.frame.height)!)

    }
    
//    func removeTabbarItemsText() {
//        if let items = tabBar.items {
//            for item in items {
//                item.title = ""
//                
//                item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
//            }
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

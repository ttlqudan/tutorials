//
//  AppDelegate.swift
//  GlacierScenics
//
//  Created by Todd Kramer on 1/30/16.
//  Copyright © 2016 Todd Kramer. All rights reserved.
//

import UIKit

import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit

/* todo list
 1) 첫 페이지 로딩 시 저장된 부분 읽어서 없으면 로그인페이지로
 2) 그림 클릭해 대화 열기
 3) chatto 이용해서 대화
 */

// http://stackoverflow.com/questions/39899327/facebook-sdk-sign-in-with-swift-3-ios-10
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
//        return true
        let isUserLoggedIn = true
        
        // Override point for customization after application launch. (로그인 유무에 따라 초기 화면 바꾸기)
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        window?.rootViewController = storyboard.instantiateViewController(withIdentifier: (isUserLoggedIn ? "NavigationController":"LoginController"))
        window?.makeKeyAndVisible()
        
//        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
//        
//        let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "afterLoginSegue")
//        appDelegate.window?.rootViewController = initialViewController
//        appDelegate.window?.makeKeyAndVisible()
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }

}

        
     

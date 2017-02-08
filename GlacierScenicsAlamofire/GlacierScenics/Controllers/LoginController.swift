//
//  LoginController.swift
//  GlacierScenics
//
//  Created by ant.man on 2017. 1. 5..
//  Copyright © 2017년 Todd Kramer. All rights reserved.
//

import Foundation
import FBSDKLoginKit

class LoginController: UIViewController {
    
    var dict : [String : AnyObject]!
    
    @IBOutlet weak var emailLoginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func btnFBLoginPressed(_ sender: AnyObject) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                        fbLoginManager.logOut()
                    }
                }
            }
        }
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    print(result!)
                    /*
                     {
                     email = "ttlqudan@naver.com";
                     "first_name" = ByungMoo;
                     id = 1398682960176966;
                     "last_name" = Ahn;
                     name = "ByungMoo Ahn";
                     picture =     {
                     data =         {
                     "is_silhouette" = 0;
                     url = "https://scontent.xx.fbcdn.net/v/t1.0-1/p200x200/12647214_1098980683480530_8204966444156768974_n.jpg?oh=259577a8f33533eba9142924072552d0&oe=591CAE4E";
                     };
                     };
                     }
 */
                    print(self.dict)
                    /*
                     ["picture": {
                     data =     {
                     "is_silhouette" = 0;
                     url = "https://scontent.xx.fbcdn.net/v/t1.0-1/p200x200/12647214_1098980683480530_8204966444156768974_n.jpg?oh=259577a8f33533eba9142924072552d0&oe=591CAE4E";
                     };
                     }, "name": ByungMoo Ahn, "last_name": Ahn, "email": ttlqudan@naver.com, "id": 1398682960176966, "first_name": ByungMoo]
 */
                }
            })
        }
    }
}

//
//  LoginToken.swift
//  GlacierScenics
//
//  Created by ant.man on 2017. 1. 18..
//  Copyright © 2017년 Todd Kramer. All rights reserved.
//

import Foundation

protocol LoginTokenDelegate {
    func getToken() -> Optional<String>
    func setToken(token:String) -> Bool
}

class LoginToken {
    
    static let shared = LoginToken()
    let keyChain = Keychain()
    let USER_TOKEN_KEY = "UserTokenKey"
    var loginTokenDelegate :LoginTokenDelegate?
    
    var userToken : String = ""
    
    func getToken( ) -> String? {
        return String(data: Keychain.load(key: USER_TOKEN_KEY)!, encoding: .utf8)
    }
    
    func setToken(token:String) -> Bool {
        return Keychain.save(key: USER_TOKEN_KEY, data: token.data(using: .utf8)!)
    }
}

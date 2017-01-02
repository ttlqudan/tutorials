//
//  Photo.swift
//  GlacierScenics
//
//  Created by Todd Kramer on 1/30/16.
//  Copyright © 2016 Todd Kramer. All rights reserved.
//

struct Photo {

    let name: String
    let url: String
    let isChatOn : Bool
    let tagCount : Int
    let tagId : Int

    init(name : String, url : String, isChatOn : Bool, tagCount : Int, tagId : Int ){
        self.name = name
        self.url = url
        self.isChatOn = isChatOn
        self.tagCount = tagCount
        self.tagId = tagId
    }

}

//
//  RootClass.swift
//  GlacierScenics
//
//  Created by ant.man on 2016. 11. 24..
//  Copyright © 2016년 Todd Kramer. All rights reserved.
//

import Foundation

//
//	RootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class Tag : NSObject, NSCoding, Mappable{
    
    var isChatOn : Int?
    var media : Media?
    var name : String?
    var tagCount : Int?
    var tagId : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Tag()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        isChatOn <- map["isChatOn"]
        media <- map["media"]
        name <- map["name"]
        tagCount <- map["tagCount"]
        tagId <- map["tagId"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        isChatOn = aDecoder.decodeObject(forKey: "isChatOn") as? Int
        media = aDecoder.decodeObject(forKey: "media") as? Media
        name = aDecoder.decodeObject(forKey: "name") as? String
        tagCount = aDecoder.decodeObject(forKey: "tagCount") as? Int
        tagId = aDecoder.decodeObject(forKey: "tagId") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if isChatOn != nil{
            aCoder.encode(isChatOn, forKey: "isChatOn")
        }
        if media != nil{
            aCoder.encode(media, forKey: "media")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if tagCount != nil{
            aCoder.encode(tagCount, forKey: "tagCount")
        }
        if tagId != nil{
            aCoder.encode(tagId, forKey: "tagId")
        }
        
    }
    
}

//
//  Media.swift
//  GlacierScenics
//
//  Created by ant.man on 2016. 11. 24..
//  Copyright © 2016년 Todd Kramer. All rights reserved.
//

import Foundation

//
//	Media.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class Media : NSObject, NSCoding, Mappable{
    
    var thumbnailUrl : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Media()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        thumbnailUrl <- map["thumbnailUrl"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        thumbnailUrl = aDecoder.decodeObject(forKey: "thumbnailUrl") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if thumbnailUrl != nil{
            aCoder.encode(thumbnailUrl, forKey: "thumbnailUrl")
        }
        
    }
    
}

//
//	Visitor.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class Visitor : NSObject, NSCoding, Mappable{
    
    var hostUserId : String?
    var regDt : Int?
    var type : String?
    var user : User?
    var value : String?
    var visitorIdx : Int?
    var visitorUserId : String?
    
//    func getDate() -> NSDate {
//        return NSDate(timeIntervalSince1970: regDt)
//    }
    
    class func newInstance(map: Map) -> Mappable?{
        return Visitor()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        hostUserId <- map["hostUserId"]
        regDt <- map["regDt"]
        type <- map["type"]
        user <- map["user"]
        value <- map["value"]
        visitorIdx <- map["visitorIdx"]
        visitorUserId <- map["visitorUserId"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        hostUserId = aDecoder.decodeObject(forKey: "hostUserId") as? String
        regDt = aDecoder.decodeObject(forKey: "regDt") as? Int
        type = aDecoder.decodeObject(forKey: "type") as? String
        user = aDecoder.decodeObject(forKey: "user") as? User
        value = aDecoder.decodeObject(forKey: "value") as? String
        visitorIdx = aDecoder.decodeObject(forKey: "visitorIdx") as? Int
        visitorUserId = aDecoder.decodeObject(forKey: "visitorUserId") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if hostUserId != nil{
            aCoder.encode(hostUserId, forKey: "hostUserId")
        }
        if regDt != nil{
            aCoder.encode(regDt, forKey: "regDt")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if user != nil{
            aCoder.encode(user, forKey: "user")
        }
        if value != nil{
            aCoder.encode(value, forKey: "value")
        }
        if visitorIdx != nil{
            aCoder.encode(visitorIdx, forKey: "visitorIdx")
        }
        if visitorUserId != nil{
            aCoder.encode(visitorUserId, forKey: "visitorUserId")
        }
        
    }
    
}

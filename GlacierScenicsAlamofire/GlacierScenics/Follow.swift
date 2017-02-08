//
//	Follow.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class Follow : NSObject, NSCoding, Mappable{
    
    var bitStatus : Int?
    var followerIdx : Int?
    var regDt : Int?
    var userA : User?
    var userB : User?
    var userIdA : String?
    var userIdB : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Follow()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        bitStatus <- map["bitStatus"]
        followerIdx <- map["followerIdx"]
        regDt <- map["regDt"]
        userA <- map["userA"]
        userB <- map["userB"]
        userIdA <- map["userIdA"]
        userIdB <- map["userIdB"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        bitStatus = aDecoder.decodeObject(forKey: "bitStatus") as? Int
        followerIdx = aDecoder.decodeObject(forKey: "followerIdx") as? Int
        regDt = aDecoder.decodeObject(forKey: "regDt") as? Int
        userA = aDecoder.decodeObject(forKey: "userA") as? User
        userB = aDecoder.decodeObject(forKey: "userB") as? User
        userIdA = aDecoder.decodeObject(forKey: "userIdA") as? String
        userIdB = aDecoder.decodeObject(forKey: "userIdB") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if bitStatus != nil{
            aCoder.encode(bitStatus, forKey: "bitStatus")
        }
        if followerIdx != nil{
            aCoder.encode(followerIdx, forKey: "followerIdx")
        }
        if regDt != nil{
            aCoder.encode(regDt, forKey: "regDt")
        }
        if userA != nil{
            aCoder.encode(userA, forKey: "userA")
        }
        if userB != nil{
            aCoder.encode(userB, forKey: "userB")
        }
        if userIdA != nil{
            aCoder.encode(userIdA, forKey: "userIdA")
        }
        if userIdB != nil{
            aCoder.encode(userIdB, forKey: "userIdB")
        }
        
    }
    
}

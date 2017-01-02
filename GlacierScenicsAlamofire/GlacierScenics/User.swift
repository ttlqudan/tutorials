//
//	User.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class User : NSObject, NSCoding, Mappable{
    
    var bigPicture : String?
    var bio : String?
    var birthyear : AnyObject?
    var country : String?
    var firebaseYN : AnyObject?
    var gmtOffsetSec : Int?
    var instagramId : String?
    var languages : String?
    var name : String?
    var oauthAccessToken : AnyObject?
    var picture : String?
    var sex : AnyObject?
    var status : AnyObject?
    var userId : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return User()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        bigPicture <- map["bigPicture"]
        bio <- map["bio"]
        birthyear <- map["birthyear"]
        country <- map["country"]
        firebaseYN <- map["firebaseYN"]
        gmtOffsetSec <- map["gmtOffsetSec"]
        instagramId <- map["instagramId"]
        languages <- map["languages"]
        name <- map["name"]
        oauthAccessToken <- map["oauthAccessToken"]
        picture <- map["picture"]
        sex <- map["sex"]
        status <- map["status"]
        userId <- map["userId"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        bigPicture = aDecoder.decodeObject(forKey: "bigPicture") as? String
        bio = aDecoder.decodeObject(forKey: "bio") as? String
        birthyear = aDecoder.decodeObject(forKey: "birthyear") as? AnyObject
        country = aDecoder.decodeObject(forKey: "country") as? String
        firebaseYN = aDecoder.decodeObject(forKey: "firebaseYN") as? AnyObject
        gmtOffsetSec = aDecoder.decodeObject(forKey: "gmtOffsetSec") as? Int
        instagramId = aDecoder.decodeObject(forKey: "instagramId") as? String
        languages = aDecoder.decodeObject(forKey: "languages") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        oauthAccessToken = aDecoder.decodeObject(forKey: "oauthAccessToken") as? AnyObject
        picture = aDecoder.decodeObject(forKey: "picture") as? String
        sex = aDecoder.decodeObject(forKey: "sex") as? AnyObject
        status = aDecoder.decodeObject(forKey: "status") as? AnyObject
        userId = aDecoder.decodeObject(forKey: "userId") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if bigPicture != nil{
            aCoder.encode(bigPicture, forKey: "bigPicture")
        }
        if bio != nil{
            aCoder.encode(bio, forKey: "bio")
        }
        if birthyear != nil{
            aCoder.encode(birthyear, forKey: "birthyear")
        }
        if country != nil{
            aCoder.encode(country, forKey: "country")
        }
        if firebaseYN != nil{
            aCoder.encode(firebaseYN, forKey: "firebaseYN")
        }
        if gmtOffsetSec != nil{
            aCoder.encode(gmtOffsetSec, forKey: "gmtOffsetSec")
        }
        if instagramId != nil{
            aCoder.encode(instagramId, forKey: "instagramId")
        }
        if languages != nil{
            aCoder.encode(languages, forKey: "languages")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if oauthAccessToken != nil{
            aCoder.encode(oauthAccessToken, forKey: "oauthAccessToken")
        }
        if picture != nil{
            aCoder.encode(picture, forKey: "picture")
        }
        if sex != nil{
            aCoder.encode(sex, forKey: "sex")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "userId")
        }
        
    }
    
}

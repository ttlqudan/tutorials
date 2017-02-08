//
//	User.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class User : NSObject, NSCoding, Mappable{
    
    var bigPicture : String?
    var bio : String?
    var birthyear : Int?
    var country : String?
    var facebookId : String?
    var firebaseYN : AnyObject?
    var followerNum : Int?
    var followingNum : Int?
    var gmtOffsetSec : Int?
    var instagramId : String?
    var instagramName : String?
    var languages : String?
    var name : String?
    var oauthAccessToken : AnyObject?
    var owlName : String?
    var picture : String?
    var realName : AnyObject?
    var sex : String?
    var status : String?
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
        facebookId <- map["facebookId"]
        firebaseYN <- map["firebaseYN"]
        followerNum <- map["followerNum"]
        followingNum <- map["followingNum"]
        gmtOffsetSec <- map["gmtOffsetSec"]
        instagramId <- map["instagramId"]
        instagramName <- map["instagramName"]
        languages <- map["languages"]
        name <- map["name"]
        oauthAccessToken <- map["oauthAccessToken"]
        owlName <- map["owlName"]
        picture <- map["picture"]
        realName <- map["realName"]
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
        birthyear = aDecoder.decodeObject(forKey: "birthyear") as? Int
        country = aDecoder.decodeObject(forKey: "country") as? String
        facebookId = aDecoder.decodeObject(forKey: "facebookId") as? String
        firebaseYN = aDecoder.decodeObject(forKey: "firebaseYN") as? AnyObject
        followerNum = aDecoder.decodeObject(forKey: "followerNum") as? Int
        followingNum = aDecoder.decodeObject(forKey: "followingNum") as? Int
        gmtOffsetSec = aDecoder.decodeObject(forKey: "gmtOffsetSec") as? Int
        instagramId = aDecoder.decodeObject(forKey: "instagramId") as? String
        instagramName = aDecoder.decodeObject(forKey: "instagramName") as? String
        languages = aDecoder.decodeObject(forKey: "languages") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        oauthAccessToken = aDecoder.decodeObject(forKey: "oauthAccessToken") as? AnyObject
        owlName = aDecoder.decodeObject(forKey: "owlName") as? String
        picture = aDecoder.decodeObject(forKey: "picture") as? String
        realName = aDecoder.decodeObject(forKey: "realName") as? AnyObject
        sex = aDecoder.decodeObject(forKey: "sex") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
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
        if facebookId != nil{
            aCoder.encode(facebookId, forKey: "facebookId")
        }
        if firebaseYN != nil{
            aCoder.encode(firebaseYN, forKey: "firebaseYN")
        }
        if followerNum != nil{
            aCoder.encode(followerNum, forKey: "followerNum")
        }
        if followingNum != nil{
            aCoder.encode(followingNum, forKey: "followingNum")
        }
        if gmtOffsetSec != nil{
            aCoder.encode(gmtOffsetSec, forKey: "gmtOffsetSec")
        }
        if instagramId != nil{
            aCoder.encode(instagramId, forKey: "instagramId")
        }
        if instagramName != nil{
            aCoder.encode(instagramName, forKey: "instagramName")
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
        if owlName != nil{
            aCoder.encode(owlName, forKey: "owlName")
        }
        if picture != nil{
            aCoder.encode(picture, forKey: "picture")
        }
        if realName != nil{
            aCoder.encode(realName, forKey: "realName")
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

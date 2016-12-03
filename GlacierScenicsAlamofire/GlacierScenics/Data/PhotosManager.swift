//
//  PhotosManager.swift
//  GlacierScenics
//
//  Created by Todd Kramer on 1/30/16.
//  Copyright © 2016 Todd Kramer. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
// https://github.com/Ahmed-Ali/JSONExport
// https://github.com/SwiftyJSON/SwiftyJSON#work-with-alamofire
import SwiftyJSON
import AlamofireObjectMapper    // https://github.com/tristanhimmelman/AlamofireObjectMapper

// extension 으로 이미 정의된 타입에 새로운 속성이나 메서드를 추가
extension UInt64 {

    func megabytes() -> UInt64 {
        return self * 1024 * 1024
    }

}

class PhotosManager {

    static let shared = PhotosManager()

    private var dataPath: String {
        // 여기서 url 요청해서 list 받아오기
        
        let url = "https://test.owltree.us/summarytags/U15858C3C6CBAP6D0F61CA"
//       let url = "https://test.owltree.us/summarytags/U15858C3C6CBAP6D0F61CA?pageNo=0&mode=RECENT&field=name,tagid,tagCount,media{thumbnailUrl},isChatOn&access_token=9cd741d9-10a2-4bc7-955c-3dc1b2ddf60b"
        
        /*
        
//        let url = "https://test.owltree.us/summarytags/U15858C3C6CBAP6D0F61CA"
        let url = "http://api.androidhive.info/contacts/"

//        let serverTrustPolicies: [String: ServerTrustPolicy] = [
//            "test.owltree.us": .pinCertificates(
//                certificates: ServerTrustPolicy.certificates(),
//                validateCertificateChain: false,
//                validateHost: true
//                
////                certificates: ServerTrustPolicy.certificatesInBundle(),
////                validateCertificateChain: true,
////                validateHost: true
//            ),
//            "insecure.expired-apis.com": .disableEvaluation
//        ]
        
        let sessionManager = SessionManager(
//            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
//        let serverTrustPolicy = ServerTrustPolicy.pinCertificates(
//            certificates: ServerTrustPolicy.certificatesInBundle(),
//            validateCertificateChain: true,
//            validateHost: true
//        )
        
//        let serverTrustPolicies: [String: ServerTrustPolicy] = [
//            "test.owltree.us": .disableEvaluation,
//            ]
        
//        let manager = Alamofire.SessionManager(
//            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
//        )
        
        sessionManager.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                // let user = User(JSONString: JSONString)
                let json = JSON(value)
                print("JSON: \(json)")
//                let roolClass = RootClass(value)
//                print("JSON: \(roolClass)")
            case .failure(let error):
                print("error : \(error)")
            }
        }*/
        
        
        let parameters: Parameters = [
            "pageNo": "0",
            "mode": "RECENT",
            "field": "name,tagid,tagCount,media{thumbnailUrl},isChatOn",
            "access_token": "9cd741d9-10a2-4bc7-955c-3dc1b2ddf60b"
        ]
        
        // https://github.com/tristanhimmelman/AlamofireObjectMapper
        Alamofire.request(url, method: .get, parameters: parameters).responseArray { (response: DataResponse<[RootClass]>) in
            
            
            let tagArray = response.result.value
            
            if let tagArray = tagArray {
                for tag in tagArray {
                    print(tag.name!)
                    print(tag.media?.thumbnailUrl!)
                }
            }
            
//            let tagResponseArray = response.result.value
//            print(weatherResponse?.name)
////            let threeDayForecast = weatherResponse?.media?.thumbnailUrl
//            print(weatherResponse?.media?.thumbnailUrl)
            
        }
        
        
    //pageNo=0&mode=RECENT&field=name,tagid,tagCount,media{thumbnailUrl},isChatOn&access_token=9cd741d9-10a2-4bc7-955c-3dc1b2ddf60b"
//        Alamofire.request("https://httpbin.org/get").responseJSON { response in
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
//            print(response.request)  // original URL request
//            print(response.response) // HTTP URL response
//            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
//                let root = RootClass(JSONString: JSON)
                
            }
            
        }
        
        return Bundle.main.path(forResource: "GlacierScenics", ofType: "plist")!
    }

    lazy var photos: [Photo] = {
        var photos = [Photo]()
        guard let data = NSArray(contentsOfFile: self.dataPath) as? [[String: Any]] else { return photos }
        for info in data {
            let photo = Photo(info: info)
            photos.append(photo)
        }
        return photos
    }()

    let imageCache = AutoPurgingImageCache(
        memoryCapacity: UInt64(100).megabytes(),
        preferredMemoryUsageAfterPurge: UInt64(60).megabytes()
    )

    //MARK: - Image Downloading

    func retrieveImage(for url: String, completion: @escaping (UIImage) -> Void) -> Request {
        return Alamofire.request(url, method: .get).responseImage { response in
            guard let image = response.result.value else { return }
            completion(image)
            self.cache(image, for: url)
        }
    }

    //MARK: = Image Caching

    func cache(_ image: Image, for url: String) {
        imageCache.add(image, withIdentifier: url)
    }

    func cachedImage(for url: String) -> Image? {
        return imageCache.image(withIdentifier: url)
    }

}

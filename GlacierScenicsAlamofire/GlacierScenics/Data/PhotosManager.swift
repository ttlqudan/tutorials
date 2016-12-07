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

protocol PhotoUrlDelegate {
    func finishedDownloading(photos:[Photo])
}

class PhotosManager {

    static let shared = PhotosManager()
    var delegate : PhotoUrlDelegate?
    
    private var dataPath: String {
        
        let url = "https://test.owltree.us/summarytags/U15858C3C6CBAP6D0F61CA"
        
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
        }
        return Bundle.main.path(forResource: "GlacierScenics", ofType: "plist")!
    }

    lazy var photos: [Photo] = {
        var photos = [Photo]()
        
//        guard let data = NSArray(contentsOfFile: self.dataPath) as? [[String: Any]] else { return photos }
//        for info in data {
//            let photo = Photo(info: info)
//            photos.append(photo)
//        }
        
        let url = "https://test.owltree.us/summarytags/U15858C3C6CBAP6D0F61CA"
        
        let parameters: Parameters = [
            "pageNo": "0",
            "mode": "RECENT",
            "field": "name,tagid,tagCount,media{thumbnailUrl},isChatOn",
            "access_token": "9cd741d9-10a2-4bc7-955c-3dc1b2ddf60b"
        ]
        
        // https://github.com/tristanhimmelman/AlamofireObjectMapper
        Alamofire.request(url, method: .get, parameters: parameters).responseArray { (response: DataResponse<[RootClass]>) in
            
            guard response.result.isSuccess else {
                print("Error while request : \(response.result.error)")
                return
            }
            
            let tagArray = response.result.value
            if let tagArray = tagArray {
                for tag in tagArray {
                    print("name: " + tag.name!)
//                    print("url: " +tag.media?.thumbnailUrl!)
                    let photo = Photo(name: tag.name!, url: tag.media!.thumbnailUrl!, isChatOn: Bool(tag.isChatOn!), tagCount: Int(tag.tagCount!), tagId: Int(tag.tagId!))
                    photos.append(photo)
                }
            }
            
            // view update
            shared.photos = photos
            self.delegate?.finishedDownloading(photos: photos)
        }
 
        
        print(" cnt : \(photos.count)")
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

extension Bool {
    init<T : Integer>(_ integer: T) {
        if integer == 0 {
            self.init(false)
        } else {
            self.init(true)
        }
    }
}

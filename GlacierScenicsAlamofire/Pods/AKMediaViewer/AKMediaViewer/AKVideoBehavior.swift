//
//  AKVideoBehavior.swift
//  AKMediaViewer
//
//  Created by Diogo Autilio on 3/22/16.
//  Copyright © 2016 AnyKey Entertainment. All rights reserved.
//

import Foundation
import UIKit

let kPlayIconTag: NSInteger = 50001

public class AKVideoBehavior : NSObject {
    
    public func addVideoIconToView(_ view: UIView, image: UIImage?) {
        
        var videoIcon: UIImage? = image
        var imageView: UIImageView?
        
        if((videoIcon == nil) || image!.size.equalTo(CGSize.zero)) {
            videoIcon = UIImage(named: "icon_big_play", in: Bundle.AKMediaFrameworkBundle(), compatibleWith: nil)
        }
        imageView = UIImageView.init(image: videoIcon)
        imageView!.tag = kPlayIconTag
        imageView!.contentMode = UIViewContentMode.center
        imageView!.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        imageView!.frame = view.bounds
        view.addSubview(imageView!)
    }
    
}

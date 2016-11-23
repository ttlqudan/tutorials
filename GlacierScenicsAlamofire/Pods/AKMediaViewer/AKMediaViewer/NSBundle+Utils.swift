//
//  NSBundle+Utils.swift
//  AKMediaViewer
//
//  Created by Diogo Autilio on 10/17/16.
//  Copyright © 2016 AnyKey Entertainment. All rights reserved.
//

import Foundation

extension Bundle {
    static func AKMediaFrameworkBundle() -> Bundle {
        let bundle = Bundle(for: AKMediaViewerManager.self)
        if let path = bundle.path(forResource: "AKMediaViewer", ofType: "bundle") {
            return Bundle(path: path)!
        } else {
            return bundle
        }
    }
}

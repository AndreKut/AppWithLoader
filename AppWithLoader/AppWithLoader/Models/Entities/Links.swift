//
//  Links.swift
//  AppWithLoader
//
//  Created by Andre on 1/1/19.
//  Copyright © 2019 Free. All rights reserved.
//

import Foundation

class Links {

    var urls: [LinksKey: URL]?
    
    init(dict: [String: Any]?) {
        dict?.forEach { key, value in
            guard let iconKey = LinksKey(rawValue: key),
                let stringUrl = value as? String,
                let url = URL(string: stringUrl) else {
                    return
            }
            urls?.updateValue(url, forKey: iconKey)
        }
    }
}


enum LinksKey: String {
    case selfLink = "self"
    case photos
    case html
    case download
    case likes
}

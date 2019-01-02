//
//  CurrentImage.swift
//  AppWithLoader
//
//  Created by Andre on 1/1/19.
//  Copyright © 2019 Free. All rights reserved.
//

import Foundation

class IconModel {
    var urls: [IconKey: URL]?

    init(dict: [String: Any]?) {
        dict?.forEach { key, value in
            guard let iconKey = IconKey(rawValue: key),
                let stringUrl = value as? String,
                let url = URL(string: stringUrl) else {
                    return
            }
            urls?.updateValue(url, forKey: iconKey)
        }
    }
}

enum IconKey: String {
    case raw
    case full
    case regular
    case small
    case thumb
}

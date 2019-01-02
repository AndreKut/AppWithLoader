//
//  Cacher.swift
//  DownloadingService
//
//  Created by Andre on 12/30/18.
//  Copyright © 2018 Free. All rights reserved.
//

import Foundation



private enum CacheStored {
    case temporary
    case atFolder(String)
}

internal class Cacher: NSCache<NSString, AnyObject> {
    init(maxCountLimit: Int) {
        super.init()
        countLimit = maxCountLimit
    }
}

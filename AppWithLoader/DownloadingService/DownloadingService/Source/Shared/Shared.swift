//
//  Shared.swift
//  DownloadingService
//
//  Created by Andre on 12/31/18.
//  Copyright © 2018 Free. All rights reserved.
//

import Foundation

public struct Shared {

    private static let instance = Cacher(maxCountLimit: 500)

    static let cachareInstance: NSCache<NSString, AnyObject> = {
        return instance
    }()
}

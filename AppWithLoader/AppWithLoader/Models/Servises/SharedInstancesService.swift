//
//  SharedInstancesService.swift
//  AppWithLoader
//
//  Created by Andre on 1/1/19.
//  Copyright © 2019 Free. All rights reserved.
//

import DownloadingService

struct SharedInstancesService {
    
    static private let storingServiceImpl = StoringServiceImpl()
    static private let loaderImpl: LoadingService = LoadingServicesImpl(storingService: storingServiceImpl)

    static let loader: LoadingService = {
        return loaderImpl
    }()
    
    static let storingService: StoringService = {
       return storingServiceImpl
    }()
}

//
//  BuilderLoaders.swift
//  DownloadingService
//
//  Created by Andre on 12/29/18.
//  Copyright © 2018 Free. All rights reserved.
//

internal class BuilderLoader {

    class func buidLoader(for type: LoadableItemType) -> LoaderProtocol {

        let loader = Loader(loadableItemType: type)

        switch type {
        case .data:
            return loader as DataLoaderProtocol
        case .json:
            return loader as JSONLoaderProtocol
        case .image:
            return loader as ImageLoaderProtocol
        }
    }
}

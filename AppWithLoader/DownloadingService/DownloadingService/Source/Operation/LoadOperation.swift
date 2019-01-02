//
//  ImageLoadOperation.swift
//  DownloadingService
//
//  Created by Andre on 12/29/18.
//  Copyright © 2018 Free. All rights reserved.
//

import Foundation

fileprivate let syncData = NSLock()

internal class LoadOperation: AsyncOperation {
    var result: ProcessedResult
    var error: Error?

    var preFinishedCompletion: VoidBlock?

    private let url: URL
    private let loadableItemType: LoadableItemType

    init(url: URL, loadableItemType: LoadableItemType) {
        self.url = url
        self.loadableItemType = loadableItemType
        
        result = .init(urlString: url.absoluteString)
    }

    override func main() {

        guard !isCancelled else { return }

        do {
            let resultData = try Data(contentsOf: url)

            guard !isCancelled else { return }

            syncData.lock()

            saveCacheIfNeeded(resultData)
            result = BuilderResult.buidResult(loadableItemType, with: resultData,
                                              urlString: url.absoluteString)
            syncData.unlock()

        } catch {
            result = BuilderResult.buidErrorResult(urlString: url.absoluteString,
                                                   error: error)
        }

        preFinishedCompletion?()
        state = .finished
    }

    private func saveCacheIfNeeded(_ data: Data) {
        if loadableItemType == .json, loadableItemType == .image {
            Shared.cachareInstance.setValue(data, forKey: url.absoluteString)
        }
    }
}

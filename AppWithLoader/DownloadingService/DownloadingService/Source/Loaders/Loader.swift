//
//  Loader.swift
//  DownloadingService
//
//  Created by Andre on 12/29/18.
//  Copyright © 2018 Free. All rights reserved.
//

import Foundation

public enum LoadableItemType: String {
    case data
    case json
    case image
}

internal typealias Operators = ImageLoaderProtocol & DataLoaderProtocol & JSONLoaderProtocol

public protocol LoaderProtocol: class {

    var loadResults: [ProcessedResult] { get }
    var isCompleted: Bool { get }
    var completion: (([ProcessedResult])->())? { get }

    func loadRequest(fromUrls urls: [URL], complition: @escaping (([ProcessedResult]) -> ()))
    func cancel()
}

public class Loader: Operators {

    private lazy var downloadOperation: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.name = operationQueueName
        operationQueue.maxConcurrentOperationCount = 10
        return operationQueue
    }()

    public var loadResults: [ProcessedResult] {
        return results
    }

    public var isCompleted: Bool {
        return downloadOperation.operationCount == 0
    }

    public var completion: (([ProcessedResult]) -> ())?

    private var results: [ProcessedResult]
    private let operationQueueName: String
    private let cacher = Shared.cachareInstance
    private let loadableItemType: LoadableItemType

    init(loadableItemType: LoadableItemType, completion: (([ProcessedResult])->())? = nil) {
        self.loadableItemType = loadableItemType
        self.completion = completion
        operationQueueName = "Download \(loadableItemType.rawValue.capitalized)s Queue"
        results = []
    }

    public func loadRequest(fromUrls urls: [URL], complition: @escaping (([ProcessedResult]) -> ())) {

        var results: [ProcessedResult] = []

        let notEncryptedUrls = urls.filter { url -> Bool in
            if let cachedData = cacher.object(forKey: url.absoluteString as NSString) as? Data {
                let result = BuilderResult.buidResult(loadableItemType, with: cachedData,
                                                      urlString: url.absoluteString)
                results.append(result)
                return false
            } else {
                return true
            }
        }

        let downloadOperations = notEncryptedUrls.map { url -> LoadOperation in
            let loadOperation = LoadOperation(url: url, loadableItemType: loadableItemType)
            loadOperation.preFinishedCompletion = {
                results.append(loadOperation.result)
            }
            return loadOperation
        }

        print("downloadOperations = \(downloadOperations.count)")

        let completionOperation = BlockOperation { [weak self] in
            print("Succeed option count \(results.count)")

            complition(results)
            self?.completion?(results)
            self?.results = results
        }

        downloadOperations.forEach { completionOperation.addDependency($0) }

        downloadOperation.addOperations(downloadOperations, waitUntilFinished: false)
        downloadOperation.addOperation(completionOperation)
    }

    public func cancel() {
        downloadOperation.cancelAllOperations()
    }
}

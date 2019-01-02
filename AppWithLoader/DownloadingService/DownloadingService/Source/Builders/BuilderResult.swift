//
//  BuilderResult.swift
//  DownloadingService
//
//  Created by Andre on 12/30/18.
//  Copyright © 2018 Free. All rights reserved.
//

import Foundation
import UIKit

internal class BuilderResult {
    class func buidResult(_ loadableItemType: LoadableItemType, with resultData: Data,
                          urlString: String) -> ProcessedResult {

        var processedResult = ProcessedResult(urlString: urlString)

        switch loadableItemType {
        case .data:
            processedResult.resultType = .data(resultData)

        case .json:
            if let resultJson = JSON.convertFromData(resultData) {
                processedResult.resultType = .json(resultJson)
                
            } else {
                processedResult.error = SetResultError.jsonError
            }

        case .image:
            if let resultImage = UIImage(data: resultData) {
                processedResult.resultType = .image(resultImage)
            } else {
                processedResult.error = SetResultError.imageError
            }
        }

        return processedResult
    }

    class func buidErrorResult(urlString: String, error: Error) -> ProcessedResult {
        return .init(urlString: urlString, error: error)
    }
}

//
//  ProcessedResult.swift
//  DownloadingService
//
//  Created by Andre on 12/30/18.
//  Copyright © 2018 Free. All rights reserved.
//

import UIKit

public enum ResultType {
    case image(UIImage)
    case json(JSON)
    case data(Data)
}

public struct ProcessedResult {

    let urlString: String
    var resultType: ResultType? = nil
    var error: Error? = nil

    init(urlString: String) {
        self.urlString = urlString
    }

    init(urlString: String, error: Error) {
        self.urlString = urlString
        self.error = error
    }
}

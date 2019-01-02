//
//  ResultError.swift
//  DownloadingService
//
//  Created by Andre on 12/30/18.
//  Copyright © 2018 Free. All rights reserved.
//

import Foundation

public enum SetResultError : Error {
    case dataError
    case jsonError
    case imageError
}

extension SetResultError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .dataError:
            return NSLocalizedString("Sorry, something went wrong with data", comment: "")
        case .jsonError:
            return NSLocalizedString("Sorry, something went wrong with json", comment: "")
        case .imageError:
            return NSLocalizedString("Sorry, something went wrong with image", comment: "")
        }
    }
}

//
//  Data.swift
//  DownloadingService
//
//  Created by Andre on 12/29/18.
//  Copyright © 2018 Free. All rights reserved.
//

import Foundation

public protocol DataCodable {
    associatedtype Result
    static func convertFromData(_ data: Data) -> Result?
}

public protocol DataDecodable {
    func convertToData() -> Data
}

extension Data: DataCodable, DataDecodable {
    public typealias Result = Data

    public static func convertFromData(_ data: Data) -> Result? {
        return data
    }

    public func convertToData() -> Data {
        return self
    }
}

//
//  JSON.swift
//  DownloadingService
//
//  Created by Andre on 12/29/18.
//  Copyright © 2018 Free. All rights reserved.
//

import Foundation

public enum JSON : DataCodable, DataDecodable {
    public typealias Result = JSON

    case dictionary([String:AnyObject])
    case array([AnyObject])

    public static func convertFromData(_ data: Data) -> Result? {
        do {
            let object: Any = try JSONSerialization.jsonObject(with: data,
                                                               options: JSONSerialization.ReadingOptions())
            switch (object) {
            case let dictionary as [String:AnyObject]:
                return JSON.dictionary(dictionary)
            case let array as [AnyObject]:
                return JSON.array(array)
            default:
                return nil
            }
        } catch {
            print("Invalid JSON data \(SetResultError.jsonError)")
            return nil
        }
    }

    public func convertToData() -> Data {
        switch (self) {
        case .dictionary(let dictionary):
            return try! JSONSerialization.data(withJSONObject: dictionary,
                                               options: JSONSerialization.WritingOptions())
        case .array(let array):
            return try! JSONSerialization.data(withJSONObject: array,
                                               options: JSONSerialization.WritingOptions())
        }
    }

    public var array : [AnyObject]! {
        switch (self) {
        case .dictionary(_):
            return nil
        case .array(let array):
            return array
        }
    }

    public var dictionary : [String:AnyObject]! {
        switch (self) {
        case .dictionary(let dictionary):
            return dictionary
        case .array(_):
            return nil
        }
    }
}

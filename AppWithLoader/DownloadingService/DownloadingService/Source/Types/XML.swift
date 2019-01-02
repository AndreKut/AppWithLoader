//
//  XML.swift
//  testgt
//
//  Created by Андрей Куц on 12/31/18.
//  Copyright © 2018 Free. All rights reserved.
//

import Foundation

extension XMLParser: DataCodable, DataDecodable {
    public typealias Result = XMLParser

    public static func convertFromData(_ data: Data) -> Result? {
        return XMLParser(data: data)
    }
    
    public func convertToData() -> Data {
        return Data()
    }
    
    
}

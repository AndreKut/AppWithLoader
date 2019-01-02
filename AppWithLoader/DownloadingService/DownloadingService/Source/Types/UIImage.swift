//
//  UIImage.swift
//  DownloadingService
//
//  Created by Andre on 12/29/18.
//  Copyright © 2018 Free. All rights reserved.
//

import UIKit

extension UIImage : DataCodable, DataDecodable {
    public typealias Result = UIImage

    public class func convertFromData(_ data: Data) -> Result? {
        return UIImage(data: data)
    }

    public func convertToData() -> Data {
        let hasAlpha = self.hasAlpha()
        let data = hasAlpha ? self.pngData() : self.jpegData(compressionQuality: 1.0)
        return  data ?? Data()
    }

    func hasAlpha() -> Bool {
        guard let alphaInfo = self.cgImage?.alphaInfo else {
            return false
        }
        switch alphaInfo {
        case .first, .last, .premultipliedFirst, .premultipliedLast, .alphaOnly:
            return true
        case .none, .noneSkipFirst, .noneSkipLast:
            return false
        }
    }
}

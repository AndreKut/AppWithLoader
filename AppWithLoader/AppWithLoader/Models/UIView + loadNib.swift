//
//  UIView + loadNib.swift
//  AppWithLoader
//
//  Created by Andre on 1/1/19.
//  Copyright © 2019 Free. All rights reserved.
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        if let xib = Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil),
            let result = xib.first as? T {
            return result
        }
        return T(frame: .zero)
    }
}

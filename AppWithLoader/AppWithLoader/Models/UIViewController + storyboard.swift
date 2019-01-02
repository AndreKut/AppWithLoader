//
//  UIViewController + storyboard.swift
//  AppWithLoader
//
//  Created by Andre on 1/1/19.
//  Copyright © 2019 Free. All rights reserved.
//

import UIKit

extension UIViewController {
    class func fromStoryboard<T: UIViewController>() -> T {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        if let controller = storyboard.instantiateInitialViewController() as? T {
            return controller
        }
        return T(nibName: nil, bundle: nil)
    }
}

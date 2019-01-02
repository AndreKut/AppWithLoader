//
//  ViewControllerFactory.swift
//  AppWithLoader
//
//  Created by Andre on 1/1/19.
//  Copyright © 2019 Free. All rights reserved.
//

import UIKit

class ViewControllerFactory {
    class func makePhotosViewController() -> UINavigationController {

        return UINavigationController()
    }
    
    class func makeLikeViewCintroller() -> UINavigationController {

        return UINavigationController()
    }
    
    class func makeCollectionViewController() -> UINavigationController {
        
        return UINavigationController()
    }

    class func makeItemTabBarViewController(with type: TabBarType) -> ItemTabBarViewController {
        let itemController = ItemTabBarViewController.fromStoryboard() as ItemTabBarViewController
        itemController.tabBarType = type
        return itemController
    }
}


//
//  TabBarController.swift
//  AppWithLoader
//
//  Created by Andre on 1/1/19.
//  Copyright © 2019 Free. All rights reserved.
//

import UIKit

protocol TabBarControllerDelegate: class {

    func updateViewController(with models: [UnsplashItemModel])
}

class TabBarController: UITabBarController {

    lazy var likesViewController: ItemTabBarViewController = {
        return ViewControllerFactory.makeItemTabBarViewController(with: .likes)
    }()

    lazy var photosViewController: ItemTabBarViewController = {
        let controller = ViewControllerFactory.makeItemTabBarViewController(with: .photos)
        self.tabBardelegate = controller
        return controller
    }()
    
    lazy var collectViewController: ItemTabBarViewController = {
        return ViewControllerFactory.makeItemTabBarViewController(with: .collect)
    }()

    private let loadService = SharedInstancesService.loader
    private let storingService = SharedInstancesService.storingService
    private var unsplashItemModels: [UnsplashItemModel] = []

    var tabBardelegate: TabBarControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "http://pastebin.com/raw/wgkJgazE")
        loadService.baseDataRequest(baseUrl: url!).continueWith {[weak self] _ in
            guard let self = self else { return }
            self.unsplashItemModels = self.storingService.savedItems
            self.tabBardelegate?.updateViewController(with: self.storingService.savedItems)
        }

        viewControllers = [makePhotosViewController(),
                           makeLikeViewController(),
                           makeCollectViewController()]
    }

    private func makeNavigationController(rootViewController: UIViewController,
                                          tabBarItemImage: UIImage,
                                          tabBarSelectedImage: UIImage,
                                          tabBarItemTitle: String) -> UINavigationController {

        let navigationController = BaseNavigationController(rootViewController: rootViewController)
        navigationController.view.backgroundColor = .lightGray
        navigationController.tabBarItem.image = tabBarItemImage
        navigationController.tabBarItem.selectedImage = tabBarSelectedImage
        navigationController.tabBarItem.title = tabBarItemTitle
        return navigationController
    }

    private func makePhotosViewController() -> UINavigationController {
        return makeNavigationController(rootViewController: photosViewController,
                                        tabBarItemImage: #imageLiteral(resourceName: "photo-camera"),
                                        tabBarSelectedImage: #imageLiteral(resourceName: "photo-camera"),
                                        tabBarItemTitle: "Photos")
    }

    private func makeLikeViewController() -> UINavigationController {
        return makeNavigationController(rootViewController: likesViewController,
                                        tabBarItemImage: #imageLiteral(resourceName: "like"),
                                        tabBarSelectedImage: #imageLiteral(resourceName: "like"),
                                        tabBarItemTitle: "Like")
    }

    private func makeCollectViewController() -> UINavigationController {
        return makeNavigationController(rootViewController: collectViewController,
                                        tabBarItemImage: #imageLiteral(resourceName: "magazine"),
                                        tabBarSelectedImage: #imageLiteral(resourceName: "magazine"),
                                        tabBarItemTitle: "Collect")
    }
}

extension TabBarController: TabBarControllerDelegate {
    func updateViewController(with models: [UnsplashItemModel]) {
        
    }
}

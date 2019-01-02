//
//  LikeViewController.swift
//  AppWithLoader
//
//  Created by Andre on 1/1/19.
//  Copyright © 2019 Free. All rights reserved.
//

import UIKit

enum TabBarType {
    case photos
    case likes
    case collect
}

class ItemTabBarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var tabBarType: TabBarType!
    private var collectionCellViewModels: [CollectionCellViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionCellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

extension ItemTabBarViewController: TabBarControllerDelegate {
    func updateViewController(with models: [UnsplashItemModel]) {
        models.forEach { unsplashModel in
            let model = CollectionCellViewModel(unsplashModel: unsplashModel)
            collectionCellViewModels.append(model)
        }
    }
}

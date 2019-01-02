//
//  CollectionCellViewModel.swift
//  AppWithLoader
//
//  Created by Andre on 1/1/19.
//  Copyright © 2019 Free. All rights reserved.
//

import UIKit

class CollectionCellViewModel {

    let id: String
    let userIconUrl: URL?
    let centralImageUrl: URL?
    let userName: String
    var likesCount: Int
    var isLikedByUser: Bool
    var centralImage: UIImage?
    var userIconImage: UIImage?

    var centralImageUpdate: (() -> ())?
    var userIconUpdate: (() -> ())?

    let imageLoader = SharedInstancesService.loader

    init(unsplashModel: UnsplashItemModel) {
        self.id = unsplashModel.id
        self.userIconUrl = unsplashModel.user?.profileImageUrls?["medium"] as? URL
        self.centralImageUrl = unsplashModel.imageUrls?.urls?[IconKey.full]
        self.likesCount = unsplashModel.likes ?? 0
        self.userName = unsplashModel.user?.name ?? ""
        self.isLikedByUser = unsplashModel.likedByUser ?? false
        loadImages()
    }

    private func loadImages() {
        if let userIconUrl = self.userIconUrl {
            imageLoader.downloadImage(urls: [userIconUrl]).continueOnSuccessWith { [weak self] images in
                if let userIconImage = images.first {
                    self?.userIconImage = userIconImage
                    self?.userIconUpdate?()
                }
            }
        }

        if let centralImageUrl = self.centralImageUrl {
            imageLoader.downloadImage(urls: [centralImageUrl]).continueOnSuccessWith { [weak self] images in
                if let centralImage = images.first {
                    self?.centralImage = centralImage
                    self?.centralImageUpdate?()
                }
            }
        }
    }
}

//
//  StoringService.swift
//  AppWithLoader
//
//  Created by Andre on 1/1/19.
//  Copyright © 2019 Free. All rights reserved.
//

protocol StoringService: class {
    var savedItems: [UnsplashItemModel] { get }

    func saveUnsplashItemModels(_ unsplashItemModels: [UnsplashItemModel])
    func removeUnsplashItemModel(_ unsplashItemModels: [UnsplashItemModel])
    func removeAllData()
    
    func fetchStoredItems() -> [UnsplashItemModel]
}

class StoringServiceImpl: StoringService {

    var savedItemsIds: [String] = []
    var savedItems: [UnsplashItemModel] = []

    func saveUnsplashItemModels(_ unsplashItemModels: [UnsplashItemModel]) {
        let itemsToSave = unsplashItemModels.filter { !savedItemsIds.contains($0.id) }
        let itemsIdsToSave = itemsToSave.map { $0.id }
        savedItems += itemsToSave
        savedItemsIds += itemsIdsToSave
    }

    func removeUnsplashItemModel(_ unsplashItemModels: [UnsplashItemModel]) {
        let itemsToRemove = unsplashItemModels.filter { savedItemsIds.contains($0.id) }
        let itemsIdsToRemove = itemsToRemove.map { $0.id }

        savedItems.enumerated().forEach { item in
            if itemsIdsToRemove.contains(item.element.id) {
                savedItems.remove(at: item.offset)
            }
        }
    }

    func fetchStoredItems() -> [UnsplashItemModel] {
        return savedItems
    }

    func removeAllData() {
        savedItemsIds.removeAll()
        savedItems.removeAll()
    }
}

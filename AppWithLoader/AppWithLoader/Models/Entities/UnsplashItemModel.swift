//
//  PastebinItemModel.swift
//  AppWithLoader
//
//  Created by Andre on 12/31/18.
//  Copyright © 2018 Free. All rights reserved.
//

import ObjectMapper

class UnsplashItemModel: Mappable {

    var id: String
    var creationDate: String
    var color: String?
    var width: Int?
    var height: Int?
    var likes: Int?
    var likedByUser: Bool?
    var currentUserCollections: [String: Any]?
    var imageUrls: IconModel?
    var links: Links?
    var user: UserModel?
    var categories: [CategoryModel]?

    private init(id: String, creationDate: String, color: String?,
                 width: Int, height: Int, likes: Int?, likedByUser: Bool?,
                 userCollections: [String: Any], imageUrls: IconModel?,
                 links: Links, user: UserModel, categories: [CategoryModel]) {

        self.id = id
        self.creationDate = creationDate
        self.color = color
        self.width = width
        self.height = height
        self.likes = likes
        self.likedByUser = likedByUser
        self.links = links
        self.user = user
        self.currentUserCollections = userCollections
        self.imageUrls = imageUrls
        self.categories = categories
    }

    required init?(map: Map) {
        do {
            id = try map.value(PropertyKey.id)
            creationDate = try map.value(PropertyKey.creationDate)
            color = try? map.value(PropertyKey.color)
            width = try? map.value(PropertyKey.width)
            height = try? map.value(PropertyKey.height)
            likes = try? map.value(PropertyKey.likes)
            likedByUser = try? map.value(PropertyKey.likedByUser)
            links = try? map.value(PropertyKey.links)
            imageUrls = IconModel(dict: try? map.value(PropertyKey.imageUrls))
            user = UserModel(JSON: try map.value(PropertyKey.user))
            categories = try? map.value(PropertyKey.categories)
        } catch {
            print("userCollections")
            return nil
        }
    }

    func mapping(map: Map) {
        id <- map[PropertyKey.id]
        creationDate <- map[PropertyKey.categories]
        color <- map[PropertyKey.color]
        width <- map[PropertyKey.width]
        height <- map[PropertyKey.height]
        likes <- map[PropertyKey.likes]
        likedByUser <- map[PropertyKey.likedByUser]
        links <- map[PropertyKey.links]
        user <- map[PropertyKey.user]
        imageUrls <- map[PropertyKey.imageUrls]
        categories <- map[PropertyKey.categories]
    }
}

extension UnsplashItemModel {
    fileprivate enum PropertyKey {
        static let id = "id"
        static let creationDate = "created_at"
        static let width = "width"
        static let height = "height"
        static let color = "color"
        static let likes = "likes"
        static let likedByUser = "liked_by_user"
        static let user = "user"
        static let userCollections = "current_user_collections"
        static let imageUrls = "urls"
        static let categories = "categories"
        static let links = "links"
    }
}

//
//  Categories.swift
//  AppWithLoader
//
//  Created by Andre on 12/31/18.
//  Copyright © 2018 Free. All rights reserved.
//

import ObjectMapper

class CategoryModel: Mappable {

    fileprivate enum PropertyKey {
        static let id = "id"
        static let title = "title"
        static let photoCount = "photo_count"
        static let links = "links"
    }

    var id: Int
    var title: String
    var photoCount: Int
    var links: Links?

    init(id: Int, title: String, photoCount: Int, links: Links) {
        self.id = id
        self.title = title
        self.photoCount = photoCount
        self.links = links
    }

    required init?(map: Map) {
        do {
            id = try map.value(PropertyKey.id)
            title = try map.value(PropertyKey.title)
            photoCount = try map.value(PropertyKey.photoCount)
            links = Links(dict: try map.value(PropertyKey.links))
        } catch {
            assertionFailure("Error with parsing \(CategoryModel.self) json: \(map.JSON)")
            return nil
        }
    }

    func mapping(map: Map) {
        id <- map[PropertyKey.id]
        title <- map[PropertyKey.title]
        photoCount <- map[PropertyKey.photoCount]
        links <- map[PropertyKey.links]
    }
}

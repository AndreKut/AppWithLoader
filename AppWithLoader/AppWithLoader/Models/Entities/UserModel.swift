//
//  User.swift
//  AppWithLoader
//
//  Created by Andre on 12/31/18.
//  Copyright © 2018 Free. All rights reserved.
//

import ObjectMapper

class UserModel: Mappable {

    var id: String
    var name: String
    var userName: String
    var profileImageUrls: [String: Any]?
    var links: Links?

    private init(id: String, userName: String, name: String) {
        self.id = id
        self.name = name
        self.userName = userName
    }

    required init?(map: Map) {
        do {
            id = try map.value(PropertyKey.id)
            name = try map.value(PropertyKey.name)
            userName = try map.value(PropertyKey.userName)
            profileImageUrls = try? map.value(PropertyKey.profileImageUrls)
            links = try? map.value(PropertyKey.links)
        } catch {
            assertionFailure("Error with parsing \(UserModel.self) json: \(map.JSON)")
            return nil
        }
    }

    func mapping(map: Map) {
        id <- map[PropertyKey.id]
        name <- map[PropertyKey.name]
        userName <- map[PropertyKey.userName]
        profileImageUrls <- map[PropertyKey.profileImageUrls]
        links <- map[PropertyKey.links]
    }
}

extension UserModel {
    fileprivate enum PropertyKey {
        static let id = "id"
        static let name = "name"
        static let userName = "username"
        static let profileImageUrls = "profile_image"
        static let links = "links"
    }
}

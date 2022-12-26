//
//  PostsModel.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 8/13/22.
//

import Foundation

import Foundation

struct PostUserProfileImage: Codable {
  let medium: String
}

struct PostUser: Codable {
  let profile_image: PostUserProfileImage
}

struct PostUrls: Codable {
  let regular: String
}

struct PostModel: Codable {
  let id: String
  let description: String?
  let user: PostUser
  let urls: PostUrls
}


struct PostsModel: Codable {
  let results: [PostModel]
}

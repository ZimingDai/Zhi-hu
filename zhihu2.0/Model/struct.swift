//
//  WebView.swift
//  zhihu2.0
//
//  Created by phoenix Dai on 2019/11/22.
//  Copyright © 2019 phoenix Dai. All rights reserved.
//

import Foundation
struct AllData: Codable {
    let date: String
    let stories, topStories: [Story]

    enum CodingKeys: String, CodingKey {
        case date, stories
        case topStories = "top_stories"
    }
}

// MARK: - Story
struct Story: Codable {
    let imageHue, title: String
    let url: String
    let hint, gaPrefix: String
    let images: [String]?
    let type, id: Int
    let image: String?

    enum CodingKeys: String, CodingKey {
        case imageHue = "image_hue"
        case title, url, hint
        case gaPrefix = "ga_prefix"
        case images, type, id, image
    }
}

struct LongComment: Codable {
    let comments: [Comment]
}

// MARK: - Comment
struct Comment: Codable {
    let author, content: String
    let avatar: String
    let time, id, likes: Int
}





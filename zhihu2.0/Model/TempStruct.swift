//
//  WebView.swift
//  zhihu2.0
//
//  Created by phoenix Dai on 2019/11/22.
//  Copyright © 2019 phoenix Dai. All rights reserved.
//

import Foundation

struct NextNews: Codable {
    let date: String
    let stories: [TStory]

    enum CodingKeys: String, CodingKey {
        case date, stories
    }
}


// MARK: - Story
struct TStory: Codable {
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




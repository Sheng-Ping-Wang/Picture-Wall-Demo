//
//  UnsplashModel.swift
//  PictureWallPractice
//
//  Created by Wang Sheng Ping on 2021/3/17.
//

import Foundation


struct ImageInfo: Codable {
    let urls: Urls
}

struct Urls: Codable {
    let regular: String
    var regularUrl: URL {
        return URL(string: regular)!
    }
}

//
//  News.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 08/05/2024.
//

import Foundation

struct NewsElement: Codable, Hashable  {
    let title, author: String
    let published: Date
    let link: String
}

typealias NewsList = [NewsElement]

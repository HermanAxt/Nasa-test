//
//  Item.swift
//  NASA-test
//
//  Created by Герман Акст on 13.12.2020.
//

import Foundation

struct Item: Codable {
    var links: [Link]?
    var href: String?
    var data: [SubItem]?
}

//
//  SubItem.swift
//  NASA-test
//
//  Created by Герман Акст on 13.12.2020.
//

import Foundation

struct SubItem: Codable {
    var keywords: [String]?
    var date_created: String?
    var title: String?
    var nasa_id: String?
    var media_type: String?
    var center: String?
    var photographer: String?
    var description: String?
  
  var swiftDate: Date? {
    let format = "yyyy-MM-dd:HH:mm:ss"
    let formatter = DateFormatter()
    formatter.dateFormat = format
    let string = (date_created ?? "").replacingOccurrences(of: ".000Z", with: "").replacingOccurrences(of: "T", with: ":")
    return formatter.date(from: string)
  }
}


//
//  NASAManager.swift
//  NASA-test
//
//  Created by Герман Акст on 13.12.2020.
//

import Foundation

class NASAManager {
    private init() {}
    static let shared = NASAManager()

    func fetchData(closure: (([Item]) -> Void)?) {
        RequestHandler(path: "search?q=\"").response { (items: [Item]?) in
            closure?(items ?? [])
        }
    }
}

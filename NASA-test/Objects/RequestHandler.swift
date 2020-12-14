//
//  RequestHandler.swift
//  NASA-test
//
//  Created by Герман Акст on 13.12.2020.
//

import Foundation

struct RequestHandler {
  private let domainUrl = "https://images-api.nasa.gov/"
  
  private let path: String
  
  private var fullPath: String {
    return domainUrl + path
  }
  
  init(path: String) {
    self.path = path
  }
  
  func response<T: Codable>(_ closure: ((T?) -> Void)?) {
    guard let url = URL(string: fullPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
      closure?(nil)
      return
    }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let data = data {
        let dictionary = (try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]) ?? [:]
        let decoder = JSONDecoder()
        let availableDictionary = ((dictionary["collection"] as? [String: Any]) ?? [:])["items"]
        
        do {
          let readableData = try JSONSerialization.data(withJSONObject: availableDictionary as Any, options: .prettyPrinted)
          let model = try decoder.decode(T.self, from: readableData)
          DispatchQueue.main.async {
            closure?(model)
          }
        } catch {
          print(error)
          DispatchQueue.main.async {
            closure?(nil)
          }
        }
      } else {
        DispatchQueue.main.async {
          closure?(nil)
        }
      }
    }.resume()
  }
}

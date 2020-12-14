//
//  ImageCacher.swift
//  NASA-test
//
//  Created by Герман Акст on 13.12.2020.
//

import UIKit

class ImageCacher {
  private let defaults = UserDefaults.standard
  
  func cache(_ image: UIImage, key: String) {
    guard let data = image.jpegData(compressionQuality: 1) else {
      return
    }
    
    defaults.setValue(data, forKey: key)
    defaults.synchronize()
  }
  
  func retrieve(by key: String) -> UIImage? {
    guard let data = defaults.data(forKey: key) else {
      return nil
    }
    
    return UIImage(data: data)
  }
}

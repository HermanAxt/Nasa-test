//
//  TableViewImageFetcher.swift
//  NASA-test
//
//  Created by Герман Акст on 13.12.2020.
//

import UIKit

class TableViewImageFetcher {
  private var data: [Item] = []
  private var images: [Int: UIImage] = [:]
  private let cacher = ImageCacher()
  
  var photoUpdated: ((UIImage, IndexPath) -> Void)?
  
  init(data: [Item] = []) {
    self.data = data
  }
  
  func fetchImage(by indexPath: IndexPath) -> UIImage? {
    return images[indexPath.row]
  }
  
  func update(data: [Item]) {
    self.data = data
  }
  
  func cellIsReusing(on indexPath: IndexPath) {
    let index = indexPath.row
    let item = data[index]
    
    if let urlString = item.links?.first?.href, let url = URL(string: urlString) {
      if let cachedImage = cacher.retrieve(by: urlString) {
        self.images[index] = cachedImage
        self.photoUpdated?(cachedImage, .init(row: index, section: 0))
      } else {
        DispatchQueue.global(qos: .utility).async {
          if let data = try? Data(contentsOf: url) {
            let image = UIImage(data: data)
            DispatchQueue.main.async {
              self.images[index] = image
              
              if let image = image {
                self.cacher.cache(image, key: urlString)
                self.photoUpdated?(image, .init(row: index, section: 0))
              }
            }
          }
        }
      }
    }
  }
}

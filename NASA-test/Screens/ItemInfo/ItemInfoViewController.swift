//
//  ItemInfoViewController.swift
//  NASA-test
//
//  Created by Герман Акст on 13.12.2020.
//

import UIKit

class ItemInfoViewController: UIViewController {
  
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var centerLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var photographerLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  var subItem: SubItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    activityIndicator.hidesWhenStopped = true
    activityIndicator.startAnimating()
    navigationController?.navigationBar.tintColor = UIColor.black
    navigationItem.title = subItem?.title ?? "no title"
    centerLabel.text = "Center: \(subItem?.center ?? "-")"
    let string = subItem?.date_created?.replacingOccurrences(of: "T00:00:00Z", with: "")
    dateLabel.text = "Date Created: \(string ?? "-")"
    photographerLabel.text = "Photographer: \(subItem?.photographer ?? "-")"
    descriptionLabel.text = subItem?.description
  }
  
  func configure(by subItem: SubItem?, and link: Link?) {
    self.subItem = subItem
   
    if let urlString = link?.href, let url = URL(string: urlString) {
      DispatchQueue.global(qos: .utility).async {
        if let data = try? Data(contentsOf: url) {
          let image = UIImage(data: data)
          DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.photoImageView.image = image
          }
        } else {
          DispatchQueue.main.async {
            self.photoImageView.image = nil
          }
        }
      }
    } else {
      photoImageView.image = nil
    }
  }
  
}

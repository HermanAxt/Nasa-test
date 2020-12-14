//
//  ItemTableViewCell.swift
//  NASA-test
//
//  Created by Герман Акст on 13.12.2020.
//

import UIKit

class ItemTableViewCell: UITableViewCell, NibLoadable {
  @IBOutlet private weak var photoView: UIImageView!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var subtitleLabel: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    photoView.contentMode = .scaleAspectFill
    separatorInset = .init(top: 0, left: 8, bottom: 0, right: 0)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    photoView.image = nil
  }
  
  func set(image: UIImage?) {
    photoView.image = image
    
  }
  
  func configure(by subItem: SubItem?) {
    titleLabel.text = subItem?.title
    subtitleLabel.text = subItem?.photographer
  }
}

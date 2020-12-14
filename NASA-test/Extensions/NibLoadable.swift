//
//  NibLoadable.swift
//  NASA-test
//
//  Created by Герман Акст on 13.12.2020.
//

import UIKit

public protocol NibLoadable where Self: UIView  {
    
}

// MARK: - From Nib

public extension NibLoadable {

    static var name: String {
         return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: name, bundle: Bundle.init(for: self))
    }

    static func loadFromNib() -> Self {
        guard let nib = Bundle(for: self).loadNibNamed(name, owner: nil, options: nil) else {
            fatalError("Failed loading the nib named \(name) for 'NibLoadable' view of type '\(self)'.")
        }
        guard let view = (nib.first { $0 is Self }) as? Self else {
            fatalError("Did not find 'NibLoadable' view of type '\(self)' inside '\(name).xib'.")
        }
        return view
    }
}



extension UITableView {
  func register(_ nibLoadableType: NibLoadable.Type) {
    register(nibLoadableType.nib, forCellReuseIdentifier: nibLoadableType.name)
  }

  func getCell<T: NibLoadable & UITableViewCell>(by indexPath: IndexPath) -> T {
    return dequeueReusableCell(withIdentifier: T.name, for: indexPath) as! T
  }
}


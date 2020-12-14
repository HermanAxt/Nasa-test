//
//  MainViewController.swift
//  NASA-test
//
//  Created by Герман Акст on 13.12.2020.
//

import UIKit

class MainViewController: UIViewController {
  private var data: [Item] = []
  
  @IBOutlet private weak var tableView: UITableView!
  
  private let fetcher = TableViewImageFetcher()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureNavigationBar()
    configureTableView()
    fetcher.photoUpdated = {
      image, index in
      if let cell: ItemTableViewCell = self.tableView.cellForRow(at: index) as? ItemTableViewCell {
        cell.set(image: image)
        
      }
    }
  }
  
  private func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorInset = .init(top: 0, left: 15000, bottom: 0, right: 0)
    tableView.register(ItemTableViewCell.self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    fetchData()
    
  }
  
  private func fetchData() {
    NASAManager.shared.fetchData { (items) in
      self.data = items
      self.fetcher.update(data: items)
      self.tableView.reloadData()
    }
  }
  
  private func configureNavigationBar() {
    title = "NASA Image Library"
    navigationController?.navigationBar.prefersLargeTitles = false
  }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    let item = data[indexPath.row]
    let subItem = item.data?.first
    let link = item.links?.first
    let vc = ItemInfoViewController()
    vc.configure(by: subItem, and: link)
    
    navigationController?.pushViewController(vc, animated: true)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: ItemTableViewCell = tableView.getCell(by: indexPath)
    fetcher.cellIsReusing(on: indexPath)
    let item = data[indexPath.row]
    let subItem = item.data?.first
    cell.configure(by: subItem)
    let image = fetcher.fetchImage(by: indexPath)
    cell.set(image: image)
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
}

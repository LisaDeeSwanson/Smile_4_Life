//
//  GenericTableViewController.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 8/16/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit

class GenericTableViewController<T: BaseUserTableViewCell<U>, U>: UITableViewController {
  
  let cellID = "cellID"
  var calendarUsers = [U]()
  
  override func viewDidLoad() {
    tableView.register(T.self, forCellReuseIdentifier: cellID)
    tableView.backgroundColor = .cpBackground2
    tableView.estimatedRowHeight = 60
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return calendarUsers.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! BaseUserTableViewCell<U>
    cell.backgroundColor = .cpBackground2
    cell.calendarUser = self.calendarUsers[indexPath.row]
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
}

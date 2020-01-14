//
//  NotificationsTableViewController.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 1/7/19.
//  Copyright © 2019 Technology Speaks. All rights reserved.
//

import UIKit


class NotificationsTableViewController: GenericTVCNoHeaders<NotificationsTVCell, Notifications> {
  

  override func loadView() {
    super.loadView()
    //    setupTableViewLayout()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    tableView.register(NotificationsSwitchTableviewCell.self, forCellReuseIdentifier: "Cell1")
    
    tableView.backgroundView = UIImageView(image: UIImage(imageLiteralResourceName: "smile_home.png"))
    tableView.separatorStyle = .none
    dataArray = []
  }
  
  //  func setupTableViewLayout() {
  //
  //    NSLayoutConstraint.activate([
  //      tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
  //      tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
  //      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
  //      tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
  //
  //      ])
  //  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //    var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    switch indexPath.row {
    case 0:
      if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? UITableViewCell {
        cell.backgroundColor = UIColor.clear
        cell.backgroundView = UIImageView(image: UIImage(imageLiteralResourceName: "smile_logo.png"))
        return cell
      }
    case 1:
      if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? UITableViewCell {
        cell.backgroundColor = UIColor.cpCharcoalTrans
        return cell
      }
    case 2:
      if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as? NotificationsSwitchTableviewCell {
        cell.backgroundColor = UIColor.clear
        cell.background.baseTextLabel.text = "Brush Notification"
        return cell
      }
    case 3:
      if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? UITableViewCell {
        cell.backgroundColor = UIColor.cpCharcoalTrans
        return cell
      }
    case 4:
      if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as? NotificationsSwitchTableviewCell {
        cell.backgroundColor = UIColor.clear
        cell.background.baseImageView.image = UIImage(imageLiteralResourceName: "flossIcon")
        cell.background.toggleSwitch.isOn = false
        cell.background.baseTextLabel.text = "Floss Notification"
        return cell
      }
    default:
      return UITableViewCell()
    }
    return UITableViewCell()
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.row {
    case 0:
      return 125
    case 1:
      return 20
    case 3:
      return 20
    default:
      return 60
    }
  }
  
}


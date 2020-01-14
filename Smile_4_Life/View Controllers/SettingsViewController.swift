//
//  SettingsViewController.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 8/3/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit
import UserNotifications

protocol PresentViewControllerFromMain {
  func presentViewController(index: Int)
}

class SettingsViewController: UITableViewController {
  
  let cellId = "cellId"
  var viewModelMainView: ViewModelMainView!
  var presentDelegate: PresentViewControllerFromMain?
  lazy var notificationsAuthorization: Bool = false
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    tableView.separatorColor = UIColor.cpCharcoalTrans
    
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
      if granted {
        print("You have authorizations")
        self.notificationsAuthorization = true
      } else {
        print(error?.localizedDescription ?? "")
      }
    }
  }

  private func setupTableViewUI() {
    tableView.backgroundColor = .cpPurpleGrey
  }
  
}

extension SettingsViewController {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
    
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    cell.backgroundColor = .cpSlate
    cell.textLabel?.textColor = .cpSlate

    switch indexPath.row {
    case 0:
      print(indexPath.row)
      cell.selectionStyle = .none
      cell.layer.cornerRadius = 5
      cell.textLabel?.text = "Notifications"
      cell.backgroundColor = UIColor.cpLightBlue2
    case 1:
      print(indexPath.row)
      if notificationsAuthorization {
        cell.indentationLevel = 2
        cell.textLabel?.text = "Add Notifications"
        cell.textLabel?.textColor = UIColor.cpCharcoalTrans
        cell.accessoryType = .disclosureIndicator
      } else {
        cell.isHidden = true
      }
    case 2:
      if notificationsAuthorization {
        cell.indentationLevel = 2
        cell.textLabel?.text = "Edit Notifications"
        cell.textLabel?.textColor = UIColor.cpCharcoalTrans
        cell.accessoryType = .disclosureIndicator
      } else {
        cell.isHidden = true
      }
    case 3:
      cell.selectionStyle = .none
      cell.layer.cornerRadius = 5
      cell.textLabel?.text = "Users"
      cell.backgroundColor = UIColor.cpLightBlue2
    case 4:
      print(indexPath.row)
      cell.indentationLevel = 2
      cell.textLabel?.text = "Add Users Calendar"
      cell.textLabel?.textColor = UIColor.cpCharcoalTrans
      cell.accessoryType = .disclosureIndicator
    default:
      print("I should never be here")
    }
    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
//    cell.textLabel?.textColor = .white
    return cell
  }
  
//  override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//    tableView.deselectRow(at: indexPath.row, animated: true)
//  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.row {
    case 0, 3:
      return 40
    case 1, 2, 4:
      return 35
    default:
      return 20
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    switch indexPath.row {
      case 1:
        self.presentDelegate?.presentViewController(index: indexPath.row)
        break
      case 4:
        self.presentDelegate?.presentViewController(index: indexPath.row)
        break
      default:
        print("This should not be printing tableView didSelectRowAt default of switch")
    }
  }
  
}

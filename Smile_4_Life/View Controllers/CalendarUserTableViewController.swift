//
//  CalendarUserTableViewController.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 8/16/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit
import CoreData

enum NotificationsViewModelType {
  case addUser
  case filler
  case calendarUserHeader
  case calendarUsers
}

class CalendarUserCell: BaseUserTableViewCell<CalendarUsers> {
  
  override var calendarUser: CalendarUsers! {
    didSet {
      if let imageView = calendarUser.image {
        baseImageView.image = UIImage(data: imageView)
        baseTextLabel.text = calendarUser.name
      } else {
      baseImageView.image = #imageLiteral(resourceName: "defaultProfile-Small.png")
      baseTextLabel.text = calendarUser.name
      }
    }
  }
}

class CalendarUserTableViewController: GenericTableViewController<CalendarUserCell, CalendarUsers> {
  
  
  var viewModelMainView: ViewModelMainView?
  var presentDelegate: PresentViewControllerFromMain?
  var segmentDelegate: UpdateSegmentControlDelegate?
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("In CalendarUser viewWillAppear")
    tableView.reloadData()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    calendarUsers = viewModelMainView!.getAllCalendarUsers()
    print("Initialed calendarUsers________________________________________________________-")
    for users in calendarUsers {
      print(users.name, users.userID)
    }
    print(calendarUsers.count)
    addNotification()
  }
  
  private func addNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(notificationUpdateTableView(_ :)), name: NSNotification.Name(kCalendarUserWillAddNewUserToTableViewNotificaiton), object: nil)
  }
  
  @objc func notificationUpdateTableView(_ notificaiton: Notification) {
    print("In Calendar User Notification ")
    for users in calendarUsers {
      print(users.name, users.userID)
    }
    let userInfo = notificaiton.userInfo as! Dictionary<String, AnyObject>
    if let newUser = userInfo["newUser"] as? CalendarUsers {
      print(viewModelMainView?.userDefaultsStandard.bool(forKey: kEditUser) ?? "no value")
      if (viewModelMainView?.userDefaultsStandard.bool(forKey: kEditUser))! {
        for user in calendarUsers {
          if user.userID == newUser.userID {
            user.name = newUser.name
            user.image = newUser.image
            viewModelMainView?.userDefaultsStandard.set(false, forKey: kEditUser)
            tableView.reloadData()
            }
          }
      } else {
        calendarUsers.append(newUser)
//        print("After update")
//        for users in calendarUsers {
//          print(users.name, users.userID)
//        }
        let newIndexPath = IndexPath(row: calendarUsers.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .fade)
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let user = calendarUsers[indexPath.row]
    print("In didSelectRowAt: \(indexPath.row)")
    print(user.userID)
    print(user.name)
  }
  
  override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: handelDeleteUser)
    deleteAction.backgroundColor = .cpLightRed
    let editCurrentUser = UITableViewRowAction(style: .normal, title: "Edit\nInfo", handler: handelEditUser)
    editCurrentUser.backgroundColor = .cpSunset2
    let loadCalendar = UITableViewRowAction(style: .normal, title: "Load\nCalendar", handler: handelLoadCalendar)
    loadCalendar.backgroundColor = .cpLightBlue2
    return [deleteAction, editCurrentUser, loadCalendar]
  }
  
  private func handelDeleteUser(action: UITableViewRowAction, index: IndexPath) {
    print("In handleDeleteUser")
    let calendarUser = calendarUsers[index.row]
    let deleteAlert = UIAlertController(title: "Stop - Can not be undone.", message: "This will delete all stored hygiene events.", preferredStyle: .alert)
    deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    deleteAlert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (alert: UIAlertAction!) in
      self.deleteUserCalendar(user: calendarUser, index: index)
    }))
    present(deleteAlert, animated: true, completion: nil)
    
  }
  
  private func handelEditUser(action: UITableViewRowAction, index: IndexPath) {
    print("in handleEditUser")
    let viewController = CreateNewCalendarUser()
    viewController.addUserImage.image = UIImage(data: calendarUsers[index.row].image!)
    viewController.addUserName.text = calendarUsers[index.row].name
    viewController.updateUser = calendarUsers[index.row]
    viewController.viewModelMainView = viewModelMainView
    let navCon = UINavigationController(rootViewController: viewController)
    navCon.navigationItem.title = "Edit User Calendar"
    present(navCon, animated: true)
  }
  
  private func handelLoadCalendar(action: UITableViewRowAction, index: IndexPath) {
    print("in handelLoadCalendar")
    self.segmentDelegate?.notifiyMainControlerOfSegmentChange(indexOfSegment: 0)
    let userDict: [String : AnyObject] = [kCurrentCalendarUser : calendarUsers[index.row]]
    NotificationCenter.default.post(name: Notification.Name(kNotifyParentMainViewUserHasChanged), object: nil, userInfo: userDict)
  }
  
  @objc private func deleteUserCalendar(user: CalendarUsers, index: IndexPath) {
    viewModelMainView?.cascadeDeleteCalendarUser(user: user)
    calendarUsers.remove(at: index.row)
    let nextCurrentUser = calendarUsers[calendarUsers.count - 1]
    viewModelMainView?.userDefaultsStandard.set(nextCurrentUser.userID.uuidString, forKey: kCurrentCalendarUserID)
    NotificationCenter.default.post(name: Notification.Name(kCurrentUserHasChangedNotification), object: nil)
    self.tableView.deleteRows(at: [index], with: UITableView.RowAnimation.middle)
    viewModelMainView?.currentUser = calendarUsers[calendarUsers.count - 1]
  }
  
}



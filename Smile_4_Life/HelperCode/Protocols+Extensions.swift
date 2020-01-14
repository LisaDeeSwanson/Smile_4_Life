//
//  Protocols.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 8/7/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import Foundation
import UIKit

protocol PersistanceViewModelMain: class {
  func set(stack: ViewModelMainView)
}

protocol UpdateSegmentControlDelegate {
  func notifiyMainControlerOfSegmentChange(indexOfSegment: Int)
}

//protocol UpdateCalendarUsersTableview {
//  func didAddNewCalendarUser(newUser: CalendarUsers)
//  func didEditCalendarUser(currentUser: CalendarUsers)
//}

//protocol RefreshContainerView {
//  func refreshTableView(sender: UIViewController)
//  func refreshCollectionView(sender: UIViewController)
//}

//protocol ReloadHygieneEventsCollectionView {
//  func reloadCollectionView()
//}

protocol HandleTapGesture: class {
  func addCustomHygieneEvent(eventType: Int, date: Date, tag: Int)
}

protocol NotifyCollViewEventsDeletedDelegate {
  func notifyCVEventsToBeDeleted(dayOfEvent: Int, indexOfEvent: Int, dismissVC: Bool)
}

protocol NotificationsViewModelItem {
  var type: NotificationsViewModelType { get }
  var rowCount: Int { get }
}

extension NotificationsViewModelItem {
  var rowCount: Int {
    return 1
  }
}

extension UISegmentedControl {
  static var navBarSegmentControl: UISegmentedControl = {
    let nbSC = UISegmentedControl()
    nbSC.insertSegment(with: #imageLiteral(resourceName: "calendarIconSmall"), at: 0, animated: true)
    nbSC.insertSegment(with: #imageLiteral(resourceName: "peopleIcon"), at: 1, animated: true)
    nbSC.insertSegment(with: #imageLiteral(resourceName: "Reminders-Small"), at: 2, animated: true)
    nbSC.insertSegment(with: #imageLiteral(resourceName: "tabBarTimerIcon"), at: 3, animated: true)
    nbSC.insertSegment(with: #imageLiteral(resourceName: "gear-Small.png"), at: 4, animated: true)
    let titleAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
    nbSC.setTitleTextAttributes(titleAttributes, for: .normal)
    nbSC.backgroundColor = .cpUISegment
    nbSC.tintColor = .cpSlate
//    nbSC.selectedSegmentTintColor = .cpPurpleGrey
    nbSC.translatesAutoresizingMaskIntoConstraints = false
    return nbSC
  }()
}

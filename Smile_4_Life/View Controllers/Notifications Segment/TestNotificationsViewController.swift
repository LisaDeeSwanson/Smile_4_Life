//
//  TestNotificationsViewController.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 2/4/19.
//  Copyright © 2019 Technology Speaks. All rights reserved.
//

import UIKit
import UserNotifications

class TestNotificationsViewController: AddCustomEventViewController {
  
  var currentUser: CalendarUsers?
  var segmentDelegate: UpdateSegmentControlDelegate?
  var viewModelMainView: ViewModelMainView!
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    titleLabel.text = "Create\nReminder Notification"
    titleLabel.textColor = .white
    titleLabel.backgroundColor = UIColor.cpLightBlue2
    saveLabel.tag = 1
    customDatePicker.maximumDate = .none
    customDatePicker.datePickerMode = .time
    customDatePicker.minuteInterval = 15
    view.backgroundColor  = UIColor.cpLightBlue
  }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    print(viewModelMainView.currentUser ?? 0)
    currentUser = viewModelMainView?.currentUser
    if currentUser != nil {
      let notifications = viewModelMainView.getAllNotifications(viewModelMainView.currentUser)
      if !notifications.isEmpty {
        for notification in notifications {
            print(notification.eventType)
            print(notification.time)
            print(notification.owner.name)
        }
      }
    }
}
  
  override func notifyMainViewOfCustomHygieneEvent(eventType: Int, date: Date, tag: Int) {
    print("I am in over on notifications \(customDatePicker.date)")
    print(eventType, tag)
    viewModelMainView.createNotification(calendarUser: viewModelMainView.currentUser, time: date, eventType: eventType)
  }
  
}


extension TestNotificationsViewController {
  
  private func checkNotificationsAuthorization() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
      if granted {
        print("You have authorizations")
        
      } else {
        print(error?.localizedDescription ?? "")
      }
    }
  }
  
  
}

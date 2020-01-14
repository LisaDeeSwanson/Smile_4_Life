//
//  CalendarUsersTableviewViewModels.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 5/4/19.
//  Copyright © 2019 Technology Speaks. All rights reserved.
//

import Foundation


class NotificationsViewModelAddNotifications: NotificationsViewModelItem {
  
  var type: NotificationsViewModelType {
    return .addUser
  }
  
  var sectionTitle: String {
    return "Add New Calendar User"
  }
  
  var imageName: String = "peoplePlus"
  
}


class NotificationsViewModelSpaceFiller: NotificationsViewModelItem {
  var type: NotificationsViewModelType {
    return .filler
  }
  
  var rowHeight: Int
  
  init(rowHeight: Int) {
    self.rowHeight = rowHeight
  }
  
}

class NotificationsViewModelUsersCalendarHeader: NotificationsViewModelItem {
  var type: NotificationsViewModelType {
    return .calendarUsers
  }
  
  var sectionTitle: String {
    return "Current User Calendars"
  }
  
}

class NotificationsViewModel: NSObject {
  var items = [NotificationsViewModelItem]()
  
  
}


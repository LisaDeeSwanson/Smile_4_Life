//
//  CONSTANTS+UIKit.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 8/13/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit


struct Test {
  var select: Int = 0
  var deSelect: Int = 0
}
var segment = Test()
var lastSender = UISegmentedControl()

var kUserDefaultID: UUID? {
  let currentUserDefaults = UserDefaults.standard
  let stringUUID = currentUserDefaults.object(forKey: kCurrentCalendarUserID) as! String
  let id = UUID(uuidString: stringUUID)
  return id
}

let kNotifyParentMainViewUserHasChanged = "mainHomeWillUpdateContainerView"
let kCalendarUserWillAddNewUserToTableViewNotificaiton = "calendarUserWillAddNewUser"
let kCurrentUserHasChangedNotification = "currentUserHasChanged"
let kNotifyChildViewCalendarCVToLoadNewUser = "updateHygieneEventsCollectionViewData"
let kInsertNewHygieneEvent = "insertNewHygieneEvent"
let kNotifyCollectionViewToLoadDailyEventTV = "loadDailyEventsTableview"

let kName = "name"
let kUserID = "userID"
let kImage = "image"
let kDefaultImage = #imageLiteral(resourceName: "defaultProfile-Small.png").pngData()
let kDefaultUserID = UUID().uuidString
let kCurrentCalendarUserID = "currentCalendarUserID"
let kInitialUser = "initialUser"
let kEditUser = "isEditedUser"
let kCurrentCalendarUser = "currentCalendarUser"


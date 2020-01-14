//
//  DateAndTimeMethods.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 2/20/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//



import Foundation

class LocalModules {
  
  
  func testDateCode(date: Date) -> Void {
//    let date = Date()
    let calendar = Calendar(identifier: .gregorian)
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    formatter.locale = Locale(identifier: "en_US")
    
    var dates = calendar.dateComponents([.year, .month, .day, .timeZone, .weekday, .hour, .minute], from: date)
    print("DATE breakdown:")
    print(Calendar.current.date(from: dates)!)
    print(formatter.string(from: date))
    print(dates.day ?? 0)
    print(dates.month ?? 0)
    print(dates.year ?? 0)
    print(dates.weekday ?? 0)
    print(dates.hour ?? 0)
    print(dates.minute ?? 0)
    print("\(String(describing: dates.hour)):\(String(describing: dates.minute))")
//    print(formatter.weekdaySymbols[dates.weekday!])
    dates.month = 3
      dates.day = 1 - 1
      print(dates.weekday! + 2)
    let newDate = Calendar.current.date(from: dates)
    let _ = dates.year

    let day1 = formatter.weekdaySymbols[Calendar.current.component(.weekday, from: newDate!)]
    print(day1)
    let range = calendar.range(of: .day, in: .month, for: date)!
    let numDays = range.count
    print(numDays) // 31
  }
  
  func getRandomUserCalendarImage() -> String {
    let userImageNames: [String] = ["userSmileLight", "userSmileDark", "userDinoDark", "userDinoLight", "userTeethLight", "userTeethDark", "userBigSmileLight", "userBigSmileDark", "userSillyFaceLight", "userSillyFaceDark", "userFemaleLight", "userFemaleDark", "userMaleLigt", "userMaleDark"]
    let randomNumber = Int(arc4random_uniform(UInt32(userImageNames.count)))
    let randomImageSelection = userImageNames[randomNumber]
    return randomImageSelection
  }
}

class Helpers {
  
//  static func setCurrentCalendar(_ user: User) {
//    let defaults = UserDefaults.standard
//    defaults.setValue(user.name, forKey: "lastCalendarLoaded")
//
//  }
  
  static func setCalendar(_ calendar: String) {
    let defaults = UserDefaults.standard
    defaults.setValue(calendar, forKey: "lastCalendarLoaded")
    
  }
  
  static func getLastCalenderUsed(_ lastCalendarLoaded: String) -> String {
    let defaults = UserDefaults.standard
    
    if defaults.object(forKey: lastCalendarLoaded) != nil {
      let calendar = defaults.string(forKey: lastCalendarLoaded)!
      return calendar
    } else {
      defaults.setValue("None", forKey: lastCalendarLoaded)
      return defaults.string(forKey: lastCalendarLoaded)!
    }
  }
  
  func tablesExist() -> Bool {
    var dbExists: Bool?
    let defaults = UserDefaults.standard
    
    if defaults.object(forKey: "dbTablesExist") != nil {
      dbExists = defaults.bool(forKey: "dbTablesExist")
    } else {
      defaults.setValue(false, forKey: "dbTablesExist")
      dbExists = false
    }
    return dbExists!
  }
  
  static func getDateFormatter(_ templete: String) -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = templete
    formatter.setLocalizedDateFormatFromTemplate(templete)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }
  
  static func convertNSDateToSqliteDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    let cal = Calendar.current
    let _ = cal.ordinality(of: .day, in: .year, for: date)
    //    print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
    //    print(day)
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    
    //    let sqlite3Date = dateFormatter.string(from: date)
    
    return dateFormatter.string(from: date)
    
  }
  
//  static func getInstanceOfOralEvent(_ date: Date, event: String) -> OralEvent {
//
//    let eventName: String = event
//    let timeLabel: String = Helpers.getDateFormatter("hhmm").string(from: date)
//    let sectionHeaderName: String = Helpers.getDateFormatter("EEEE-MMMM-dd").string(from: date)
//    //Nice formatted code: it's a keeper
//    //    let index: Int = Int(Helpers.getDateFormatter("MMdd").stringFromDate(date).stringByReplacingOccurrencesOfString("/", withString: ""))!
//    let dateStringified = Helpers.convertNSDateToSqliteDate(date)
//    let calendarOwner: Int32 = currentUser.id!
//
//    return OralEvent(date: date, eventName: eventName, timeLabel: timeLabel, sectionHeaderName: sectionHeaderName, dateStringified: dateStringified, calendarOwnerId: calendarOwner)
//
//  }
  
//  static func getOralHygieneEvent(_ date: Date, event: String) -> OralHygieneEvent {
//
//    let eventName: String = event
//    let timeLabel: String = Helpers.getDateFormatter("hhmm").string(from: date)
//    let dateStringified = Helpers.convertNSDateToSqliteDate(date)
//    //    print(dateStringified)
//
//    return OralHygieneEvent(sortingIndex: dateStringified as String, eventName: eventName, timeLabel: timeLabel)
//
//  }
}

class DateHelpers {
  
  static func getRandomDate() -> Date {
    let secsInADay = 60.0 * 60.0 * 24
    let multiplyerArray: [Double] = [1,-1,24,-25,28,-30,31,40,-40,-50,50, 150, -150, 200, -200, 275, -275]
    guard let randomYear = multiplyerArray.randomElement() else { return Date() }
    let timeInterval = secsInADay * randomYear
    let date = Date(timeInterval: timeInterval, since: Date())
    
    return date
  }
  
  static func getTimeFromDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    
    return dateFormatter.string(from: date)
  }
  
  static func getStringTimeFromDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    return dateFormatter.string(from: date)
  }
  
  static func convertStringDateToNSDate(_ date: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    dateFormatter.locale = Locale.current
    return dateFormatter.date(from: date)!
  }
  
  static func getSectionHeaderName(_ date: Date) -> String {
    return Helpers.getDateFormatter("EEEE-MMMM-dd").string(from: date)
  }
  
  static func getPrettyDate(date: Date) -> String {
    let template = "EEEE, MMM d, yyyy"
    let prettyDate = Helpers.getDateFormatter(template).string(from: date)
    return prettyDate
  }
  
  static func getDateFromDateComps(year: Int, month: Int, day: Int) -> String {
    var dateComps = DateComponents()
    dateComps.year = year
    dateComps.month = month
    dateComps.day = day
    let date = Calendar.current.date(from: dateComps)!
    return DateHelpers.getPrettyDate(date: date)
  }
  
  func getDate() {
    let _ = Calendar.current
    var dateComponents = DateComponents()
    
    dateComponents.month = 11
    dateComponents.day = 20
    dateComponents.hour = 16
    dateComponents.minute = 5
  }
}

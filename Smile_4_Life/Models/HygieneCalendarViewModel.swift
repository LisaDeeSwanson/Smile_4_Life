//
//  HygieneCalendarViewModel.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 11/2/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import Foundation
import UIKit

class HygieneCalendarViewModel {
  
  var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
  var monthsArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  var countLeft: Int = -1
  var countRight: Int = 0
  var currentMonthIndex: Int = 0
  var countOfUserHygieneData: Int = 0
  var currentYear: Int = 0
//  var presentMonthIndex: Int = 0
//  var presentYear: Int = 0
  var todaysDate = 0
  var firstWeekdayOfMonth = 0
  var numberOfWeeksInMonth: CGFloat = 0
  var currentMonth = 0
  
  private let formatter = DateFormatter()
  private let calendar = Calendar.current
  private let today = Date()
  
  init() {
    currentMonth = Calendar.current.component(.month, from: Date())
    currentYear = Calendar.current.component(.year, from: Date())
    todaysDate = Calendar.current.component(.day, from: Date())
    firstWeekdayOfMonth = getFirstWeekDay()
//    numberOfWeeksInMonth = getNumberOfWeeksInMonth(currentIndex: currentMonthIndex)
//    presentMonthIndex = currentMonthIndex
//    presentYear = currentYear
  }
  
  func getNumberOfWeeksInMonth(daysInMonth: Int) -> CGFloat {
//    let days = (firstWeekdayOfMonth - 1) + (getNumberOfDaysInMonth())
    let weeks = ceil(CGFloat((Double(daysInMonth)) / 7.0))
    return CGFloat(weeks)
  }
  
  func getNumberOfDaysInMonth() -> Int {
    let dateComp = DateComponents(year: currentYear, month: currentMonth)
    guard let date = calendar.date(from: dateComp) else { return 0}
    guard let range = calendar.range(of: .day, in: .month, for: date)?.count else { return 0 }
    return range
  }
  
  func getFirstWeekDay() -> Int {
//    print(currentMonthIndex)
    
    let stringToDate = "\(currentYear)-\(currentMonth)-01".date!
    let day = Calendar.current.component(.weekday, from: stringToDate)
    return day
  }
  

  
  func sortHygieneEvents(eventsArray: [HygieneEvents]) -> [(month: Int, day: Int, events: [String], eventYear: Int)] {
    
    var actvity: [(month: Int, day: Int, events: [String], eventYear: Int)] = []
    var yearCheck = 0
    var monthCheck = 0
    var dayCheck = 0
    var eventArray: [String] = []
    
    
    for (index, event) in eventsArray.enumerated() {
      let year = Calendar.current.component(.year, from: event.date)
      let month = Calendar.current.component(.month, from: event.date)
      let day = Calendar.current.component(.day, from: event.date)
      let eventType = "\(event.eventType).png"
      if (yearCheck == 0 && monthCheck == 0 && dayCheck == 0) || (yearCheck == year && monthCheck == month && dayCheck == day) {
        yearCheck = year
        monthCheck = month
        dayCheck = day
        eventArray.append(eventType)
        if index == eventsArray.count - 1 {
          actvity.append((monthCheck, dayCheck, eventArray, yearCheck))
        }
      } else {
        actvity.append((monthCheck, dayCheck, eventArray, yearCheck))
        yearCheck = year
        monthCheck = month
        dayCheck = day
        eventArray = []
        eventArray.append(eventType)
        if index == eventsArray.count - 1 {
          actvity.append((monthCheck, dayCheck, eventArray, yearCheck))
        }
      }
    }
    return actvity
    
  }
  
  func insertNewHygieneEventInHygieneData(hygieneCVEvents: [HygieneCollectionViewEvent], date: Date, eventType: Int) -> [HygieneCollectionViewEvent] {
    let dateComps = getDateComponents(date: date)
    var countOfItems = hygieneCVEvents.count
    var eventDayIndex = -1
    var eventMonthIndex = -1
    func addEventToData() {
      hygieneCVEvents[eventMonthIndex].days[eventDayIndex].1.append(getImageInformation(imageName: "\(eventType).png", time: dateComps.time, date: date))
      hygieneCVEvents[eventMonthIndex].days[eventDayIndex].1.sort { ($0.date < $1.date)}
    }
    
    if dateComps.dateComp.year == hygieneCVEvents[currentMonthIndex].year && dateComps.dateComp.month == hygieneCVEvents[currentMonthIndex].month {
      eventMonthIndex = currentMonthIndex
      eventDayIndex = dateComps.day + hygieneCVEvents[eventMonthIndex].indexOfFirstDayOfMonth - 1
      addEventToData()
//      hygieneCVEvents[currentMonthIndex].days[itemIndex].1.append(getImageInformation(imageName: "\(eventType).png", time: dateComps.time, date: date))
//      hygieneCVEvents[currentMonthIndex].days[itemIndex].1.sort { ($0.date < $1.date)}
      print("CheckPoint")
    } else {
      for (index, event) in hygieneCVEvents.enumerated() {
        if event.year == dateComps.dateComp.year && event.month == dateComps.dateComp.month {
          eventMonthIndex = index
          eventDayIndex = dateComps.day + hygieneCVEvents[eventMonthIndex].indexOfFirstDayOfMonth - 1
          addEventToData()
        }
      }
    }

    return hygieneCVEvents
  }
  
  func createHygieneCVDataModel(hygieneEvents: [HygieneEvents]) -> [HygieneCollectionViewEvent]{
    var hygieneCollectionViewEvents: [HygieneCollectionViewEvent] = []
    print(hygieneEvents.count)
    var lastDateViewed: DateComponents = calendar.dateComponents([.year, .month, .day], from: "2000-01-01".date!)
    if hygieneEvents.isEmpty {
      let hygieneCVEvent = getHygieneCollectionViewEvent(date: Date(), event: 0)
      hygieneCVEvent.days = hygieneCVEvent.days.sorted { ($0.0 < $1.0)}
      hygieneCollectionViewEvents.append(hygieneCVEvent)
    } else {
      for event in hygieneEvents {
        print(event.date)
        let dateComps = getDateComponents(date: event.date)
//        print(Date(), event.date, dateComps.dateComp.year, dateComps.dateComp.month, dateComps.day, dateComps.time)
        if lastDateViewed == dateComps.dateComp && !hygieneCollectionViewEvents.isEmpty {
//          let _ = lastDateViewed
          let addEventToExisting = hygieneCollectionViewEvents.popLast()!
          let dailyEvent = getImageInformation(imageName: "\(event.eventType).png", time: dateComps.time, date: event.date)
          let indexOfDay = addEventToExisting.indexOfFirstDayOfMonth + dateComps.day - 1
          addEventToExisting.days[indexOfDay].1.append(dailyEvent)
          hygieneCollectionViewEvents.append(addEventToExisting)
        } else {
          let hygieneCVEvent = getHygieneCollectionViewEvent(date: event.date, event: event.eventType)
          hygieneCVEvent.days = hygieneCVEvent.days.sorted { ($0.0 < $1.0)}
//          for i in hygieneCVEvent.days {
//          print(i.0, i.1)
//          }
          hygieneCollectionViewEvents.append(hygieneCVEvent)
        }
        lastDateViewed = dateComps.dateComp
      }
    }
    self.countOfUserHygieneData = hygieneCollectionViewEvents.count
    if hygieneCollectionViewEvents[countOfUserHygieneData - 1].month != self.currentMonth && hygieneCollectionViewEvents[countOfUserHygieneData - 1].year != self.currentYear {
      let hygieneCVEvent = getHygieneCollectionViewEvent(date: Date(), event: 0)
      hygieneCVEvent.days = hygieneCVEvent.days.sorted { ($0.0 < $1.0)}
      hygieneCollectionViewEvents.append(hygieneCVEvent)
      self.countOfUserHygieneData += 1
    }
    self.currentMonthIndex = countOfUserHygieneData - 1
//    hygieneCollectionViewEvents = self.setCurrentMonthsIndex(monthsOfEvents: hygieneCollectionViewEvents)
    self.countLeft = countOfUserHygieneData - 1
//    self.setCounts()
    return hygieneCollectionViewEvents
  }
  
//  private func setCurrentMonthsIndex(monthsOfEvents: [HygieneCollectionViewEvent]) -> [HygieneCollectionViewEvent] {
//    let indexOfLastMonth = monthsOfEvents.count - 1
//    if monthsOfEvents[indexOfLastMonth].month == self.currentMonth && monthsOfEvents[indexOfLastMonth].year == self.currentYear {
//      let hygieneCVEvent = getHygieneCollectionViewEvent(date: Date(), event: 0)
//      monthsOfEvents.append(hygieneCVEvent)
//    }
//    for (index, monthsOfEvents) in monthsOfEvents.enumerated() {
//      if monthsOfEvents.month == self.currentMonth {
//        self.currentMonthIndex = index
//      }
//    }
//  }
  
//  private func setCounts() {
////    print(currentMonthIndex, countOfUserHygieneData)
//    switch countOfUserHygieneData {
//    case 1:
//      self.countRight = 0
//      self.countLeft = 0
//    case 2:
//      if currentMonthIndex == (countOfUserHygieneData - 1) {
//        self.countRight = 0
//        self.countLeft = 1
//      } else {
//        self.countRight = 1
//        self.countLeft = 0
//      }
//    default:
//      let rangeLow = 0..<self.currentMonthIndex
////      let rangeHigh = (self.currentMonthIndex)...countOfUserHygieneData
//      self.countLeft = rangeLow.count
////      self.countRight = rangeHigh.count
//    }
//  }
  
  func getIndexForFirstDayOfMonth(year: Int, month: Int) -> Int {
    let stringToDate = "\(year)-\(month)-01".date!
    let day = Calendar.current.component(.weekday, from: stringToDate)
    return day - 1
  }
  
  private func getDateComponents(date: Date) -> (dateComp: DateComponents, time: String, day: Int) {
    let dateComp = calendar.dateComponents([.year, .month], from: date)
    let time = DateHelpers.getTimeFromDate(date)
    let day = calendar.dateComponents([.day], from: date).day!
    let dateComponets: (DateComponents, String, Int) = (dateComp: dateComp, time: time, day: day)
    return dateComponets
  }
  
  private func getHygieneCollectionViewEvent(date: Date, event: Int16) -> HygieneCollectionViewEvent {
    let dateComps = getDateComponents(date: date)
    let hygieneCVEvent = HygieneCollectionViewEvent()
    hygieneCVEvent.year = dateComps.dateComp.year ?? 2000
    hygieneCVEvent.month = dateComps.dateComp.month ?? 0
    let _ = hygieneCVEvent.days.popLast()
    hygieneCVEvent.indexOfFirstDayOfMonth = getIndexForFirstDayOfMonth(year: hygieneCVEvent.year, month: hygieneCVEvent.month)
    let dateToConvertToDays = DateHelpers.convertStringDateToNSDate("\(hygieneCVEvent.year)-\(hygieneCVEvent.month)-\(dateComps.day) 00:00")
    var days = getNumberOfDaysInCalendarMonth(date: dateToConvertToDays)
    hygieneCVEvent.numberOfDaysInMonth = days
    let cellPaddingForCalendar = -hygieneCVEvent.indexOfFirstDayOfMonth + 1
    hygieneCVEvent.numberOfWeeksInMonth = self.getNumberOfWeeksInMonth(daysInMonth: hygieneCVEvent.numberOfDaysInMonth - cellPaddingForCalendar)

    while days >= cellPaddingForCalendar {
      hygieneCVEvent.days.append((days, []))
      if days == dateComps.day && event != 0 {
        var addEvents = hygieneCVEvent.days.popLast()!
        addEvents.1.append(getImageInformation(imageName: "\(event).png", time: dateComps.time, date: date))
        hygieneCVEvent.days.append(addEvents)
      }
      days -= 1
    }
    return hygieneCVEvent
  }
  
  
  private func getNumberOfDaysInCalendarMonth(date: Date) -> Int {
    guard let range = calendar.range(of: .day, in: .month, for: date)?.count else { return 0 }
    return range
  }
  
  private func getImageInformation(imageName: String, time: String, date: Date) -> DailyHygieneEvents {
    let dailyEvent = DailyHygieneEvents()
    dailyEvent.date = date
    switch imageName {
    case "1.png":
      dailyEvent.eventImageName = "brushIconNoPlus"
      dailyEvent.eventName = "Brushed teeth at \(time)"
    case "2.png":
      dailyEvent.eventImageName = "flossIconNoPlus"
      dailyEvent.eventName = "Flossed at \(time)"
    case "3.png":
      dailyEvent.eventImageName = "brushFlossIconNoPlus"
      dailyEvent.eventName = "Brushed & Flossed at \(time)"
    default:
      print("Error")
    }
    return dailyEvent
  }
  
}

class HygieneCollectionViewEvent {
  
  var year: Int = 0
  var month: Int = 0
  var numberOfDaysInMonth = 0
  var indexOfFirstDayOfMonth = 0
  var numberOfWeeksInMonth: CGFloat = 0
  var days: [(Int, [DailyHygieneEvents])] = [(0, [])]
}

class DailyHygieneEvents {
  
  var date: Date = Date()
  var eventName: String?
  var eventImageName: String?
  
}

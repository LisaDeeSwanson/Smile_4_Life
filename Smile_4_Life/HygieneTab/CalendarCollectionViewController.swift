//
//  CalendarView.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 9/15/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit


struct Colors {
  static var darkGray = UIColor.darkGray
  static var darkRed = UIColor.cpPurpleGrey
}

struct Style {
  static var bgColor = UIColor.cpSlate
  static var monthViewLblColor = UIColor.cpNewPop
  static var monthViewBtnRightColor = UIColor.cpSlate
  static var monthViewBtnLeftColor = UIColor.cpSlate
  static var activeCellLblColor = UIColor.cpSlate
  static var activeCellLblColorHighlighted = UIColor.black
  static var weekdaysLblColor = UIColor.cpSlate

  static func themeDark() {
    bgColor = Colors.darkGray
    monthViewLblColor = UIColor.cpNewPop
    monthViewBtnRightColor = UIColor.cpNewPop
    monthViewBtnLeftColor = UIColor.cpNewPop
    activeCellLblColor = UIColor.cpNewPop
    activeCellLblColorHighlighted = UIColor.black
    weekdaysLblColor = UIColor.cpSlate
  }
  
  static func themeLight() {
    bgColor = UIColor.cpSlate
    monthViewLblColor = UIColor.cpNewPop
    monthViewBtnRightColor = UIColor.cpNewPop
    monthViewBtnLeftColor = UIColor.cpNewPop
    activeCellLblColor = UIColor.cpNewPop
    activeCellLblColorHighlighted = UIColor.cpNewPop
    weekdaysLblColor = UIColor.cpNewPop
  }
}

class CalendarCollectionViewController: UIViewController, MonthViewDelegate, NotifyCollViewEventsDeletedDelegate {
  
  var calendarUserHygieneEvents: [HygieneEvents] = []
  var currentUserCalendarOfHygieneEvents: [HygieneCollectionViewEvent] =  []
  var viewModelMainView: ViewModelMainView!
  var hygieneCalendarViewModel: HygieneCalendarViewModel!
  var theme = MyTheme.dark
  var currentCalendarUser: CalendarUsers?
  var hygieneCellFlowLayout: HygieneCellFlowLayout!
  var hygieneEventsData: [(month: Int, day: Int, events: [String], eventYear: Int)] = []
  
  let monthView: MonthView = {
    let view = MonthView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let weekdaysView: WeekdaysView = {
    let view = WeekdaysView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let myCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let myCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    myCollectionView.showsHorizontalScrollIndicator = false
    myCollectionView.translatesAutoresizingMaskIntoConstraints = false
    myCollectionView.backgroundColor = UIColor.cpPurpleGrey
    myCollectionView.allowsMultipleSelection = false
    return myCollectionView
  }()
  
  override func loadView() {
    super.loadView()
    setupViews()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if theme == .dark {
      Style.themeDark()
    } else {
      Style.themeLight()
    }
    
    myCollectionView.delegate = self
    myCollectionView.dataSource = self
    myCollectionView.register(HygieneCalendarViewCellCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

    if viewModelMainView.userDefaultsStandard.bool(forKey: kInitialUser) {
      calendarUserHygieneEvents = viewModelMainView.getAllHygieneEventsByCalendarUser(calendarUser: viewModelMainView.currentUser, year: Calendar.current.component(.year, from: Date()))
    }
    hygieneCalendarViewModel = HygieneCalendarViewModel()
//    hygieneEventsData = hygieneCalendarViewModel.sortHygieneEvents(eventsArray: calendarUserHygieneEvents)
    addNotifications()
    initializeView()
    currentUserCalendarOfHygieneEvents = hygieneCalendarViewModel.createHygieneCVDataModel(hygieneEvents: calendarUserHygieneEvents)
    print(currentUserCalendarOfHygieneEvents.count, hygieneCalendarViewModel.currentYear, hygieneCalendarViewModel.currentMonth, hygieneCalendarViewModel.currentMonthIndex)
//    setCurrentMonthsIndex(monthsOfEvents: currentUserCalendarOfHygieneEvents)
    
    
//    for testEvent in currentUserCalendarOfHygieneEvents {
//      print("**********************************")
//      print(testEvent.year, testEvent.month, testEvent.indexOfFirstDayOfMonth, testEvent.numberOfDaysInMonth)
//      print(testEvent.days.count)
//      for i in testEvent.days {
//        print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
//        print(i.0)
//        for event in i.1 {
//          print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
//          print(event.eventImageName)
//          print(event.eventName)
//        }
//        print(i.0, i.1)
//      }
//    }
    self.view.backgroundColor = UIColor.cpPurpleGrey

  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    hygieneCellFlowLayout = HygieneCellFlowLayout(numberOfRows: currentUserCalendarOfHygieneEvents[hygieneCalendarViewModel.currentMonthIndex].numberOfWeeksInMonth)
    myCollectionView.collectionViewLayout = hygieneCellFlowLayout
    print("In viewWillLayoutSubviews CaledarCollectionViewController")
    print(currentUserCalendarOfHygieneEvents.count, hygieneCalendarViewModel.countLeft, hygieneCalendarViewModel.countRight)
    if hygieneCalendarViewModel.countLeft > 0 {
      monthView.btnLeft.isHidden = false
      monthView.btnLeft.isEnabled = true
    } else {
      monthView.btnLeft.isHidden = true
      monthView.btnLeft.isEnabled = false
    }
    if hygieneCalendarViewModel.countRight > 0 {
      monthView.btnRight.isHidden = false
      monthView.btnRight.isEnabled = true
    } else {
      monthView.btnRight.isHidden = true
      monthView.btnRight.isEnabled = false
    }
    print(currentUserCalendarOfHygieneEvents[hygieneCalendarViewModel.currentMonthIndex].month)
   
    monthView.lblName.text = "\(hygieneCalendarViewModel.monthsArr[currentUserCalendarOfHygieneEvents[hygieneCalendarViewModel.currentMonthIndex].month - 1]) \(hygieneCalendarViewModel.currentYear)"
    print(view.frame.height - monthView.lblName.frame.height - weekdaysView.myStackView.frame.height)
    
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    myCollectionView.collectionViewLayout.invalidateLayout()
  }
  

  
  @objc func changeCalendarViewTheme(notification: NotificationCenter) {
    if theme == .dark {
      //change color to opposit
      theme = .light
      Style.themeLight()
    } else {
      theme = .dark
      Style.themeDark()
    }
    self.view.backgroundColor = Style.bgColor
    changeTheme()
  }
  
  func addNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(loadNewCalendarUser), name: Notification.Name(kNotifyChildViewCalendarCVToLoadNewUser), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(insertNewHygieneEvent), name: Notification.Name(kInsertNewHygieneEvent), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(presentDailyEventsTableView), name: NSNotification.Name(kNotifyCollectionViewToLoadDailyEventTV), object: nil)
  }
  
  func changeTheme() {
    myCollectionView.reloadData()
    
    monthView.lblName.textColor = Style.monthViewLblColor
    monthView.btnRight.setTitleColor(Style.monthViewBtnRightColor, for: .normal)
    monthView.btnLeft.setTitleColor(Style.monthViewBtnLeftColor, for: .normal)
    
    for i in 0..<7 {
      (weekdaysView.myStackView.subviews[i] as! UILabel).textColor = Style.weekdaysLblColor
    }
  }
  
  private func initializeView() {
    print(hygieneCalendarViewModel.currentMonthIndex)
    hygieneCalendarViewModel.firstWeekdayOfMonth = hygieneCalendarViewModel.getFirstWeekDay()
//    hygieneCalendarViewModel.presentMonthIndex = hygieneCalendarViewModel.currentMonthIndex
//    hygieneCalendarViewModel.presentYear = hygieneCalendarViewModel.currentYear
    

  }
  
  
  
  func didChangeMonth(sender: UIButton) {
    let count = 1
    print(currentUserCalendarOfHygieneEvents.count, "monthIndex: \(count)", hygieneCalendarViewModel.currentMonthIndex)
    if sender == monthView.btnRight {
      hygieneCalendarViewModel.countRight -= count
      hygieneCalendarViewModel.countLeft += count
      hygieneCalendarViewModel.currentMonthIndex += count
      monthView.btnRight.setNeedsDisplay()
    } else {
      hygieneCalendarViewModel.countLeft -= count
      hygieneCalendarViewModel.countRight += count
      hygieneCalendarViewModel.currentMonthIndex -= count
      print(hygieneCalendarViewModel.countLeft, hygieneCalendarViewModel.currentMonthIndex)
      monthView.btnLeft.setNeedsDisplay()
      }
    monthView.lblName.text = hygieneCalendarViewModel.monthsArr[currentUserCalendarOfHygieneEvents[hygieneCalendarViewModel.currentMonthIndex].month - 1]
    monthView.lblName.setNeedsDisplay()
    myCollectionView.reloadData()
  }
  
  private func setupViews() {
    view.addSubview(monthView)
    monthView.monthViewDelegate = self
    let margins = view.layoutMarginsGuide
    view.addSubview(weekdaysView)
    view.addSubview(myCollectionView)
    
    
    NSLayoutConstraint.activate([
      monthView.topAnchor.constraint(equalTo: margins.topAnchor),
      monthView.leftAnchor.constraint(equalTo: margins.leftAnchor),
//      monthView.heightAnchor.constraint(equalToConstant: 35),
      monthView.rightAnchor.constraint(equalTo: margins.rightAnchor),
      weekdaysView.topAnchor.constraint(equalTo: monthView.bottomAnchor, constant: 0),
      weekdaysView.leftAnchor.constraint(equalTo: margins.leftAnchor),
      weekdaysView.rightAnchor.constraint(equalTo: margins.rightAnchor),
//      weekdaysView.heightAnchor.constraint(equalToConstant: 25),
      myCollectionView.topAnchor.constraint(equalTo: weekdaysView.bottomAnchor, constant: 0),
      myCollectionView.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 0),
      myCollectionView.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 0),
      myCollectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
      ])
    
  }
  
  func notifyCVEventsToBeDeleted(dayOfEvent: Int, indexOfEvent: Int, dismissVC: Bool) {
    print("I am in protocol")
    print(viewModelMainView.currentUser.name)
    let adjDateOfEvent = currentUserCalendarOfHygieneEvents[hygieneCalendarViewModel.currentMonthIndex].indexOfFirstDayOfMonth + dayOfEvent - 1
    let dateOfEvent = currentUserCalendarOfHygieneEvents[hygieneCalendarViewModel.currentMonthIndex].days[adjDateOfEvent].1[indexOfEvent].date
    let _ = currentUserCalendarOfHygieneEvents[hygieneCalendarViewModel.currentMonthIndex].days[adjDateOfEvent].1.remove(at: indexOfEvent)
    let indexPathOfEvent = IndexPath(row: adjDateOfEvent, section: 0)
    viewModelMainView.deleteHygieneEvent(currentUser: viewModelMainView.currentUser, dateOfEvent: dateOfEvent)
    myCollectionView.reloadItems(at: [indexPathOfEvent])
    if dismissVC {
      dismiss(animated: true, completion: nil)
    }
  }
  
  @objc func insertNewHygieneEvent(_ notification: Notification) {
//    let user = notification.userInfo?["currentUser"] as? CalendarUsers
    guard let date = notification.userInfo?["eventDate"] as? Date else { return }
    guard let event = notification.userInfo?["eventType"] as? Int else { return }
//    print("In insertNewHygieneEvent", user?.name, date, event)
    currentUserCalendarOfHygieneEvents = hygieneCalendarViewModel.insertNewHygieneEventInHygieneData(hygieneCVEvents: currentUserCalendarOfHygieneEvents, date: date, eventType: event)
    myCollectionView.reloadData()
  }
  
  @objc func loadNewCalendarUser(_ notification: Notification) {
    print("In loadNewCalendarUser")
    let currentUser = notification.userInfo?["currentUser"] as! CalendarUsers
    viewModelMainView.userDefaultsStandard.set(currentUser.userID.uuidString, forKey: kCurrentCalendarUserID)
    viewModelMainView.currentUser = currentUser
    viewModelMainView.userDefaultsStandard.set(kDefaultUserID, forKey: currentUser.userID.uuidString)
    print(currentUser.name, viewModelMainView.currentUser.name)
    
    //Load new calendar user.
    if !currentUser.name.isEmpty {
    calendarUserHygieneEvents = viewModelMainView.getAllHygieneEventsByCalendarUser(calendarUser: currentUser, year: Calendar.current.component(.year, from: Date()))
    currentUserCalendarOfHygieneEvents = []
    currentUserCalendarOfHygieneEvents = hygieneCalendarViewModel.createHygieneCVDataModel(hygieneEvents: calendarUserHygieneEvents)
    myCollectionView.reloadData()
    
    }
  }
  
  @objc func presentDailyEventsTableView(_ notificaiton: Notification) {
    print("In presentDailyEventsTableView")
    let eventArray = notificaiton.userInfo?["eventArray"] as! [DailyHygieneEvents]
    let indexPath = notificaiton.userInfo?["indexPath"] as! IndexPath
    presentDailyHygieneEventTV(eventsArray: eventArray, indexPath: indexPath)
  }
  
}

extension CalendarCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    print(hygieneCalendarViewModel.currentMonthIndex, hygieneCalendarViewModel.currentYear)

    print(currentUserCalendarOfHygieneEvents[hygieneCalendarViewModel.currentMonthIndex].numberOfDaysInMonth + currentUserCalendarOfHygieneEvents[hygieneCalendarViewModel.currentMonthIndex].indexOfFirstDayOfMonth, hygieneCalendarViewModel.currentMonthIndex)
    return currentUserCalendarOfHygieneEvents[hygieneCalendarViewModel.currentMonthIndex].numberOfDaysInMonth + currentUserCalendarOfHygieneEvents[hygieneCalendarViewModel.currentMonthIndex].indexOfFirstDayOfMonth
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HygieneCalendarViewCellCollectionViewCell
    cell.backgroundColor = UIColor.cpCalendarBackground
    if indexPath.row <= currentUserCalendarOfHygieneEvents[hygieneCalendarViewModel.currentMonthIndex].indexOfFirstDayOfMonth - 1 {
      cell.isHidden = true
    } else {
      cell.isHidden = false
      cell.lbl.text = "\(currentUserCalendarOfHygieneEvents[hygieneCalendarViewModel.currentMonthIndex].days[indexPath.row].0)"
      cell.brushEvent = currentUserCalendarOfHygieneEvents[hygieneCalendarViewModel.currentMonthIndex].days[indexPath.row].1
      cell.isUserInteractionEnabled = true
      cell.lbl.textColor = Style.activeCellLblColor
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)
    
    let lbl = cell?.subviews[1] as! UILabel
    lbl.textColor = UIColor.cpSlate
    let events4TheDay = currentUserCalendarOfHygieneEvents[hygieneCalendarViewModel.currentMonthIndex].days[indexPath.row].1
    if !events4TheDay.isEmpty {
      print("I have events to display ", events4TheDay.count)
      presentDailyHygieneEventTV(eventsArray: events4TheDay, indexPath: indexPath)
    }
  }
  
  private func presentDailyHygieneEventTV(eventsArray: [DailyHygieneEvents], indexPath: IndexPath) {
    let eventsTableViewController = EventsByDayTableViewController()
    eventsTableViewController.hygieneCalendarViewModel = self.hygieneCalendarViewModel
    eventsTableViewController.monthLabel.text = DateHelpers.getDateFromDateComps(year: currentUserCalendarOfHygieneEvents[hygieneCalendarViewModel.currentMonthIndex].year, month: currentUserCalendarOfHygieneEvents[hygieneCalendarViewModel.currentMonthIndex].month, day: currentUserCalendarOfHygieneEvents[hygieneCalendarViewModel.currentMonthIndex].days[indexPath.row].0)
    eventsTableViewController.dailyHygieneEvents = eventsArray
    eventsTableViewController.dayOfEvent = currentUserCalendarOfHygieneEvents[hygieneCalendarViewModel.currentMonthIndex].days[indexPath.row].0
    eventsTableViewController.eventsToBeDeletedDelegate = self
    eventsTableViewController.modalPresentationStyle = .overCurrentContext
    present(eventsTableViewController, animated: true, completion: nil)
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)
    cell?.backgroundColor = UIColor.cpCalendarBackground
    let lbl = cell?.subviews[1] as! UILabel
    lbl.textColor = UIColor.cpSlate
  }
}

extension Date {
  func weekday(date: Date) -> Int {
    return Calendar.current.component(.weekday, from: date)
  }
  var firstDayOfTheMonth: Date {
    return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
  }
  
  func yearOfEvent(date: Date) -> Int {
    return Calendar.current.component(.year, from: date)
  }
}

extension String {
  static var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }()
  
  var date: Date? {
    return String.dateFormatter.date(from: self)
  }
  
}


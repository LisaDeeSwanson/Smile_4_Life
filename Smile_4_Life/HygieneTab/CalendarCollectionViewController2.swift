//
//  CalendarCollectionViewController.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 9/16/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit

enum MyTheme {
  case light
  case dark
}
//
//class CalendarCollectionViewController: UIViewController {
//  
//  
//  var theme = MyTheme.light
//  var viewModelMainView: ViewModelMainView!
//  var currentCalendarUser: CalendarUsers?
//  
//    override func viewDidLoad() {
//      
//      
//        super.viewDidLoad()
//      if theme == .dark {
//        Style.themeDark()
//      } else {
//        Style.themeLight()
//      }
//      
//      initializeView()
//      
//        self.view.backgroundColor = UIColor.cpSeaFoam
//      addSubviews()
//      #warning("BEGIN remove before ship")
//      let timeInterval = ((60.0 * 60.0) * 24.0) * 16.0
//      let novDate = Date(timeInterval: timeInterval, since: Date())
//      print(novDate)
//      let cal = Calendar.current
//      let weekday = cal.component(.weekday, from: novDate)
//      let fwd = cal.firstWeekday
//      let min = cal.minimumDaysInFirstWeek
//      let tz = cal.timeZone
//      print("In VIEWDIDLOAD calendar collection view")
//      
//      print(weekday, fwd, min, tz)
//      #warning("END remove before ship")
//    }
//
//  override func viewWillLayoutSubviews() {
//    super.viewWillLayoutSubviews()
//    calendarView.myCollectionView.collectionViewLayout.invalidateLayout()
//  }
//  
//  private func addSubviews() {
//    view.addSubview(calendarView)
//    NSLayoutConstraint.activate([calendarView.topAnchor.constraint(equalTo: view.topAnchor),
//                                 calendarView.rightAnchor.constraint(equalTo: view.rightAnchor),
//                                 calendarView.leftAnchor.constraint(equalTo: view.leftAnchor),
//                                 calendarView.heightAnchor.constraint(equalToConstant: 365)])
//
//  }
//  
//  @objc func changeCalendarViewTheme(notification: NotificationCenter) {
//    if theme == .dark {
//      //change color to opposit
//      theme = .light
//      Style.themeLight()
//    } else {
//      theme = .dark
//      Style.themeDark()
//    }
//    self.view.backgroundColor = Style.bgColor
//    calendarView.changeTheme()
//  }
//  
//  let calendarView: CalendarView = {
//    let cv = CalendarView(theme: MyTheme.dark)
//    cv.translatesAutoresizingMaskIntoConstraints = false
//    return cv
//  }()
//  
//}


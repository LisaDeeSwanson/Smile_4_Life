////
////  CalendarView1.swift
////  Smile_4_Life
////
////  Created by Lisa Swanson on 10/17/18.
////  Copyright © 2018 Technology Speaks. All rights reserved.
////
//
//
//
//import UIKit
//
//
//struct Colors {
//  static var darkGray = UIColor.darkGray
//  static var darkRed = UIColor.cpDarkRed
//}
//
//struct Style {
//  static var bgColor = UIColor.cpSlate
//  static var monthViewLblColor = UIColor.cpSlate
//  static var monthViewBtnRightColor = UIColor.cpSlate
//  static var monthViewBtnLeftColor = UIColor.cpSlate
//  static var activeCellLblColor = UIColor.cpSlate
//  static var activeCellLblColorHighlighted = UIColor.black
//  static var weekdaysLblColor = UIColor.cpSlate
//  
//  static func themeDark() {
//    bgColor = Colors.darkGray
//    monthViewLblColor = UIColor.cpSlate
//    monthViewBtnRightColor = UIColor.cpSlate
//    monthViewBtnLeftColor = UIColor.cpSlate
//    activeCellLblColor = UIColor.cpSlate
//    activeCellLblColorHighlighted = UIColor.black
//    weekdaysLblColor = UIColor.cpSlate
//  }
//  
//  static func themeLight() {
//    bgColor = UIColor.cpSlate
//    monthViewLblColor = UIColor.black
//    monthViewBtnRightColor = UIColor.black
//    monthViewBtnLeftColor = UIColor.black
//    activeCellLblColor = UIColor.black
//    activeCellLblColorHighlighted = UIColor.cpSlate
//    weekdaysLblColor = UIColor.black
//  }
//}
//
//class CalendarView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MonthViewDelegate {
//  
//  var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
//  var currentMonthIndex: Int = 0
//  var currentYear: Int = 0
//  var presentMonthIndex: Int = 0
//  var presentYear: Int = 0
//  var todaysDate = 0
//  var firstWeekdayOfMonth = 0
//  var numberOfWeeksInMonth: CGFloat = 0
//  var calendarUserHygieneEvents: [HygieneEvents] = []
//  
//  override init(frame: CGRect) {
//    super.init(frame: frame)
//    
//    initializeView()
//  }
//  
//  required init?(coder aDecoder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//  
//  convenience init(theme: MyTheme) {
//    self.init()
//    
//    if theme == .dark {
//      Style.themeDark()
//    } else {
//      Style.themeLight()
//    }
//    
//    initializeView()
//  }
//  
//  func changeTheme() {
//    myCollectionView.reloadData()
//    
//    monthView.lblName.textColor = Style.monthViewLblColor
//    monthView.btnRight.setTitleColor(Style.monthViewBtnRightColor, for: .normal)
//    monthView.btnLeft.setTitleColor(Style.monthViewBtnLeftColor, for: .normal)
//    
//    for i in 0..<7 {
//      (weekdaysView.myStackView.subviews[i] as! UILabel).textColor = Style.weekdaysLblColor
//    }
//  }
//  
//  private func initializeView() {
//    currentMonthIndex = Calendar.current.component(.month, from: Date())
//    currentYear = Calendar.current.component(.year, from: Date())
//    todaysDate = Calendar.current.component(.day, from: Date())
//    firstWeekdayOfMonth = getFirstWeekDay()
//    numberOfWeeksInMonth = getNumberOfWeeksInMonth(currentIndex: currentMonthIndex)
//    presentMonthIndex = currentMonthIndex
//    presentYear = currentYear
//    
//    setupViews()
//    
//    myCollectionView.delegate = self
//    myCollectionView.dataSource = self
//    myCollectionView.register(dateCVCell.self, forCellWithReuseIdentifier: "Cell")
//    
//  }
//  
//  private func getNumberOfWeeksInMonth(currentIndex: Int) -> CGFloat {
//    
//    let days = (firstWeekdayOfMonth - 1) + (numOfDaysInMonth[currentIndex])
//    let weeks = ceil(CGFloat((Double(days - 1)) / 7.0))
//    return CGFloat(weeks)
//  }
//  
//  private func getFirstWeekDay() -> Int {
//    
//    let stringToDate = "\(currentYear)-\(currentMonthIndex)-01".date!
//    let day = Calendar.current.component(.weekday, from: stringToDate)
//    return day
//  }
//  
//  func didChangeMonth(monthIndex: Int, year: Int) {
//    currentMonthIndex = monthIndex + 1
//    currentYear = year
//    print(currentMonthIndex, (monthIndex))
//    firstWeekdayOfMonth = getFirstWeekDay()
//    numberOfWeeksInMonth = getNumberOfWeeksInMonth(currentIndex: monthIndex)
//    myCollectionView.reloadData()
//    
//    monthView.btnLeft.isEnabled = !(currentMonthIndex == presentMonthIndex && currentYear == presentYear)
//  }
//  
//  private func setupViews() {
//    addSubview(monthView)
//    monthView.monthViewDelegate = self
//    addSubview(weekdaysView)
//    addSubview(myCollectionView)
//    
//    NSLayoutConstraint.activate([monthView.topAnchor.constraint(equalTo: topAnchor),
//                                 monthView.leftAnchor.constraint(equalTo: leftAnchor),
//                                 monthView.rightAnchor.constraint(equalTo: rightAnchor),
//                                 monthView.heightAnchor.constraint(equalToConstant: 35),
//                                 weekdaysView.topAnchor.constraint(equalTo: monthView.bottomAnchor),
//                                 weekdaysView.leftAnchor.constraint(equalTo: leftAnchor),
//                                 weekdaysView.rightAnchor.constraint(equalTo: rightAnchor),
//                                 weekdaysView.heightAnchor.constraint(equalToConstant: 30),
//                                 myCollectionView.topAnchor.constraint(equalTo: weekdaysView.bottomAnchor),
//                                 myCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
//                                 myCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
//                                 myCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)])
//    
//    
//  }
//  
//  
//  
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return numOfDaysInMonth[currentMonthIndex-1] + firstWeekdayOfMonth - 1
//  }
//  
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! dateCVCell
//    
//    cell.backgroundColor = UIColor.cpSunset
//    if indexPath.item <= firstWeekdayOfMonth - 2 {
//      cell.isHidden = true
//    } else {
//      let calcDate = indexPath.row - firstWeekdayOfMonth + 2
//      cell.isHidden = false
//      cell.lbl.text = "\(calcDate)"
//      if calcDate < todaysDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex {
//        cell.isUserInteractionEnabled = false
//        cell.lbl.textColor = Style.activeCellLblColor
//      } else {
//        cell.isUserInteractionEnabled = true
//        cell.lbl.textColor = Style.activeCellLblColor
//      }
//    }
//    return cell
//  }
//  
//  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    let cell = collectionView.cellForItem(at: indexPath)
//    cell?.backgroundColor = Colors.darkRed
//    let lbl = cell?.subviews[1] as! UILabel
//    lbl.textColor = UIColor.cpSlate
//  }
//  
//  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//    let cell = collectionView.cellForItem(at: indexPath)
//    cell?.backgroundColor = UIColor.cpSunset
//    let lbl = cell?.subviews[1] as! UILabel
//    lbl.textColor = UIColor.cpSlate
//  }
//  
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    let width = collectionView.frame.width / 7 - 2
//    let height = (collectionView.frame.height - 8) / numberOfWeeksInMonth
//    return CGSize(width: width, height: height)
//  }
//  
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//    return 2.0
//  }
//  
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//    return 2.0
//  }
//  
//  let monthView: MonthView = {
//    let view = MonthView()
//    view.translatesAutoresizingMaskIntoConstraints = false
//    return view
//  }()
//  
//  let weekdaysView: WeekdaysView = {
//    let view = WeekdaysView()
//    view.translatesAutoresizingMaskIntoConstraints = false
//    return view
//  }()
//  let myCollectionView: UICollectionView = {
//    let layout = UICollectionViewFlowLayout()
//    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    
//    let myCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
//    myCollectionView.showsHorizontalScrollIndicator = false
//    myCollectionView.translatesAutoresizingMaskIntoConstraints = false
//    myCollectionView.backgroundColor = UIColor.cpSeaFoam
//    myCollectionView.allowsMultipleSelection = false
//    return myCollectionView
//  }()
//}
//
//class dateCVCell: UICollectionViewCell {
//  override init(frame: CGRect) {
//    super.init(frame: frame)
//    backgroundColor = UIColor.clear
//    layer.cornerRadius = 5
//    layer.masksToBounds = true
//    
//    setupViews()
//  }
//  
//  private func setupViews() {
//    addSubview(lbl)
//    NSLayoutConstraint.activate([lbl.topAnchor.constraint(equalTo: topAnchor, constant: 2),
//                                 lbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 2),
//                                 lbl.heightAnchor.constraint(equalToConstant: 15),
//                                 lbl.widthAnchor.constraint(equalToConstant: 20)])
//  }
//  
//  let lbl: UILabel = {
//    let label = UILabel()
//    label.text = "00"
//    label.textAlignment = .left
//    label.font = .boldSystemFont(ofSize: 14)
//    label.textColor = Colors.darkGray
//    label.translatesAutoresizingMaskIntoConstraints = false
//    return label
//  }()
//  
//  required init?(coder aDecoder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//  
//}
//
//extension Date {
//  func weekday(date: Date) -> Int {
//    return Calendar.current.component(.weekday, from: date)
//  }
//  var firstDayOfTheMonth: Date {
//    return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
//  }
//  
//  func yearOfEvent(date: Date) -> Int {
//    print("In yearOfEvent")
//    //    guard let year = Calendar.current.dateComponents([.year], from: date).year else { return 0 }
//    //    print(year)
//    return Calendar.current.component(.year, from: date)
//  }
//  
//}
//
//extension String {
//  static var dateFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateFormat = "yyyy-MM-dd"
//    return formatter
//  }()
//  
//  var date: Date? {
//    return String.dateFormatter.date(from: self)
//  }
//  
//}
//
//

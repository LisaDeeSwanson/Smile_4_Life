//
//  FetchedCalendarUserResults.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 8/26/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class FetchedCalendarUserResults {
  
  var fetchedResults: NSFetchedResultsController<CalendarUsers>!
  var fetchResultsContext = CoreDataManager()
  
  func fetchCalendarUsers() -> NSFetchedResultsController<CalendarUsers>{
//    print("In fetchCalendarUsers")
   
    let calendarUserFetchRequest = NSFetchRequest<CalendarUsers>(entityName: "CalendarUsers")
    let calendarUserSort = NSSortDescriptor(key: #keyPath(CalendarUsers.name), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
    calendarUserFetchRequest.sortDescriptors = [calendarUserSort]
    let fetchedCalendarUserResults = NSFetchedResultsController(fetchRequest: calendarUserFetchRequest, managedObjectContext: fetchResultsContext.mainContext, sectionNameKeyPath: nil, cacheName: nil)
    
    do {
      try fetchedCalendarUserResults.performFetch()
      fetchedCalendarUserResults.delegate = self as? NSFetchedResultsControllerDelegate
    } catch let error as NSError {
      print("Could not fetch CalendarUsers. \(error), \(error.userInfo)")
    }
    return fetchedCalendarUserResults
  }
  
}



//class TestView: UITableView {
//  
//  func numberOfSections(in tableView: UITableView) -> Int {
//    return 1
//  }
//  override func numberOfRows(inSection section: Int) -> Int {
//    return 10
//  }
//  override func cellForRow(at indexPath: IndexPath) -> UITableViewCell? {
//    let cell = dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
//    cell.textLabel?.text = "TableviewCell"
//    return cell
//  }
//  
//  
//  
//  let testTableView: UITableView = {
//    let testview = UITableView()
//    testview.translatesAutoresizingMaskIntoConstraints = false
//    return testview
//  }()
//  
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    testTableView.delegate = self
//    testTableView.dataSource = self
//    testTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
//    testTableView.backgroundColor = .cpLogoBlue
//  }
//  
//  
//
//}


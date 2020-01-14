////
////  MainContainerTableViewController.swift
////  Smile_4_Life
////
////  Created by Lisa Swanson on 5/26/18.
////  Copyright © 2018 Technology Speaks. All rights reserved.
////
//
import UIKit
import CoreData

let cellID = "cellID"


class UserCalendarsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
  
  
  var viewModelMainView: ViewModelMainView?

  private var usersFetchRC: NSFetchedResultsController<CalendarUsers>!
  private let helpers = LocalModules()
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    print("User Calendars tableview Controller will appear")
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    print("User Calednars tableView Controller will disappear")
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      tableView.register(UserTableTableViewCell.self, forCellReuseIdentifier: cellID)
      usersFetchRC = viewModelMainView?.fetchCalendarUsers()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
//      guard let sections = usersFetchRC?.sections else {
//        fatalError("No sections in fetchedResultsController")
//      }
        return 1
      
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
      guard let userObjects = usersFetchRC.fetchedObjects else {
        return 0
      }
      print("^^^^^^^^^^^^^^^Number of Users in Core Date \(userObjects.count)")
      return userObjects.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! UserTableTableViewCell
      let userCalendar = usersFetchRC.object(at: indexPath)
      cell.backgroundColor = .cpPurpleGrey
      cell.baseImageView.image = UIImage(data: userCalendar.image!)
      cell.baseTextLabel.text = userCalendar.name
        // Configure the cell...

        return cell
    }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60.0
  }
  
  override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: handleDeleteUser)
    deleteAction.backgroundColor = .cpLightRed
    let editCurrentUser = UITableViewRowAction(style: .normal, title: "Edit", handler: handleEditUser)
    editCurrentUser.backgroundColor = .cpCalendarBackground
    
    return [deleteAction, editCurrentUser]
  }
  
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         Return false if you do not want the specified item to be editable.
        return true
    }
    */

  
////    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//          let user = usersFetchRC.object(at: indexPath)
//          print("in tableview delete \(user)")
//
//
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
  
  private func handleDeleteUser(action: UITableViewRowAction, index: IndexPath) {
    print("In handleDeleteUser")
    let calendarUser = usersFetchRC.object(at: index)
    print(calendarUser.name)
    let deleteAlert = UIAlertController(title: "Stop - Can not be undone.", message: "This will delete all stored hygiene events.", preferredStyle: .alert)
    deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    deleteAlert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (alert: UIAlertAction!) in
      self.deleteUserCalendar(user: calendarUser)
    }))
    present(deleteAlert, animated: true, completion: nil)

  }

  private func handleEditUser(action: UITableViewRowAction, index: IndexPath) {
    print("in handleEditUser")
    let user = usersFetchRC.object(at: index)
    let viewController = CreateNewCalendarUser()
    viewController.addUserImage.image = UIImage(data: user.image!)
    viewController.addUserName.text = user.name
    viewController.viewModelMainView = viewModelMainView
    let navCon = UINavigationController(rootViewController: viewController)
    navCon.navigationItem.title = "Edit User Calendar"
    present(navCon, animated: true)
  }
  
  @objc private func deleteUserCalendar(user: CalendarUsers) {
    print("in deleteUserCalendar")
//    viewModelMainView?.cascadeDeleteCalendarUser(user: user)
//    let coreDataContext = CoreDataManager.shared.persistentContainer.viewContext
    viewModelMainView?.cascadeDeleteCalendarUser(user: user)
//    coreDataContext.mainContext.delete(user)
//    do {
//      try coreDataContext.save()
//    } catch let saveErr {
//      print("Failed to delete company:", saveErr)
//    }
    
  }
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  
//  private func getUserDataForTableView() {
//    let request = Users.fetchRequest() as NSFetchRequest<Users>
//    let sort = NSSortDescriptor(keyPath: \Users.name, ascending: true)
//    request.sortDescriptors = [sort]
//    do {
//      usersFetchRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moContext, sectionNameKeyPath: nil, cacheName: nil)
//      try usersFetchRC.performFetch()
//      usersFetchRC.delegate = self
//
//    } catch let usersFetchError as NSError {
//      print("Could not fetch. \(usersFetchError), \(usersFetchError.userInfo).")
//    }
//  }
  
  
  
  var blockOperations = [BlockOperation]()

//  private func getUserData() {
//    let request = Users.fetchRequest() as NSFetchRequest<Users>
//    let sort = NSSortDescriptor(keyPath: \Users.name, ascending: true)
//    request.sortDescriptors = [sort]
//    do {
//      usersFetchRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moContext, sectionNameKeyPath: nil, cacheName: nil)
//      try usersFetchRC.performFetch()
//      usersFetchRC.delegate = self
//
//    } catch let usersFetchError as NSError {
//      print("Could not fetch. \(usersFetchError), \(usersFetchError.userInfo).")
//    }
//  }

}

extension UserCalendarsTableViewController {
  
//  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//    tableView?.performBatchUpdates({
//      print("in block opertion did change")
//      for operation in self.blockOperations {
//        operation.start()
//      }
//    }, completion: { (completed) in
//
//    })
//  }
//
//  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//    let index = indexPath ?? (newIndexPath ?? nil)
//    print("index in resultsController \(String(describing: index))")
//    guard let cellIndex = index else {
//      return
//    }
//
//    switch (type) {
//    case .insert:
//      blockOperations.append(BlockOperation(block: {
//        self.tableView?.insertRows(at: [cellIndex], with: .fade)
////        self.reloadInputViews()
//      }))
//    case .delete:
//      blockOperations.append(BlockOperation(block: {
//        self.tableView?.deleteRows(at: [cellIndex], with: .fade)
//      }))
//    default:
//      break
//    }
//  }
  
  //  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
  //    let index = ?? (newIndexPath ?? nil)
  //    guard let cellIndex = index else { return }
  //
  //    switch (type) {
  //    case .insert:
  //      tableView.insertRows(at: [cellIndex], with: UITableViewRowAnimation.middle)
  //    case .delete:
  //      tableView.deleteRows(at: [cellIndex], with: UITableViewRowAnimation.middle)
  //    default:
  //      break
  //    }
  //  }

      func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView .beginUpdates()
      }
  
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
      let set = IndexSet(integer: sectionIndex)
      switch (type) {
      case .insert:
        self.tableView.insertSections(set, with: UITableView.RowAnimation.middle)
      case .delete:
        self.tableView.deleteSections(set, with: UITableView.RowAnimation.bottom)
      default:
        break
      }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
      let index = indexPath ?? (newIndexPath ?? nil)
      guard let cellIndex = index else { return }

      switch (type) {
        case .insert:
          tableView.insertRows(at: [cellIndex], with: UITableView.RowAnimation.middle)
        case .delete:
          tableView.deleteRows(at: [cellIndex], with: UITableView.RowAnimation.middle)
        default:
          break
      }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
      self.tableView .endUpdates()
    }
  }



////
////  ContainerViewController.swift
////  Smile_4_Life
////
////  Created by Lisa Swanson on 5/27/18.
////  Copyright © 2018 Technology Speaks. All rights reserved.
////
//
//import UIKit
//import CoreData
//
//
//class ContainerViewController: UIViewController {
//
//  @IBOutlet weak var segmentedControl: UISegmentedControl!
//  private var navBarAddUser: UIBarButtonItem?
//  private var navBarTrash: UIBarButtonItem?
//  private var navBarCancel: UIBarButtonItem?
//  private var navBarAddHygieneEvent: UIBarButtonItem?
////  var userTableViewController: UserCalendarsTableViewController?
//  private var appDelegate = UIApplication.shared.delegate as! AppDelegate
//  private let moContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//  private var usersFetchRC: NSFetchedResultsController<Users>!
//  private let helpers = LocalModules()
//  private var addingHygieneEvent = false
//
//  private lazy var hygieneEventsCalendarController: HygieneEventsCalendarController = {
//    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//    
//    var viewController = storyboard.instantiateViewController(withIdentifier: "HygieneEventsCalendarController") as! HygieneEventsCalendarController
//    
//    self.add(asChildViewController: viewController)
//    
//    return viewController
//  }()
//  
//  private lazy var userCalendarsTableViewController: UserCalendarsTableViewController = {
//    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//    
//    var viewController = storyboard.instantiateViewController(withIdentifier: "UserCalendarsTableViewController") as! UserCalendarsTableViewController
//    
//    self.add(asChildViewController: viewController)
//    
//    return viewController
//  }()
//  
//  private lazy var addHygieneEventsViewController: AddHygieneEventsViewController = {
//    let storybard = UIStoryboard(name: "Main", bundle: Bundle.main)
//
//    var viewController = storybard.instantiateViewController(withIdentifier: "AddHygieneEventsViewController") as! AddHygieneEventsViewController
//
//    self.add(asChildViewController: viewController)
//
//    return viewController
//  }()
//  
//  override func viewDidLoad() {
//        super.viewDidLoad()
//      setupView()
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//  private func setupView() {
//    setupSegmentedControl()
//    addBarButtonItems()
//    updateView()
//  }
//  
//  private func addBarButtonItems() {
//    navBarAddUser = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addUser))
//    navBarCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAddHygieneEvent))
//    navBarAddHygieneEvent = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addHygieneEvent))
//    self.navigationItem.rightBarButtonItem = navBarAddUser
//  }
//  
//  @objc private func cancelAddHygieneEvent() {
//    addingHygieneEvent = false
//    self.navigationItem.rightBarButtonItem = navBarAddUser
//    updateView()
//  }
//  
//  @objc private func addUser() {
//    if segmentedControl.selectedSegmentIndex == 0 {
//      print("Hello")
//      addingHygieneEvent = true
//      self.navigationItem.leftBarButtonItem = navBarCancel
//      self.navigationItem.rightBarButtonItem = navBarAddHygieneEvent
//      updateView()
//    } else if segmentedControl.selectedSegmentIndex == 1 {
//      addUserAlert()
//    }
//  }
//  
//  @objc private func deleteUser() {
//    print("I am in deleteUser")
//  }
//  
//  private func setupSegmentedControl() {
//    segmentedControl.removeAllSegments()
//    segmentedControl.insertSegment(withTitle: "Calendar View", at: 0, animated: false)
//    segmentedControl.insertSegment(withTitle: "User Calendars", at: 1, animated: false)
//    segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
//    
//    segmentedControl.selectedSegmentIndex = 0
//  }
//  
//  @objc private func addHygieneEvent() {
//    print("let the saving begin")
//  }
//  
//  private func addUserAlert() {
//    print("in addUser func")
//    // The overall alert controller
//    let alert = UIAlertController(title: "Add a Person", message: "Name?", preferredStyle: .alert)
//    
//    // The Add button: adds a new person
//    let addAction = UIAlertAction(title: "Add", style: .default) { (action) -> Void in
//      
//      if let textField = alert.textFields?[0],
//        let text = textField.text, !text.isEmpty {
//        
//        if text.count <= 1 {
//          let alert = UIAlertController(title: "Error", message: "A person's name must be longer than a single character!", preferredStyle: .alert)
//          alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//          self.present(alert, animated: true, completion: nil)
//        } else {
//          print("Pass name to tableview \(text)")
//          self.userTableViewController?.addUserName = text
//          let calendarUser = Users(entity: Users.entity(), insertInto: self.moContext)
//          calendarUser.name = text
//          calendarUser.imageName = self.helpers.getRandomUserCalendarImage()
//          self.appDelegate.saveContext()
//          self.userTableViewController?.reloadInputViews()
//        }
//      }
//    }
//    // The Cancel button: does nothing
//    let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) -> Void in
//    }
//    // Need one text field in the alert
//    alert.addTextField(configurationHandler: nil)
//    
//    // Add the two buttons (add and cancel)
//    alert.addAction(addAction)
//    alert.addAction(cancelAction)
//    
//    // Present the alert controller
//    present(alert, animated: true, completion: nil)
//        
//  }
//  
//  @objc func selectionDidChange(_ sender: UISegmentedControl) {
//    updateView()
//  }
//  
//  fileprivate func add(asChildViewController viewController: UIViewController) {
//    addChildViewController(viewController)
//    view.addSubview(viewController.view)
//    viewController.view.frame = view.bounds
//    viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//    viewController.didMove(toParentViewController: self)
//  }
//  
//  private func remove(asChildViewController viewController: UIViewController) {
//    viewController.willMove(toParentViewController: nil)
//    viewController.view.removeFromSuperview()
//    viewController.removeFromParentViewController()
//  }
//  
//  private func updateView() {
//    if segmentedControl.selectedSegmentIndex == 0 && addingHygieneEvent {
//      remove(asChildViewController: hygieneEventsCalendarController)
//      add(asChildViewController: addHygieneEventsViewController)
//    } else if segmentedControl.selectedSegmentIndex == 0 {
//      remove(asChildViewController: userCalendarsTableViewController)
//      add(asChildViewController: hygieneEventsCalendarController)
//    } else {
//      self.navigationItem.leftBarButtonItem = nil
//      self.navigationItem.rightBarButtonItem = navBarAddUser
//      addingHygieneEvent = false
//      remove(asChildViewController: hygieneEventsCalendarController)
//      add(asChildViewController: userCalendarsTableViewController)
//    }
//  }
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}

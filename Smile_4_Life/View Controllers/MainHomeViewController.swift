//
//  MainHomeViewController.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 7/31/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit


class MainHomeViewController: UIViewController, PersistanceViewModelMain, PresentViewControllerFromMain, UpdateSegmentControlDelegate, HandleTapGesture {
  
  // Protocol stubs
  
  func addCustomHygieneEvent(eventType: Int, date: Date, tag: Int) {
    print("I am in protocol stub addCustomHygieneEvent  \((eventType, date, tag))")
    
    switch tag {
    case 0:
      addHygieneEvent(user: viewModelMainView.currentUser, date: date, eventType: eventType)
    case 1:
      print("I have made it to the correct case in protocol")
    default:
      print("Should not be defaulting")
    }
    
    
  }
  
  // end Protocol stubs
  
  
  var logoImageHeight: CGFloat = 0.0
  static let segmentCornerRadius: CGFloat = 6
  
  func notifiyMainControlerOfSegmentChange(indexOfSegment: Int) {
    print("In MainView protocol \(indexOfSegment)")
    let segmentIndex = UISegmentedControl()
    segmentIndex.removeAllSegments()
    segmentIndex.insertSegment(withTitle: "Calendar View", at: 0, animated: true)
    segmentIndex.insertSegment(withTitle: "User Calendars", at: 1, animated: true)
    segmentIndex.selectedSegmentIndex = indexOfSegment
    selectionDidChange(segmentIndex)
  }
  
  func presentViewController(index: Int) {
    print("in presentViewController")
    switch index {
    case 1:
      let customEventVC = TestNotificationsViewController()
      customEventVC.handleTapGestureDelegate = self
      customEventVC.viewModelMainView = viewModelMainView
      customEventVC.transitioningDelegate = self
//            presentCreateUserViewController(viewController: customEventVC)

      present(customEventVC, animated: true, completion: nil)
//      let viewController = NotificationsViewController()
////      viewController.viewModelMainView = viewModelMainView
//      presentCreateUserViewController(viewController: viewController)
      break
    case 4:
      let viewController = CreateNewCalendarUser()
      viewController.segmentDelegate = self
      viewController.viewModelMainView = viewModelMainView
      presentCreateUserViewController(viewController: viewController)
    default:
      break
    }
  }
  
  private func presentCreateUserViewController(viewController: UIViewController) {
    let navCon = UINavigationController(rootViewController: viewController)
    self.present(navCon, animated: true, completion: nil)
  }
  
  func set(stack: ViewModelMainView) {
    self.viewModelMainView = stack
    self.viewModelMainView.coreDataContext = CoreDataManager()
  }

  
  //  Set variables.###################################################################

  var viewModelMainView: ViewModelMainView!
//  var calendarUsersTableView: TestView?
  var setCurrentCalendarUser: CalendarUsers? {
    didSet {
      userNameLabel.text = setCurrentCalendarUser?.name
      userImageView.image = UIImage(data: (setCurrentCalendarUser?.image)!)
      setupUI()
    }
  }
  lazy var containerViewsArray = [calendarCollectionViewController, calendarUsersTableViewController, notificationViewController, timersViewController, settingsViewController]
  
//  let backgroundImageView: UIImageView = {
//    let imageView = UIImageView(image: #imageLiteral(resourceName: "smile_home.png"))
//    imageView.translatesAutoresizingMaskIntoConstraints = false
//    imageView.contentMode = .scaleToFill
//    return imageView
//  }()
  
  let logoImage: UIImageView = {
    let logo = UIImageView()
    logo.image = UIImage(imageLiteralResourceName: "smile_logo.png")
    logo.translatesAutoresizingMaskIntoConstraints = false
    logo.contentMode = .scaleToFill
    return logo
  }()

  lazy var userImageView: UIImageView = {
    var userPhotoFrame = UIImageView()
    userPhotoFrame.image = UIImage(named: "defaultProfile-76.png")
    userPhotoFrame = .setCircularImageOnTableviewCellStyle(image: userPhotoFrame, radius: 62.5)
    userPhotoFrame.translatesAutoresizingMaskIntoConstraints = false
    userPhotoFrame.contentMode = .scaleAspectFill
    userPhotoFrame.isUserInteractionEnabled = true
    userPhotoFrame.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
    return userPhotoFrame
  }()
  
  let userNameLabel: UILabel = {
    let nameLabel = UILabel()
    nameLabel.layer.cornerRadius = 5
    nameLabel.clipsToBounds = true
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.backgroundColor = .cpLabel
    nameLabel.textColor = .cpNewPop
    nameLabel.font = UIFont.boldSystemFont(ofSize: 50)
    nameLabel.text = "User Name"
    nameLabel.textAlignment = .center
    return nameLabel
  }()
  
  let addBrush: UIButton = {
    let brush = UIButton()
    brush.setImage(#imageLiteral(resourceName: "brushIcon"), for: .normal)
    brush.contentMode = .scaleAspectFit
    brush.tag = 1
    brush.addTarget(self, action: #selector(handleAddHygieneEvent), for: .touchUpInside)
    brush.translatesAutoresizingMaskIntoConstraints = false
    return brush
  }()
  
  let addFlossEvent: UIButton = {
    let floss = UIButton()
    floss.setImage(#imageLiteral(resourceName: "flossIcon"), for: .normal)
    floss.contentMode = .scaleAspectFit
    floss.tag = 2
    floss.addTarget(self, action: #selector(handleAddHygieneEvent), for: .touchUpInside)
    floss.translatesAutoresizingMaskIntoConstraints = false
    return floss
  }()
  
  let addBrushAndFlossEvent: UIButton = {
    let both = UIButton()
    both.setImage(#imageLiteral(resourceName: "brushFlossIcon"), for: .normal)
    both.contentMode = .scaleAspectFit
    both.tag = 3
    both.translatesAutoresizingMaskIntoConstraints = false
    both.addTarget(self, action: #selector(handleAddHygieneEvent), for: .touchUpInside)
    return both
  }()
  
  let addCustomHygieneEvent: UIButton = {
    let custom = UIButton()
    custom.tag = 4
    custom.setImage(#imageLiteral(resourceName: "calendarIcon"), for: .normal)
    custom.contentMode = .scaleAspectFit
    custom.translatesAutoresizingMaskIntoConstraints = false
    custom.addTarget(self, action: #selector(handleAddHygieneEvent), for: .touchUpInside)
    return custom
  }()
  
  
  let userStatsLabel: UILabel = {
    let userStats = UILabel()
    userStats.layer.cornerRadius = 5
    userStats.clipsToBounds = true
    userStats.translatesAutoresizingMaskIntoConstraints = false
    userStats.backgroundColor = .cpLightBlue2
    userStats.textColor = .cpSlate
    userStats.font = UIFont.boldSystemFont(ofSize: 18)
    userStats.text = "  Let's get brushing"
    return userStats
  }()
  
  lazy var containerViewSegmentedControl: UISegmentedControl = {
    var sc = UISegmentedControl()
////    let sc = UISegmentedControl.navBarSegmentControl
//    sc.removeAllSegments()
    sc = UISegmentedControl.navBarSegmentControl
//    sc.insertSegment(with: #imageLiteral(resourceName: "Calendar-Small"), at: 0, animated: true)
//    sc.insertSegment(with: #imageLiteral(resourceName: "peopleIcon"), at: 1, animated: true)
//    sc.insertSegment(with: #imageLiteral(resourceName: "Reminders-Small"), at: 2, animated: true)
//    sc.insertSegment(with: #imageLiteral(resourceName: "tabBarTimerIcon"), at: 3, animated: true)
//    sc.insertSegment(with: #imageLiteral(resourceName: "gear-Small.png"), at: 4, animated: true)
    sc.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
    let titleAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
//    sc.setTitleTextAttributes(titleAttributes, for: .normal)
//    sc.backgroundColor = .cpSunset
//    sc.tintColor = .cpSlate
//    sc.translatesAutoresizingMaskIntoConstraints = false
    return sc
  }()
  
  lazy var containerView: UIView = {
    let cv = UIView()
    cv.layer.cornerRadius = 5
    cv.layer.masksToBounds = true
    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.backgroundColor = .cpTealColor
    return cv
  }()
  
  private lazy var calendarUsersTableViewController: CalendarUserTableViewController = {
    let tableViewController = CalendarUserTableViewController()
    self.add(asChildViewController: tableViewController)
    return tableViewController
  }()
  
  private lazy var calendarCollectionViewController: CalendarCollectionViewController = {
    let collectionVC = CalendarCollectionViewController()
    self.add(asChildViewController: collectionVC)
    return collectionVC
  }()
  
  private lazy var settingsViewController: SettingsViewController = {
    let settingsViewController = SettingsViewController()
    self.add(asChildViewController: settingsViewController)
    return settingsViewController
  }()
  
  private lazy var notificationViewController: TestNotificationsViewController = {
    let notificationViewController = TestNotificationsViewController()
    self.add(asChildViewController: notificationViewController)
    return notificationViewController
  }()
 
  private lazy var timersViewController: TimersViewController = {
    let tvc = UIStoryboard(name: "Timers", bundle: nil).instantiateInitialViewController() as! TimersViewController
    self.add(asChildViewController: tvc)
    return tvc
  }()
  
  //  UI overrides.###################################################################
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("MainHomeMainHomeMainHomeMainHome viewWillAppear ")
    updateContainerView()

  }
  
   deinit {
    print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
    print("MainViewHomeController is deinitializing.")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if !viewModelMainView.userDefaultsStandard.bool(forKey: kInitialUser) {
      getInitialCalendarUserName()
    }
  }
  
  override func loadView() {
    super.loadView()
    setupUI()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print(view.bounds, view.frame)
    
    containerViewSegmentedControl.selectedSegmentIndex = segment.select
    lastSender = containerViewSegmentedControl
    validateCurrentUser()
    addNotificaitons()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    print("MainHomeMainHomeMainHomeMainHome viewWILLLayoutSubviews")
//    print("In setupUI \(containerView.frame.height, containerView.frame.width)")
//
//    print(addBrush.heightAnchor, addBrush.frame.height)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    print("MainHomeMainHomeMainHomeMainHome viewDIDLayoutSubviews")
    print(addBrush.frame.height, addBrush.frame.width)
  }
  
  //  Object functions.###################################################################
  
  @objc func selectionDidChange(_ sender: UISegmentedControl) {
    let isSameSender = sender === lastSender
    if !isSameSender {
      segment.select = sender.selectedSegmentIndex
      lastSender.selectedSegmentIndex = sender.selectedSegmentIndex
    } else {
      segment.select = sender.selectedSegmentIndex
      lastSender = sender
    }
    updateContainerView()
  }
  
  @objc func handleAddHygieneEvent(sender: UIButton) {
    print(viewModelMainView.currentUser.name)
    if sender.tag == 4 {
      print("I am in custom")
      let customEventVC = AddCustomEventViewController()
      customEventVC.handleTapGestureDelegate = self
      customEventVC.transitioningDelegate = self
      present(customEventVC, animated: true, completion: nil)
    } else {
      addHygieneEvent(user: viewModelMainView.currentUser, date: Date(), eventType: Int(sender.tag))
    }
  }
  
  private func addHygieneEvent(user: CalendarUsers, date: Date, eventType: Int) {
    viewModelMainView.addHygieneEvent(event: (owner: user, date: date, eventType: eventType))
    NotificationCenter.default.post(name: NSNotification.Name(kInsertNewHygieneEvent), object: self, userInfo: ["currentUser" : user as Any, "eventDate" : date, "eventType" : eventType])
  }
  
  func addNotificaitons() {
    NotificationCenter.default.addObserver(self, selector: #selector(notificationUpdateContainerView(_:)), name: NSNotification.Name(kNotifyParentMainViewUserHasChanged), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(updateUIWhenCurrentUserChanges(_:)), name: NSNotification.Name(kCalendarUserWillAddNewUserToTableViewNotificaiton), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(updateCurrentUser), name: Notification.Name(kCurrentUserHasChangedNotification), object: nil)
  }
  
  @objc func updateUIWhenCurrentUserChanges(_ notificaiton: Notification) {
    let userInfo = notificaiton.userInfo as! Dictionary<String, AnyObject>
    
    if let updateUser = userInfo["newUser"] as? CalendarUsers {
      setCurrentCalendarUser = updateUser
      viewModelMainView.userDefaultsStandard.set(updateUser.userID.uuidString, forKey: kCurrentCalendarUserID)
      
    }
  }

  @objc func updateCurrentUser() {
    validateCurrentUser()
  }
  
  @objc func notificationUpdateContainerView(_ notification: Notification) {
    print("In notificaiton center")
    let userInfo = notification.userInfo as! Dictionary<String, AnyObject>
    
    if let updateUser = userInfo[kCurrentCalendarUser] as? CalendarUsers {
      setCurrentCalendarUser = updateUser
      viewModelMainView.userDefaultsStandard.set(updateUser.userID.uuidString, forKey: kCurrentCalendarUserID)
      NotificationCenter.default.post(name: Notification.Name(kNotifyChildViewCalendarCVToLoadNewUser), object: self, userInfo: ["currentUser" : setCurrentCalendarUser as Any])
      segment.deSelect = 1
      segment.select = 0
      updateContainerView()
    }
  }
  
    private func addUserAlert() {
      print("in addUser func")
      // The overall alert controller
      let alert = UIAlertController(title: "I see you don't have a calendar.", message: "What would you like to name your first calendar?", preferredStyle: .alert)
      // The Add button: adds a new person
      let addAction = UIAlertAction(title: "Add", style: .default) { (action) -> Void in
  
        if let textField = alert.textFields?[0],
          let text = textField.text, !text.isEmpty {
  
          if text.count <= 1 {
            let alert = UIAlertController(title: "Error", message: "A person's name must be longer than a single character!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ -> Void in
              print("I am in OK")
              self.addUserAlert()
            }))
            self.present(alert, animated: true, completion: nil)
          } else {
            print("Pass name to tableview \(text)")
            self.setInitialUser(name: text)
          }
        }
      }
      alert.addTextField(configurationHandler: nil)
      alert.addAction(addAction)
      present(alert, animated: true, completion: nil)
    }
  
  private func setInitialUser(name: String) {
    self.viewModelMainView.userDefaultsStandard.set(name, forKey: kName)
    var initialUserArray = self.viewModelMainView.getInitialUser()
    guard let initialUser = initialUserArray.popLast() else { return }
    self.setCurrentCalendarUser = initialUser
    var notificationDict = [String : AnyObject]()
    notificationDict.updateValue(initialUser, forKey: "newUser")
    NotificationCenter.default.post(name: Notification.Name(kCalendarUserWillAddNewUserToTableViewNotificaiton), object: nil, userInfo: notificationDict)
  }
  
  private func getInitialCalendarUserName() {
    addUserAlert()
  }
  
  private func validateCurrentUser() {
    if var currentUserArray = viewModelMainView?.getCurrentUser() {
      print(currentUserArray.count)
      if currentUserArray.isEmpty {
        setCurrentCalendarUser?.name = "Default Name"
        setCurrentCalendarUser?.image = #imageLiteral(resourceName: "defaultProfile-Small.png").jpegData(compressionQuality: 100.0)
      } else {
        setCurrentCalendarUser = currentUserArray.popLast()
        viewModelMainView.currentUser = setCurrentCalendarUser
      }
    }
  }
  
  private func setupUI() {
    logoImageHeight = view.frame.height * 0.12
    view.backgroundColor = .cpBackground2
    
    view.addSubview(logoImage)
    logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
    logoImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    logoImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    logoImage.heightAnchor.constraint(equalToConstant: logoImageHeight).isActive = true
    
    view.addSubview(userImageView)
    userImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    userImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 125).isActive = true
    userImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 125).isActive = true
    userImageView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 8).isActive = true
    
    let stackView12 = UIStackView(arrangedSubviews: [addBrush, addFlossEvent, addBrushAndFlossEvent, addCustomHygieneEvent])
    stackView12.translatesAutoresizingMaskIntoConstraints = false
    stackView12.axis = .horizontal
    stackView12.distribution = .fillEqually
    stackView12.spacing = 3
    
    let stackView = UIStackView(arrangedSubviews: [userNameLabel, stackView12])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.spacing = 5
    
    let nestedStackView = UIStackView(arrangedSubviews: [stackView])
    nestedStackView.translatesAutoresizingMaskIntoConstraints = false
    nestedStackView.axis = .horizontal
    nestedStackView.distribution = .fillProportionally
    nestedStackView.spacing = 5
    view.addSubview(nestedStackView)
    
    NSLayoutConstraint.activate([
      nestedStackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 8),
      nestedStackView.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 5),
      nestedStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
      nestedStackView.heightAnchor.constraint(equalToConstant: 125)])
    
    view.addSubview(containerViewSegmentedControl)
    containerViewSegmentedControl.layer.cornerRadius = MainHomeViewController.segmentCornerRadius
    NSLayoutConstraint.activate([
      containerViewSegmentedControl.topAnchor.constraint(equalTo: nestedStackView.bottomAnchor, constant: 5),
      containerViewSegmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
      containerViewSegmentedControl.heightAnchor.constraint(equalToConstant: 45),
      containerViewSegmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15)])
    
    view.addSubview(containerView)
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: containerViewSegmentedControl.bottomAnchor, constant: 8),
      containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
      containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -55),
      containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15)])
    
  }
  
func updateContainerView() {
  print("updateContainerView: \((segment.deSelect, segment.select))")
  remove(asChildViewController: containerViewsArray[segment.deSelect])

  add(asChildViewController: containerViewsArray[segment.select])
  segment.deSelect = segment.select
}
  
private func add(asChildViewController viewController: UIViewController) {
  if let vc = viewController as? SettingsViewController {
    vc.viewModelMainView = viewModelMainView
    vc.presentDelegate = self
  } else if let vc = viewController as? CalendarCollectionViewController {
    print("*********************************\((containerView.frame.height, containerView.frame.width))")
    vc.viewModelMainView = viewModelMainView
    vc.currentCalendarUser = setCurrentCalendarUser
  } else if let vc = viewController as? CalendarUserTableViewController {
    vc.segmentDelegate = self
    vc.viewModelMainView = viewModelMainView
  } else if let vc = viewController as? TestNotificationsViewController {
    vc.segmentDelegate = self
    vc.viewModelMainView = viewModelMainView
  } else if let vc = viewController as? TimersViewController {
    vc.segmentDelegate = self
    vc.viewModelMainView = viewModelMainView
  }
  
  addChild(viewController)
  containerView.addSubview(viewController.view)
  viewController.view.frame = containerView.bounds
  viewController.didMove(toParent: self)
  }
  
private func remove(asChildViewController viewController: UIViewController) {
  viewController.willMove(toParent: nil)
  viewController.view.removeFromSuperview()
  viewController.removeFromParent()
  }
  
  @objc private func handleSelectPhoto() {
    print("I am in handleSelectPhoto")
    
  }
  
}

extension MainHomeViewController: UIViewControllerTransitioningDelegate {
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return FlipPresentAnimationController(originFrame: containerViewSegmentedControl.frame)
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    guard let _ = dismissed as? AddCustomEventViewController else {
      return nil
    }
    return FlipDismissAnimationController(destinationFrame: containerViewSegmentedControl.frame)
  }
}


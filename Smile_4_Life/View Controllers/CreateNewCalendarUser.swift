//
//  CreateNewCalendarUser.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 8/17/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit



class CreateNewCalendarUser: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  var viewModelMainView: ViewModelMainView?
//  lazy var createNewUser: CalendarUsers = {
//    return viewModelMainView?.currentUser
//    }()!
  var updateUser: CalendarUsers!
  var segmentDelegate: UpdateSegmentControlDelegate?
//  var updateCalendarUserTableviewDelegate: UpdateCalendarUsersTableview?
  var isEditingUser: Bool = false
  var imagePickerController: UIImagePickerController!
  
  let nameLabel: UILabel = {
    let name = UILabel()
    name.backgroundColor = .cpLightBlue2
    name.textColor = .white
    name.textAlignment = .center
    name.translatesAutoresizingMaskIntoConstraints = false
    name.text = "Name"
    return name
  }()
  
  var addUserName: UITextField = {
    let addUser = UITextField()
    addUser.translatesAutoresizingMaskIntoConstraints = false
    addUser.placeholder = "Enter name for calendar"
    addUser.backgroundColor = .cpSlate
    return addUser
  }()
  
  lazy var addUserImage: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "defaultProfile-76.png"))
    imageView.backgroundColor = .cpSlate
    imageView.layer.cornerRadius = 75
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.isUserInteractionEnabled = true
    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddUserPhoto)))
    
    return imageView
  }()
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("**************************************")
    print("In viewWillAppear")
    print(segment.deSelect)
    if segment.deSelect == 2 {
      navigationItem.title = "Create New Calendar"
    } else {
      navigationItem.title = "Edit \(addUserName.text ?? "User")"
    }
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    setupUI()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .cpLightBlue
    setupNavigationItems()
//    imagePickerController = UIImagePickerController()
//    imagePickerController.delegate = self
//    imagePickerController.sourceType = .photoLibrary
//    imagePickerController.allowsEditing = true
  }
  
  @objc func handleAddUserPhoto() {
    print("In handleAddUserPhoto")
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.sourceType = .photoLibrary
    imagePickerController.allowsEditing = true
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
      present(imagePickerController, animated: true, completion: nil)
    } else {
      print("Photo library is not available")
    }
  }
  
  @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
  
  @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

    if let editedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage {
      addUserImage.image = editedImage
    } else if let originalImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
      addUserImage.image = originalImage
    }

    dismiss(animated: true, completion: nil)
  }
  
  @objc func cancelAddUser() {
    dismiss(animated: true, completion: nil)
  }
  
  @objc func handelSaveNewUser() {
    var notificationCalendarUser: CalendarUsers?
    
    print("In handelSaveNewUser")
    let newImage = addUserImage.image!.jpegData(compressionQuality: 100.0)
    let newName = addUserName.text!
    if let _ = updateUser {
      print("in update")
      updateUser.image = newImage
      updateUser.name = newName
      viewModelMainView?.userDefaultsStandard.set(true, forKey: kEditUser)
      viewModelMainView?.updateCalendarUser(calendarUser: updateUser)
      notificationCalendarUser = updateUser
    } else {
      print("in create")
      let createNewUser = CalendarUsers(context: (viewModelMainView?.coreDataContext.mainContext)!)
      createNewUser.userID = UUID()
      createNewUser.name = newName
      createNewUser.image = newImage
      viewModelMainView?.createNewCalendarUser(calendarUser: createNewUser)
      notificationCalendarUser = createNewUser
      let userDict: [String : AnyObject] = [kCurrentCalendarUser : createNewUser]
      NotificationCenter.default.post(name: Notification.Name(kNotifyParentMainViewUserHasChanged), object: nil, userInfo: userDict)
    }

    self.segmentDelegate?.notifiyMainControlerOfSegmentChange(indexOfSegment: 1)
//    self.updateCalendarUserTableviewDelegate?.didAddNewCalendarUser(newUser: currentUser)
    guard let userUpdate = notificationCalendarUser else { return }
    var notificationDict = [String : AnyObject]()
    notificationDict.updateValue(userUpdate, forKey: "newUser")
    NotificationCenter.default.post(name: Notification.Name(kCalendarUserWillAddNewUserToTableViewNotificaiton), object: nil, userInfo: notificationDict)
    
    self.dismiss(animated: true) {
      print("In dismiss")
    }
    
  }
  
  private func setupNavigationItems() {
    let cancelBBI = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAddUser))
    let saveBBI = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handelSaveNewUser))
    navigationItem.setLeftBarButton(cancelBBI, animated: true)
    navigationItem.setRightBarButton(saveBBI, animated: true)
  }
  
  private func setupUI() {
    view.addSubview(addUserImage)
    view.addSubview(nameLabel)
    view.addSubview(addUserName)
    addUserName.clearButtonMode = .whileEditing
    NSLayoutConstraint.activate([
      addUserImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
      addUserImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      addUserImage.heightAnchor.constraint(equalToConstant: 150),
      addUserImage.widthAnchor.constraint(equalToConstant: 150),
      nameLabel.topAnchor.constraint(equalTo: addUserImage.bottomAnchor, constant: 8),
      nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
      nameLabel.widthAnchor.constraint(equalToConstant: 75),
      nameLabel.heightAnchor.constraint(equalToConstant: 50),
      addUserName.topAnchor.constraint(equalTo: addUserImage.bottomAnchor, constant: 8),
      addUserName.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 3),
      addUserName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
      addUserName.heightAnchor.constraint(equalToConstant: 50)])
  }
  
  
  
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}

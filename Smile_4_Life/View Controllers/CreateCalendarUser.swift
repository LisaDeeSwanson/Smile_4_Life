//
//  CreateCalendarUser.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 8/3/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit




class CreateCalendarUser: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

  var newCalendarUser: CalendarUsers? {
    didSet {
      if let imageData = newCalendarUser?.image {
        addUserImage.image = UIImage(data: imageData as Data)
      } else {
        addUserImage.image = UIImage(named: "defaultProfile-76.png")
      }
        newCalendarUser?.name = calendarUserTextField.text ?? "Default"
        newCalendarUser?.userID = UUID()
    }
  }
  var viewModelMainView: ViewModelMainView!
  var createCalendarUserDelegate: UpdateSegmentControlDelegate?
  
  lazy var addUserImage: UIImageView = {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "defaultProfile-76.png"))
    imageView.backgroundColor = .cpSlate
    imageView.layer.cornerRadius = 25
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.isUserInteractionEnabled = true
    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handelSelectPhoto)))
    return imageView
  }()
  
  @objc private func handelSelectPhoto() {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.allowsEditing = true
    if imagePickerController.allowsEditing {
      self.present(imagePickerController, animated: true, completion: nil)
    } else {
      print("Add alert to notify that image picker is not available")
    }
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

    if let editedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage {
      addUserImage.image = editedImage
    } else if let originalImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
      addUserImage.image = originalImage
    }
    
    if addUserImage.image != nil {
      newCalendarUser?.image = addUserImage.image!.jpegData(compressionQuality: 0.90)!
    }
    
    dismiss(animated: true, completion: nil)
  }
  
  let nameLabel: UILabel = {
    var userName = UILabel()
    userName.text = "Name"
    userName = .setStyleLogoBlueTheme(label: userName, fontSize: 18.0)
    userName.textAlignment = .center
    return userName
  }()
  
  let calendarUserTextField: UITextField = {
    var name = UITextField()
    name = .setTextFieldStyleLogoBlueTheme(textField: name, placeholder: "Enter for calendar.")
    return name
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationItems()
    print("In CreateCalendarUser viewDidLoad")

  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("In Create User Calendar: viewWillAppear")
    print(segment.deSelect, segment.select)
    setupUIViews()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    print("i am in viewWillLayoutSubviews")
//    setupUIViews()
  }
  
  private func setupNavigationItems() {
    navigationItem.title = "Create User Calendar"
    let cancelBBI = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAddUser))
    let saveBBI = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handelSaveNewUser))
    navigationItem.setLeftBarButton(cancelBBI, animated: true)
    navigationItem.setRightBarButton(saveBBI, animated: true)
  }
  
  @objc func handelSaveNewUser() {
    print("In handelSaveNewUser")
    segment.select = 1
    addUserToCoreData()
    dismiss(animated: true) {
      print("In handelSaveNewUser() dismiss closure")
      //*********Need to change this, it is creating a MainHomeViewController to fire the segmentController would like to get that knowledge of the MainViewController out of this VC.
      self.createCalendarUserDelegate?.notifiyMainControlerOfSegmentChange(indexOfSegment: 2)
      let segmentIndex = UISegmentedControl()
      segmentIndex.removeAllSegments()
      segmentIndex.insertSegment(withTitle: "Calendar View", at: 0, animated: true)
      segmentIndex.insertSegment(withTitle: "User Calendars", at: 1, animated: true)
      segmentIndex.selectedSegmentIndex = 1
      
      let mainViewController = MainHomeViewController()
      mainViewController.selectionDidChange(segmentIndex)
      //END of Need to change.
      
    }
  }
  
  func addUserToCoreData() {
    print("In add userCoreData")
    guard let newCalendarUser = newCalendarUser else { return }
    guard let newUserName = calendarUserTextField.text else { return }
    newCalendarUser.name = newUserName
    guard let image = addUserImage.image else { return }
    newCalendarUser.image = image.jpegData(compressionQuality: 0.80)!
    newCalendarUser.userID = UUID()
//    _ = viewModelMainView.addNewCalendarUser(calendarUser: newCalendarUser)
  }
  
  @objc func cancelAddUser() {
  
    dismiss(animated: true) {
      print("In cancelAddUser")
    }
    
  }
  
  internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
//    textField.setNeedsLayout()
    return true
  }
  
  private func setupUIViews() {
    print("In setupUIViews")
    view.backgroundColor = .cpLightBlue
    
    view.addSubview(addUserImage)
    view.addSubview(nameLabel)
    view.addSubview(calendarUserTextField)

    NSLayoutConstraint.activate([
    addUserImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
    addUserImage.heightAnchor.constraint(equalToConstant: 150),
    addUserImage.widthAnchor.constraint(equalToConstant: 125),
    addUserImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
  
    NSLayoutConstraint.activate([
    nameLabel.topAnchor.constraint(equalTo: addUserImage.bottomAnchor, constant: 8),
    nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
    nameLabel.widthAnchor.constraint(equalToConstant: 75),
    nameLabel.heightAnchor.constraint(equalToConstant: 50)])

    NSLayoutConstraint.activate([
    calendarUserTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor),
    calendarUserTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 5),
    calendarUserTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8),
    calendarUserTextField.heightAnchor.constraint(equalToConstant: 50)])
    
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

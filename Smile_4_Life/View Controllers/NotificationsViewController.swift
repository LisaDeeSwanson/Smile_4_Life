//
//  NotificationsViewController.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 1/5/19.
//  Copyright © 2019 Technology Speaks. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {
  
  let cellId = "NotificationTableViewCell"
  
  let myTableView: UITableView = {
    let tableView = UITableView(frame: CGRect.zero)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.separatorStyle = .none
    return tableView
  }()
  
  override func loadView() {
    super.loadView()
    setupViews()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    myTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    myTableView.dataSource = self
    myTableView.delegate = self
    myTableView.backgroundColor = .cpPurpleGrey
    
    setupNavigationItems()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.title = "Notification Settings"

  }

  private func setupViews() {
    view.backgroundColor = UIColor.cpLightBlue
    view.addSubview(myTableView)
    myTableView.layer.cornerRadius = 10
   
    
    NSLayoutConstraint.activate([
      myTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
      myTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
      myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
      myTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
      ])
  }
  
  private func setupNavigationItems() {
    let cancelBBI = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAddOrModifyNotifications))
    navigationItem.setLeftBarButton(cancelBBI, animated: true)
  }
  
  @objc func cancelAddOrModifyNotifications() {
    dismiss(animated: true, completion: nil)
  }
  
  
}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    
    return cell
  }
  
  
}



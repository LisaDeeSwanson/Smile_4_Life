//
//  CreateHygieneEvent.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 8/3/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit

class EventsByDayTableViewController: UIViewController {
  
//  var viewModelMainView: ViewModelMainView?
  var hygieneCalendarViewModel: HygieneCalendarViewModel!
  let cellId = "tableViewCell"
  var dailyHygieneEvents: [DailyHygieneEvents] = []
  var dayOfEvent: Int = 0
  var eventsToBeDeletedDelegate: NotifyCollViewEventsDeletedDelegate?
  
  let myContainerView: UIView = {
    let view = UIView(frame: CGRect.zero)
    view.layer.cornerRadius = 5
    view.layer.masksToBounds = true
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.cpPurpleGrey
    return view
  }()
  
  let monthLabel: UILabel = {
    var month = UILabel()
    month.translatesAutoresizingMaskIntoConstraints = false
    month.font = UIFont.boldSystemFont(ofSize: 18)
    month.layer.cornerRadius = 5
    month.layer.masksToBounds = true
    month.backgroundColor = UIColor.cpSlate
    month.textColor = .cpCalendarBackground
    month.text = " Month"
    return month
  }()
  
  let doneLabel: UILabel = {
    var label = UILabel()
    label = UILabel.addEffectsToLabel(label: label, fontSize: 20)
    label.text = "Done"
    label.textAlignment = .center
    label.isUserInteractionEnabled = true
    return label
  }()
  
  let myTableView: UITableView = {
    let tableView = UITableView(frame: CGRect.zero)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.backgroundColor = UIColor.cpPurpleGrey
    return tableView
  }()

  
  override func loadView() {
    super.loadView()
    
    setupViews()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    myTableView.dataSource = self
    myTableView.delegate = self
    myTableView.register(EventsByDayTableViewCell.self, forCellReuseIdentifier: cellId)

    view.backgroundColor = UIColor.cpCharcoalTrans
    navigationItem.title = "Add Hygiene Event"
    setupNavigationItems()
  }
  
  private func setupTableView() {
    
  }
  
  @objc func dismissEventsTableView(_ sender: UITapGestureRecognizer) {
    dismiss(animated: true, completion: nil)
  }
  
  private func setupViews() {
    view.addSubview(myContainerView)
    myContainerView.addSubview(doneLabel)
    doneLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EventsByDayTableViewController.dismissEventsTableView(_:))))
    myContainerView.addSubview(monthLabel)
    myContainerView.addSubview(myTableView)
    let margins = view.layoutMarginsGuide
    
    NSLayoutConstraint.activate([
      monthLabel.topAnchor.constraint(equalTo: myContainerView.topAnchor, constant: 2),
      monthLabel.leftAnchor.constraint(equalTo: myContainerView.leftAnchor),
      monthLabel.rightAnchor.constraint(equalTo: doneLabel.leftAnchor, constant: -5),
      monthLabel.heightAnchor.constraint(equalTo: doneLabel.heightAnchor),
      doneLabel.topAnchor.constraint(equalTo: myContainerView.topAnchor, constant: 2),
      doneLabel.heightAnchor.constraint(equalToConstant: 30),
      doneLabel.rightAnchor.constraint(equalTo: myContainerView.rightAnchor, constant: -3),
      doneLabel.widthAnchor.constraint(equalToConstant: 100),
      myTableView.topAnchor.constraint(equalTo: doneLabel.bottomAnchor, constant: 3),
      myTableView.leftAnchor.constraint(equalTo: myContainerView.leftAnchor),
      myTableView.rightAnchor.constraint(equalTo: myContainerView.rightAnchor),
      myTableView.bottomAnchor.constraint(equalTo: myContainerView.safeAreaLayoutGuide.bottomAnchor, constant: -2),
      myContainerView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 125),
      myContainerView.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 8),
      myContainerView.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: -8),
      myContainerView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -150)
    ])
    
  }
  
  private func setupNavigationItems() {
    let cancelBBI = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelCreateEvent))
    navigationItem.setLeftBarButton(cancelBBI, animated: true)
  }
  
  @objc func cancelCreateEvent() {    
    dismiss(animated: true) {
      print("In cancelAddUser completion handler")
    }
  }
  
}

extension EventsByDayTableViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dailyHygieneEvents.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EventsByDayTableViewCell
    cell.backgroundColor = .cpPurpleGrey
    cell.dailyHygieneEvent = dailyHygieneEvents[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 55
  }
  
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: handelDeleteUser)
    deleteAction.backgroundColor = .cpLightRed
    
    return [deleteAction]
  }
  
  private func handelDeleteUser(action: UITableViewRowAction, index: IndexPath) {
    print("In handelDeleteUser", dayOfEvent, index.row, hygieneCalendarViewModel.currentMonth, dailyHygieneEvents.count)
   
    let dismiss = dailyHygieneEvents.count == 1 ? true : false
    eventsToBeDeletedDelegate?.notifyCVEventsToBeDeleted(dayOfEvent: dayOfEvent, indexOfEvent: index.row, dismissVC: dismiss)
    dailyHygieneEvents.remove(at: index.row)
    myTableView.deleteRows(at: [index], with: .fade)

  }
  
}

extension UILabel {
  
  static func addEffectsToLabel(label: UILabel, fontSize: CGFloat) -> UILabel {
    label.layer.cornerRadius = 5
    label.layer.shadowColor = UIColor.cpCharcoal.cgColor
    label.layer.shadowRadius = 3
    label.layer.shadowOpacity = 1
    label.layer.shadowOffset = CGSize(width: 4, height: 3)
    label.layer.masksToBounds = false
    label.translatesAutoresizingMaskIntoConstraints = false
    label.backgroundColor = UIColor.cpCalendarBackground
    label.textColor = .cpSlate
    label.font = UIFont.boldSystemFont(ofSize: fontSize)
    return label
  }
  
}

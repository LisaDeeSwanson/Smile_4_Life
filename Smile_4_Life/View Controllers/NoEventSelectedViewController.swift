//
//  NoEventSelectedViewController.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 11/25/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit

class NoEventSelectedViewController: UIViewController {
  
  let myViews: NoEventSelectedAlertUIView = {
    let views = NoEventSelectedAlertUIView()
    views.translatesAutoresizingMaskIntoConstraints = false
    return views
  }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = UIColor.cpCharcoalTrans
    }
  
  override func loadView() {
    super.loadView()
    setupViews()
    
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    myViews.layer.cornerRadius = 20
    myViews.layer.masksToBounds = true
  }

  private func setupViews() {
    view.addSubview(myViews)
    myViews.okButton.addTarget(self, action: #selector(handleOkToDismiss), for: .touchUpInside)
    NSLayoutConstraint.activate([myViews.heightAnchor.constraint(equalToConstant: 152),
                                 myViews.widthAnchor.constraint(equalToConstant: 280),
                                myViews.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                myViews.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                                ])
    
  }
  
  @objc private func handleOkToDismiss() {
    print("In OK")
    dismiss(animated: true, completion: nil)
  }
  

}

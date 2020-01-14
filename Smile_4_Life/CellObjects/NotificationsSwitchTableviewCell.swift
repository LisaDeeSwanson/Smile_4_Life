//
//  NotificationsSwitchTableviewCell.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 2/2/19.
//  Copyright © 2019 Technology Speaks. All rights reserved.
//

import UIKit

class NotificationsSwitchTableviewCell: MinBaseTableViewCell<Any> {
  
  
  
  var background: ViewImageSwitch = {
    let view = ViewImageSwitch()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  
  override func setupGenericUI() {
    super.setupGenericUI()
    addSubview(background)
    
    
    NSLayoutConstraint.activate([
      background.topAnchor.constraint(equalTo: topAnchor, constant: 0),
      background.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
      background.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
      background.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
      ])
    
  }
  
  
}

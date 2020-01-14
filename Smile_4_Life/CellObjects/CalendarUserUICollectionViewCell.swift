//
//  CalendarUserUICollectionViewCell.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 3/11/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit

class CalendarUserUICollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var calendarUserName: UILabel!
  @IBOutlet weak var userImageView: UIImageView!
  @IBOutlet weak var editCircle: UIImageView!

  var isEditing: Bool = false {
    didSet {
      print(isEditing)
      editCircle.isHidden = !isEditing
    }
  }

  override var isSelected: Bool {
    didSet {
      if isEditing {
        editCircle.image = isSelected ? UIImage(named: "Checked") : UIImage(named: "Unchecked")
      }
    }
  }
  
}

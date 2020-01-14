//
//  UIColor+UIImageView+Themes.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 7/31/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit

extension UIColor {
  
  static let cpTealColor = UIColor(red: 48/255, green: 164/255, blue: 182/255, alpha: 1)
  static let cpLogoBlue = UIColor(red: 7/255, green: 52/255, blue: 119/255, alpha: 1)
  static let cpLightRed = UIColor(red: 247/255, green: 66/255, blue: 82/255, alpha: 1)
  static let cpBlueGreen = UIColor(red: 9/255, green: 45/255, blue: 64/255, alpha: 1)
  static let cpLightBlue  = UIColor(red: 218/255, green: 235/255, blue: 243/255, alpha: 1)
  static let cpSlate = UIColor(red: 234/255, green: 227/255, blue: 234/255, alpha: 1)
  static let cpSunset = UIColor(red: 152/255, green: 94/255, blue: 109/255, alpha: 1)
  static let cpMint = UIColor(red: 180/255, green: 219/255, blue: 192/255, alpha: 1)
  static let cpSeaFoam = UIColor(red: 167/255, green: 179/255, blue: 165/255, alpha: 1)
  static let cpCharcoal = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1)
  static let cpCharcoalTrans = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 0.50)
//  static let cpDarkRed = UIColor(red: 169/255, green: 24/255, blue: 24/255, alpha: 1)
  static let cpBackground = UIColor(red: 32/255, green: 21/255, blue: 44/255, alpha: 1)
//  static let cpCalendarBackground = UIColor(red: 99/255, green: 62/255, blue: 90/255, alpha: 1)
  
  // background only
  static let cpBackground2 = UIColor(red: 81/255, green: 96/255, blue: 103/255, alpha: 1)
   // only Container View BG and UISegmented Control Background
//  static let cpPurpleGrey = UIColor(red: 117/255, green: 138/255, blue: 148/255, alpha: 1)
  // to play with
  static let cpPurpleGrey = UIColor(red: 81/255, green: 96/255, blue: 103/255, alpha: 1)

  static let cpNewPop1 = UIColor(red: 245/255, green: 206/255, blue: 187/255, alpha: 1)
  static let cpNewPop = UIColor(red: 241/255, green: 243/255, blue: 244/255, alpha: 1)
  
  // label; outter cell background; Calendar Users tableview BG; Buttons on Notification View
//  static let cpCalendarBackground = UIColor(red: 81/255, green: 96/255, blue: 103/255, alpha: 1)
  static let cpCalendarBackground = UIColor(red: 117/255, green: 138/255, blue: 148/255, alpha: 1)
  static let cpLabel = UIColor(red: 81/255, green: 96/255, blue: 103/255, alpha: 1)
  static let cpUISegment = UIColor(red: 117/255, green: 138/255, blue: 148/255, alpha: 1)

  
//  static let cpSunset2 = UIColor(red: 81/255, green: 96/255, blue: 103/255, alpha: 1)
//  static let cpSunset1 = UIColor(red: 81/255, green: 96/255, blue: 103/255, alpha: 1)

//  static let cpBackground2 = UIColor(red: 78/255, green: 78/255, blue: 114/255, alpha: 1)
//  static let cpPurpleGrey = UIColor(red: 200/255, green: 195/255, blue: 229/255, alpha: 1)
  static let cpLightBlue1 = UIColor(red: 177/255, green: 222/255, blue: 249/255, alpha: 1)
//  static let cpSunset1 = UIColor(red: 255/255, green: 182/255, blue: 104/255, alpha: 1)
//  static let cpLightRed1 = UIColor(red: 255/255, green: 135/255, blue: 135/255, alpha: 1)
//  static let cpPink1 = UIColor(red: 203/255, green: 149/255, blue: 170/255, alpha: 1)
  static let cpSunset2 = UIColor(red: 253/255, green: 174/255, blue: 85/255, alpha: 1)
  static let cpLightBlue2 = UIColor(red: 101/255, green: 140/255, blue: 200/255, alpha: 1)
  
}

extension UITextField {
  static func setTextFieldStyleLogoBlueTheme(textField: UITextField, placeholder: String) -> UITextField {
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.textColor = .cpCharcoal
    textField.backgroundColor = .cpSlate
    textField.font = UIFont.boldSystemFont(ofSize: 18)
    textField.placeholder = placeholder
    textField.keyboardAppearance = .dark
    return textField
  } 
  
}

extension UIStackView {
  
  static func stackView01() -> UIStackView{
    let stack = UIStackView()
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.layer.cornerRadius = 10
    stack.layer.masksToBounds = true
    stack.axis = .vertical
    stack.spacing = 2
    stack.backgroundColor = UIColor.cpSlate
    stack.distribution = .fillProportionally
    return stack
  }
}

extension UILabel {
  
  static func setStyleLogoBlueTheme(label: UILabel, fontSize: CGFloat) -> UILabel {
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .cpSlate
    label.backgroundColor = .cpLabel
    label.layer.cornerRadius = 10.0
    label.layer.masksToBounds = true
    label.font = UIFont.boldSystemFont(ofSize: fontSize)
    label.shadowColor = .cpCharcoal
    label.shadowOffset = CGSize(width: 1.0, height: 2.0)
    return label
  }
  
  static func setStyleLightTheme(label: UILabel, fontSize: CGFloat) -> UILabel {
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .cpCharcoal
    label.backgroundColor = .cpNewPop
    label.font = UIFont.boldSystemFont(ofSize: fontSize)
    label.shadowColor = .cpSlate
    label.shadowOffset = CGSize(width: 1.0, height: 2.0)
    return label
  }
  
}

extension UIImageView {
  
  static func setCircularImageStyle(image: UIImageView) -> UIImageView {
    image.layer.cornerRadius = image.frame.width / 2
    image.layer.borderColor = UIColor.darkGray.cgColor
    image.layer.shadowColor = UIColor.darkGray.cgColor
    image.layer.borderWidth = 2
    image.clipsToBounds = true
    return image
  }
  
  static func setCircularImageOnTableviewCellStyle(image: UIImageView, radius: CGFloat) -> UIImageView {
    image.layer.cornerRadius = radius
    image.layer.borderColor = UIColor.darkGray.cgColor
    image.layer.borderWidth = 1
    image.clipsToBounds = true
    return image
  }
  
}

extension UISwitch {
  
  static func createSunsetUISwitch() -> UISwitch {
    let toggle = UISwitch()
    toggle.isOn = false
    toggle.onTintColor = UIColor.cpCalendarBackground
    return toggle
  }
}

extension UIView {
  func anchor(top: NSLayoutYAxisAnchor?, topPadding: CGFloat, left: NSLayoutXAxisAnchor?, leftPadding: CGFloat, bottom: NSLayoutYAxisAnchor?, bottomPadding: CGFloat, right: NSLayoutXAxisAnchor?, rightPaddding: CGFloat) {
    
    if let top = top {
      topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
    }
    if let left = left {
      leftAnchor.constraint(equalTo: left, constant: leftPadding).isActive = true
    }
    if let bottom = bottom {
      bottomAnchor.constraint(equalTo: bottom, constant: bottomPadding).isActive = true
    }
    if let right = right {
      rightAnchor.constraint(equalTo: right, constant: rightPaddding).isActive = true
    }
  }
  
}

//
//  ViewImageSwitch.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 2/2/19.
//  Copyright © 2019 Technology Speaks. All rights reserved.
//

import UIKit

class ViewImageSwitch: UIView {
  
  let backgroundView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .clear
    return view
  }()
  
  var baseImageView: UIImageView = {
    var image = UIImageView(image:  #imageLiteral(resourceName: "brushIconNoPlus"))
    image.translatesAutoresizingMaskIntoConstraints = false
    image.backgroundColor = .clear
    //    image = .setCircularImageStyle(image: image)
    image = .setCircularImageOnTableviewCellStyle(image: image, radius: 25)
    return image
  }()
  
  var baseTextLabel: UILabel = {
    var text = UILabel()
    text.text = " Hello Default Here"
    text = .setStyleLightTheme(label: text, fontSize: 16.0)
    return text
  }()
  
  let toggleSwitch: UISwitch = {
    let tS = UISwitch()
    tS.translatesAutoresizingMaskIntoConstraints = false
    tS.tintColor = .cpCalendarBackground
    tS.thumbTintColor = .cpCalendarBackground
    tS.onTintColor = .cpPurpleGrey
    tS.layer.shadowOffset = CGSize(width: 2, height: 2)
    tS.layer.shadowColor = UIColor.cpCharcoal.cgColor
    
    return tS
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  private func setupUI() {
    addSubview(backgroundView)
    backgroundView.addSubview(baseImageView)
    backgroundView.addSubview(baseTextLabel)
    backgroundView.addSubview(toggleSwitch)
    print("******************",backgroundView.frame.height)
    
    NSLayoutConstraint.activate([
      backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
      backgroundView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
      backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
      backgroundView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
      
      baseImageView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 2),
      baseImageView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 4),
      baseImageView.bottomAnchor.constraint(equalTo:backgroundView.bottomAnchor, constant: -2),
      baseImageView.widthAnchor.constraint(equalToConstant: 56),
      //      baseImageView.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: 2),
      
      baseTextLabel.topAnchor.constraint(equalTo: baseImageView.topAnchor, constant: 2),
      baseTextLabel.leftAnchor.constraint(equalTo: baseImageView.rightAnchor, constant: 2),
      baseTextLabel.bottomAnchor.constraint(equalTo:baseImageView.bottomAnchor, constant: -2),
      baseTextLabel.rightAnchor.constraint(equalTo: toggleSwitch.leftAnchor, constant: -2),
      
      toggleSwitch.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 15),
      toggleSwitch.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -4),
      toggleSwitch.bottomAnchor.constraint(equalTo:backgroundView.bottomAnchor, constant: -2),
      toggleSwitch.widthAnchor.constraint(equalToConstant: 50)
      ])
    
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


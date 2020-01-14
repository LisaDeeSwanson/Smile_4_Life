//
//  addBrushButton.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 11/12/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit

class AddBrushButton: UIButton {

  var isOn: Bool = true
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initButton()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    fatalError("init(coder:) has not been implemented")
  }
  
  private func initButton() {
    translatesAutoresizingMaskIntoConstraints = false
    contentMode = .scaleAspectFit
//    layer.borderWidth = 2
//    layer.borderColor = UIColor.cpSlate.cgColor
//    layer.cornerRadius = 8
    addTarget(self, action: #selector(AddBrushButton.buttonPressed), for: .touchUpInside)
  }
  
  @objc private func buttonPressed() {
    activateButton(bool: !isOn)
  }
  
  private func activateButton(bool: Bool) {
    isOn = bool
    let image = bool ? #imageLiteral(resourceName: "brushIconNoPlus") : #imageLiteral(resourceName: "brushIconNoPlusHL")
    
    setImage(image, for: .normal)
  }
}



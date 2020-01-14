//
//  CollectionViewEditCircleWithCheckMark.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 3/10/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit
import Foundation

class CollectionViewEditCircleCheckmark: UIView {
  
  
  // Only override draw() if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func draw(_ rect: CGRect) {
    
    let checkMark = UIBezierPath()
    checkMark.move(to: CGPoint(x: 7, y: 14))
    checkMark.addLine(to: CGPoint(x: 11, y: 20))
    checkMark.addLine(to: CGPoint(x: 20, y: 7))
    UIColor.gray.setStroke()
    checkMark.lineWidth = 2
    checkMark.stroke()
    
  }
  
  
}

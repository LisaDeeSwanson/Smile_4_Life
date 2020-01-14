//
//  CollectionViewEditCircle.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 3/10/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit
import Foundation

class CollectionViewEditCircle: UIView {
  
  var circleRadius: CGFloat {
    return min(bounds.size.width, bounds.size.height) / 2 * scale
  }
  var circleCenter: CGPoint {
    return CGPoint(x: bounds.midX, y: bounds.midY)
  }
  var scale: CGFloat = 0.90
  
  override func draw(_ rect: CGRect) {
    
    let circle = UIBezierPath(arcCenter: circleCenter, radius: circleRadius, startAngle: 0.0, endAngle: CGFloat(2*CGFloat.pi), clockwise: true)
    circle.lineWidth = 2
    UIColor.lightGray.set()
    circle.stroke()
    
    
  }
  
}

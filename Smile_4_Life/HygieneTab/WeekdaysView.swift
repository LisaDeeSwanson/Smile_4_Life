//
//  WeekdaysView.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 9/15/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit

class WeekdaysView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clear
    
    setupViews()
  }
  
  let myStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .fillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  private func setupViews() {
    addSubview(myStackView)
    
    NSLayoutConstraint.activate([myStackView.topAnchor.constraint(equalTo: topAnchor),
                                myStackView.leftAnchor.constraint(equalTo: leftAnchor),
                                myStackView.rightAnchor.constraint(equalTo: rightAnchor),
                                myStackView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    
    let daysArr = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
    daysArr.forEach { (day) in
      let lbl = UILabel()
      lbl.text = day
      lbl.textAlignment = .center
      lbl.font = UIFont.boldSystemFont(ofSize: 13)
      lbl.textColor = Style.weekdaysLblColor
      myStackView.addArrangedSubview(lbl)
      
    }
    
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not be implemented")
  }
  
  

}

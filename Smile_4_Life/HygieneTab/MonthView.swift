//
//  MonthView.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 9/15/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit

protocol MonthViewDelegate: class  {
  func didChangeMonth(sender: UIButton)
}

class MonthView: UIView {


  var monthsArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  var currentMonthIndex = 0
  var currentYear = 0
  var monthViewDelegate: MonthViewDelegate?

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clear
    
    currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
    currentYear = Calendar.current.component(.year, from: Date())
    
    setupViews()
    btnRight.isEnabled = false
    btnLeft.isEnabled = false
  }
  
  let lblName: UILabel = {
    let lbl = UILabel(frame: .zero)
    lbl.text = "Default Month Year Text"
    lbl.textColor = Style.monthViewLblColor
    lbl.textAlignment = .center
    lbl.font = UIFont.boldSystemFont(ofSize: 14)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
  }()
  
  let btnRight: UIButton = {
    let btn = UIButton(frame: .zero)
    btn.setTitle(">", for: .normal)
    btn.setTitleColor(Style.monthViewBtnRightColor, for: .normal)
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.addTarget(self, action: #selector(btnLeftRightAction(sender:)), for: .touchUpInside)
    btn.isEnabled = true
    return btn
  }()
  
  let btnLeft: UIButton = {
    let btn = UIButton(frame: .zero)
    btn.setTitle("<", for: .normal)
    btn.setTitleColor(Style.monthViewBtnLeftColor, for: .normal)
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.addTarget(self, action: #selector(btnLeftRightAction(sender:)), for: .touchUpInside)
    btn.setTitleColor(UIColor.lightGray, for: .disabled)
    btn.isEnabled = true
    return btn
  }()
  
  @objc func btnLeftRightAction(sender: UIButton) {
    monthViewDelegate?.didChangeMonth(sender: sender)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    lblName.text = "\(monthsArr[currentMonthIndex]) \(currentYear)"
    print(currentMonthIndex)
    self.addSubview(lblName)
    self.addSubview(btnRight)
    self.addSubview(btnLeft)
    
    NSLayoutConstraint.activate([
       lblName.topAnchor.constraint(equalTo: topAnchor),
       lblName.centerXAnchor.constraint(equalTo: centerXAnchor),
       lblName.widthAnchor.constraint(equalToConstant: 150),
       lblName.bottomAnchor.constraint(equalTo: bottomAnchor),
       
       btnRight.topAnchor.constraint(equalTo: lblName.topAnchor),
       btnRight.rightAnchor.constraint(equalTo: rightAnchor),
       btnRight.bottomAnchor.constraint(equalTo: lblName.bottomAnchor),
       
       btnLeft.topAnchor.constraint(equalTo: lblName.topAnchor),
       btnLeft.bottomAnchor.constraint(equalTo: lblName.bottomAnchor),
       btnLeft.leftAnchor.constraint(equalTo: leftAnchor)
    ])
    
  }
  
  
}

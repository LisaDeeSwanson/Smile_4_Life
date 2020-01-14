//
//  EventLabelViews.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 11/9/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit



class EventLabelViews: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clear
    
    setupViews()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var delegateHandleTapGesture: HandleTapGesture?
  
//  let addBrush: UIButton = {
//    let brush = UIButton()
//    brush.setImage(#imageLiteral(resourceName: "brushIcon"), for: .normal)
//    brush.tag = 1
//    brush.layer.cornerRadius = 10
//    brush.layer.borderColor = UIColor.cpSunset.cgColor
//    brush.layer.borderWidth = 1.0
//    brush.addTarget(self, action: #selector(notifyMainVCOfTapGesture), for: .touchUpInside)
//    brush.translatesAutoresizingMaskIntoConstraints = false
//    return brush
//  }()
  
//  let addFlossEvent: UIButton = {
//    let floss = UIButton()
////    floss.setImage(#imageLiteral(resourceName: "flossIcon"), for: .normal)
//    floss.setBackgroundImage(#imageLiteral(resourceName: "flossIcon"), for: .normal)
//    floss.tag = 2
//    floss.layer.cornerRadius = 10
//    floss.layer.borderColor = UIColor.cpSunset.cgColor
//    floss.layer.borderWidth = 1.0
//    floss.clipsToBounds = true
//    floss.addTarget(self, action: #selector(notifyMainVCOfTapGesture), for: .touchUpInside)
//    floss.translatesAutoresizingMaskIntoConstraints = false
//    return floss
//  }()
  
//  let addBrushAndFlossEvent: UIButton = {
//    var both = UIButton()
//    both.setImage(#imageLiteral(resourceName: "brushFlossIcon"), for: .normal)
//    both.layer.cornerRadius = 20
//    both.layer.masksToBounds = true
//    both.layer.borderColor = UIColor.cpSunset.cgColor
//    both.layer.borderWidth = 1.0
//    both.tag = 3
//    both.translatesAutoresizingMaskIntoConstraints = false
//    both.addTarget(self, action: #selector(notifyMainVCOfTapGesture), for: .touchUpInside)
//    return both
//  }()
  var addBrushEvent: AddBrushButton = {
    var brush = AddBrushButton()
    brush.setImage(#imageLiteral(resourceName: "brushIconNoPlus"), for: .normal)
    brush.tag = 1
    return brush
  }()
  
  var addFlossEvent: AddFlossButton = {
    var floss = AddFlossButton()
    floss.setImage(#imageLiteral(resourceName: "flossIconNoPlus"), for: .normal)
    floss.tag = 2
    return floss
  }()
  
  var addBrushFlossEvent: AddBushFlossButton = {
    var both = AddBushFlossButton()
    both.setImage(#imageLiteral(resourceName: "brushFlossIconNoPlus"), for: .normal)
    both.tag = 3
    return both
  }()
  
  
  let myStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 2
    stackView.distribution = .fillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  private func setupViews() {
    addSubview(myStackView)

    myStackView.addArrangedSubview(addBrushEvent)
    myStackView.addArrangedSubview(addFlossEvent)
    myStackView.addArrangedSubview(addBrushFlossEvent)

    
    NSLayoutConstraint.activate([myStackView.topAnchor.constraint(equalTo: topAnchor),
                                 myStackView.leftAnchor.constraint(equalTo: leftAnchor),
                                 myStackView.rightAnchor.constraint(equalTo: rightAnchor),
                                 myStackView.heightAnchor.constraint(equalToConstant: 100)])
    
    
  }
  
}


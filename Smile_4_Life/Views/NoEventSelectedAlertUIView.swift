//
//  NoEventSelectedAlert.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 11/25/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit

class NoEventSelectedAlertUIView: UIView {

  let alertLabel: UILabel = {
    let label = UILabel()
    label.backgroundColor = UIColor.cpCharcoal
    label.textColor = UIColor.cpSlate
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.text = "Select at least one event, by tapping the image, before saving."
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let okButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = UIColor.cpCharcoal
    button.setTitleColor(UIColor.cpSlate, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    let attribs = NSAttributedString.init(string: "Ok", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.cpSlate])
    button.setAttributedTitle(attribs, for: .normal)
    return button
  }()
  

  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.cpSlate
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  

  
  private func setupViews() {
    addSubview(alertLabel)
    addSubview(okButton)

    NSLayoutConstraint.activate([alertLabel.heightAnchor.constraint(equalToConstant: 100),
                                 alertLabel.widthAnchor.constraint(equalToConstant: 280),
                                 alertLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                                 alertLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                                 okButton.topAnchor.constraint(equalTo: alertLabel.bottomAnchor, constant: 2),
                                 okButton.centerXAnchor.constraint(equalTo: alertLabel.centerXAnchor),
                                 okButton.widthAnchor.constraint(equalToConstant: 280),
                                 okButton.heightAnchor.constraint(equalToConstant: 50)])
    
//    addSubview(stackView01)
//    stackView01.addArrangedSubview(alertLabel)
//    stackView01.addArrangedSubview(okButton)
//
//    NSLayoutConstraint.activate([stackView01.heightAnchor.constraint(equalToConstant: 202),
//                                 stackView01.widthAnchor.constraint(equalToConstant: 280),
//                                 stackView01.topAnchor.constraint(equalTo: topAnchor),
//                                 stackView01.centerXAnchor.constraint(equalTo: centerXAnchor)])
    
  }

}

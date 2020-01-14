//
//  HygieneEventCollectionViewCell.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 3/26/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit

class HygieneEventCollectionViewCell: UICollectionViewCell {
  
  let cellId = "hygienCell"
  var hygieneConstraints: [NSLayoutConstraint] = []
  var brushEvent: [String]? {
    didSet {
      guard let events = brushEvent else { return }
      addHygieneImageConstraint(arrayOfEvents: events)
    }
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.clear
    layer.cornerRadius = 5
    layer.masksToBounds = true
    //    hygieneCellCollectionView.collectionViewLayout.invalidateLayout()
    
    setupViews()
    
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    lbl.text = ""
    
  }
  
  private func addHygieneImageConstraint(arrayOfEvents: [String]) {
    let topAnchorConstraint = lbl
    var previousLbl = brushEventLbl
    let arrayOfHygieneLabels = getHygieneLabelArray(hygieneArray: arrayOfEvents)
    
    for (index, event) in arrayOfHygieneLabels.enumerated() {
      addSubview(event)
      if index == 0 {
        let imageConstraint = NSLayoutConstraint(item: event, attribute: .top, relatedBy: .equal, toItem: topAnchorConstraint, attribute: .bottom, multiplier: 1, constant: 2)
        previousLbl = event
        addConstraint(imageConstraint)
      } else {
        let imageConstraint = NSLayoutConstraint(item: event, attribute: .top, relatedBy: .equal, toItem: previousLbl, attribute: .bottom, multiplier: 1, constant: 2)
        previousLbl = event
        addConstraint(imageConstraint)
      }
      let imageHeight = NSLayoutConstraint(item: event, attribute: .height, relatedBy: .lessThanOrEqual, toItem: lbl, attribute: .height, multiplier: 1, constant: 15)
      let imageWidth = NSLayoutConstraint(item: event, attribute: .width, relatedBy: .lessThanOrEqual, toItem: lbl, attribute: .width, multiplier: 1, constant: 15)
      let leftAnchorConstraint = NSLayoutConstraint(item: event, attribute: .left, relatedBy: .equal, toItem: previousLbl, attribute: .left, multiplier: 1, constant: 0)
      addConstraints([imageHeight, imageWidth, leftAnchorConstraint])
    }
  }
  
  private func getHygieneLabelArray(hygieneArray: [String]) -> [UIImageView] {
    var labels: [UIImageView] = []
    for event in hygieneArray {
      let bel = UIImageView()
      bel.image = UIImage(imageLiteralResourceName: event)
      bel.layer.cornerRadius = 7.5
      bel.layer.masksToBounds = true
      bel.translatesAutoresizingMaskIntoConstraints = false
      labels.append(bel)
    }
    return labels
  }
  private func setupViews() {
    addSubview(lbl)
    addSubview(hygieneCellCollectionView)
    //    hygieneCellCollectionView.dataSource = self
    //    hygieneCellCollectionView.delegate = self
    //    hygieneCellCollectionView.register(EventCell.self, forCellWithReuseIdentifier: cellId)
    
    //    addSubview(brushEventLbl)
    NSLayoutConstraint.activate([lbl.topAnchor.constraint(equalTo: topAnchor, constant: 2),
                                 lbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 2),
                                 lbl.heightAnchor.constraint(equalToConstant: 15),
                                 lbl.widthAnchor.constraint(equalToConstant: 20)])
    //                                 brushEventLbl.topAnchor.constraint(equalTo: lbl.bottomAnchor, constant: 2),
    //                                 brushEventLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 2),
    //                                 brushEventLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: -2),
    //                                 brushEventLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2)])
    
    
  }
  
  let lbl: UILabel = {
    let label = UILabel()
    label.text = "00"
    label.textAlignment = .left
    label.font = .boldSystemFont(ofSize: 14)
    label.textColor = Colors.darkGray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var brushEventLbl: UIImageView = {
    let bel = UIImageView()
    bel.image = UIImage(imageLiteralResourceName: "1.png")
    bel.layer.cornerRadius = 7.5
    bel.layer.masksToBounds = true
    bel.translatesAutoresizingMaskIntoConstraints = false
    bel.isHidden = true
    return bel
  }()
  
  let hygieneCellCollectionView: UICollectionView = {
    
    let layout = HygieneCollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0 )
    
    let hCV = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    hCV.showsHorizontalScrollIndicator = false
    hCV.translatesAutoresizingMaskIntoConstraints = false
    hCV.layer.cornerRadius = 10
    hCV.layer.masksToBounds = true
    hCV.backgroundColor = .cpCalendarBackground
    return hCV
  }()
  
  //  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  //    guard let events = brushEvent else { return 1 }
  //
  //    return events.count
  //  }
  //
  //  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  //    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! EventCell
  //    print("width and height \(hygieneCellCollectionView.frame.width), \(collectionView.frame.height)")
  //    print(brushEvent?.count)
  //    cell.brushEvent = brushEvent?[(indexPath as NSIndexPath).item]
  //    cell.backgroundColor = .cpSlate
  //    return cell
  //  }
  
  
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

  
  




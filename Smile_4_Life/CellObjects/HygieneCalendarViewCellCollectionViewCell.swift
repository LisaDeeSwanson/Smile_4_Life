//
//  HygieneCalendarViewCellCollectionViewCell.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 10/31/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit

class HygieneCalendarViewCellCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
  
  
  lazy var flowLayout = HygieneEventItemFlowLayout()
  let cellId = "hygieneCell"
  var brushEvent: [DailyHygieneEvents]?
 
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  
    backgroundColor = UIColor.clear
    layer.cornerRadius = 5
    layer.masksToBounds = true
    setupViews()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    lbl.text = ""
    brushEvent = []
    hygieneEventCollectioniew.reloadData()
  }
  
  private func setupViews() {
    addSubview(lbl)
    addSubview(hygieneEventCollectioniew)
    hygieneEventCollectioniew.collectionViewLayout = flowLayout
    hygieneEventCollectioniew.register(EventCell.self, forCellWithReuseIdentifier: cellId)
    hygieneEventCollectioniew.delegate = self
    hygieneEventCollectioniew.dataSource = self

    NSLayoutConstraint.activate([lbl.topAnchor.constraint(equalTo: topAnchor, constant: 2),
                                 lbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 2),
                                 lbl.rightAnchor.constraint(equalTo: rightAnchor, constant: -2),
                                 lbl.heightAnchor.constraint(equalToConstant: 15),
                                 hygieneEventCollectioniew.topAnchor.constraint(equalTo: lbl.bottomAnchor, constant: 2),
                                 hygieneEventCollectioniew.leftAnchor.constraint(equalTo: leftAnchor, constant: 2),
                                 hygieneEventCollectioniew.rightAnchor.constraint(equalTo: rightAnchor, constant: -2),
                                 hygieneEventCollectioniew.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2)])
  }
  
  let lbl: UILabel = {
    let label = UILabel()
    label.text = "00"
    label.textAlignment = .left
    label.font = .boldSystemFont(ofSize: 14)
    label.textColor = .cpSlate
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let hygieneEventCollectioniew: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cV = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    cV.showsVerticalScrollIndicator = true
    cV.showsHorizontalScrollIndicator = false
    cV.translatesAutoresizingMaskIntoConstraints = false
    cV.layer.cornerRadius = 10
    cV.layer.masksToBounds = true
    cV.backgroundColor = .cpCalendarBackground
    return cV
  }()
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      guard let events = brushEvent else { return 1 }
      
      return events.count
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! EventCell
//      print(brushEvent?[(indexPath as NSIndexPath).item].eventImageName)
      cell.brushEvent = brushEvent?[(indexPath as NSIndexPath).item].eventImageName
      cell.backgroundColor = .clear
      return cell
    }
  
    override func willTransition(from oldLayout: UICollectionViewLayout, to newLayout: UICollectionViewLayout) {
     hygieneEventCollectioniew.collectionViewLayout.invalidateLayout()
    }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("I am in nested cell")
    guard let eventsArray = brushEvent else { return }
    if eventsArray.count > 0 {
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotifyCollectionViewToLoadDailyEventTV), object: nil, userInfo: ["eventArray" : eventsArray, "indexPath" : indexPath])
      
    }
  }
}

class EventCell: UICollectionViewCell {
  
  var brushEvent: String? {
    didSet {
      guard var imageName = brushEvent else { return }
      if !imageName.isEmpty {
        brushEventLbl.isHidden = false
      } 
        print("In &&&&&&&&&&&&&&&&&&&&&&&&&\(imageName)")
//      brushEventLbl.image = #imageLiteral(resourceName: "3.png")
        #warning("BEGIN remove before ship")
      //can be removed when database is reset
      if imageName == "4.png" || imageName == "0.png" || imageName == "" {
        imageName = "3.png"
      }
       #warning("END remove before ship")
      brushEventLbl.image = UIImage(imageLiteralResourceName: imageName)
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  
    setupViews()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    brushEvent = ""
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var brushEventLbl: UIImageView = {
    let bel = UIImageView()
    bel.image = #imageLiteral(resourceName: "brushIconNoPlus")
//    bel.image = UIImage(imageLiteralResourceName: "1.png")
    bel.layer.cornerRadius = 10
    bel.layer.masksToBounds = true
    bel.translatesAutoresizingMaskIntoConstraints = false
    bel.isHidden = true
    return bel
  }()
  
  private func setupViews() {
    addSubview(brushEventLbl)
    NSLayoutConstraint.activate([brushEventLbl.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                                 brushEventLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 1),
                                 brushEventLbl.heightAnchor.constraint(equalToConstant: 15),
                                 brushEventLbl.widthAnchor.constraint(equalToConstant: 15)])
    
  }
  
}


class HygieneCollectionViewFlowLayout: UICollectionViewFlowLayout {
  
  lazy var view = UIView()
  
  override init() {
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let width = (view.frame.width / 3) - 20
    let height = (view.frame.height / 3) - 20
    
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }

}

class HygieneEventItemFlowLayout: UICollectionViewFlowLayout {
  
  override init() {
    super.init()
    
    self.minimumLineSpacing = 1
    self.minimumInteritemSpacing = 0
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var itemSize: CGSize {
    get {
      if let collectionView = collectionView {
        let collectionViewWidth = collectionView.frame.width
        let collectionViewHeight = collectionView.frame.height
//        print("&&&&&&&&&&&&&&&&&&&&\(collectionViewWidth, collectionViewHeight)")
        let itemWidth = (collectionViewWidth - self.minimumInteritemSpacing) / 3
        let itemHeight = (collectionViewHeight - self.minimumLineSpacing) / 3
        
        return CGSize(width: itemWidth, height: itemHeight)
      }
      return CGSize(width: 45, height: 45)
    }
    set {
      super.itemSize = newValue
    }
  }
  
  
}

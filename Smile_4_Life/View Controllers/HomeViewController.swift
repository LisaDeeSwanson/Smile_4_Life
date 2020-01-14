//
//  ViewController.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 2/17/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit
import Foundation

class HomeViewController: UIViewController {
  let localModules = LocalModules()
  

  
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    localModules.testDateCode()
    
      navigationController?.isNavigationBarHidden = true
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}


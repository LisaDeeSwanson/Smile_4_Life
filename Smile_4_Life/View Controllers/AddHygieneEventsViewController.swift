//
//  AddHygieneEventsViewController.swift
//  Smile_4_Life
//
//  Created by Lisa Swanson on 6/9/18.
//  Copyright © 2018 Technology Speaks. All rights reserved.
//

import UIKit

class AddHygieneEventsViewController: UIViewController {
  
  @IBOutlet weak var addBrushEvent: UISwitch!
  @IBOutlet weak var addFlossEvent: UISwitch!
  @IBOutlet weak var addEventDate: UIDatePicker!
  

    override func viewDidLoad() {
      super.viewDidLoad()
      addBrushEvent.isOn = false
      addFlossEvent.isOn = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

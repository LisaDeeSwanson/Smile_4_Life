//
//  TimersViewController.swift
//  Smile 4 Life
//
//  Created by Lisa Swanson on 4/2/17.
//  Copyright © 2017 Technology Speaks. All rights reserved.
//

import UIKit

class TimersViewController: UIViewController {
  
  var viewModelMainView: ViewModelMainView!
  var segmentDelegate: UpdateSegmentControlDelegate?
  var timerCount: Int = 0
  var timerRunning = false
  var timer = Timer()
  var countDownTimer: Int = 0
  
  @objc func timerRun() {
    var minuts: Int
    var seconds: Int
    
    timerRunning = true
    timerCount -= 1
    minuts = timerCount / 60
    seconds = timerCount - (minuts * 60)
    
    let formatedTime = NSString(format: "%2d:%2d", minuts, seconds)
    timerLabel.text = String(formatedTime)
    
    if (timerCount == 0) {
      
      timer.invalidate()
      timerRunning = false
      timerLabel.text = "00:00"
      timerCount = 0
      flossPopUp()
    }
  }
  
  func setTimer(){
    
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(TimersViewController.timerRun), userInfo: nil, repeats: true)
    
  }
  
  func flossPopUp() {
    
    let flossAlert = UIAlertController(title: "Congratulations", message: "I will update your calendar.", preferredStyle: UIAlertController.Style.alert)
    
    flossAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: {(action) -> Void in
      
      self.dismiss(animated: true, completion: nil)
      
    }))
    self.present(flossAlert, animated: true, completion: nil)
  }
  
  
  
  @IBOutlet weak var timerLabel: UILabel!
  
  @IBAction func startBrushTimer(_ sender: AnyObject) {
    
    if timerRunning == false {
      timerCount = 180
      setTimer()
      
    }
  }
  
  @IBAction func startFlossTimer(_ sender: AnyObject) {
    if timerRunning == false {
      timerCount = 60
      setTimer()
      
    }
  }
  
  @IBAction func cancelTimers(_ sender: AnyObject) {
    
    if timerRunning == true {
      
      timer.invalidate()
      timerRunning = false
      timerLabel.text = "00:00"
      timerCount = 0
      
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}


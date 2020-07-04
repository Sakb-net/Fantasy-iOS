//
//  GWDisabledVC.swift
//  GameClub
//
//  Created by Basma on 7/3/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class GWDisabledVC: ParentViewController {
    var counter = 18071
    var hours = 0
    var minutes = 0
    var seconds = 0
    @IBOutlet weak var hoursLbl: UILabel!
    @IBOutlet weak var minutesLbl: UILabel!
    @IBOutlet weak var secondsLbl: UILabel!
    @IBOutlet weak var homeBt: UIButton!
    @IBAction func menuAction(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        roundViewCornersNoShadow(view: homeBt)
        hours = (counter / 60) / 60
        minutes = (counter - (hours * 60 * 60)) / 60
        seconds = counter - (hours * 60 * 60) - (minutes * 60)
        
        if hours > 0 {
            hoursLbl.text = String(hours)
        }
        if minutes > 0 {
            minutesLbl.text = String(minutes)
        }
        if seconds > 0 {
            secondsLbl.text = String(seconds)
        }
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    

   var fixSeconds = 59
    var fixMinutes = 59
    @objc func updateCounter() {
            if seconds > 0 {
                secondsLbl.text = String(seconds)
                    seconds -= 1
            }else if seconds == 0 && minutes > 0 {
                if fixSeconds != 0 {
                minutesLbl.text = String(minutes-1)
                secondsLbl .text = String(fixSeconds)
                fixSeconds -= 1
                }else {
                    fixSeconds = 59
                    minutes -= 1
                    if minutes != 0 {
                    minutesLbl.text = String(minutes-1)
                        secondsLbl.text = String(fixSeconds)
                        fixSeconds -= 1
                    }else {
                        secondsLbl.text = String(0)
                    }
                    
                }
            }else if seconds == 0 && minutes == 0 && hours > 0{
                if fixSeconds != 0 {
                    hoursLbl.text = String(hours-1)
                    minutesLbl.text = String(fixMinutes)
                    secondsLbl .text = String(fixSeconds)
                    fixSeconds -= 1
                }else {
                    fixSeconds = 59
                    if fixMinutes == 0{
                        fixMinutes = 59
                        hours -= 1
                        if hours != 0 {
                        hoursLbl.text = String(hours-1)
                        minutesLbl.text = String(fixMinutes)
                        secondsLbl .text = String(fixSeconds)
                        fixSeconds -= 1
                        }else {
                            hoursLbl.text = String("00")
                            minutesLbl.text = String("00")
                            secondsLbl .text = String("00")
                        }
                    }else {
                        fixMinutes -= 1
                        hoursLbl.text = String(hours-1)
                        minutesLbl.text = String(fixMinutes)
                        secondsLbl .text = String(fixSeconds)
                        fixSeconds -= 1
                    }
                    
                }
            }else {
                
        }
            
    }
}

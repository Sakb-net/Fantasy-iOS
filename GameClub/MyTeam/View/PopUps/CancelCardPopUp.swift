//
//  CancelCardPopUp.swift
//  GameClub
//
//  Created by Basma on 9/12/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class CancelCardPopUp: ParentViewController {

    @IBOutlet weak var containerView: UIView!
    
    @IBAction func yesAction(_ sender: Any) {
    }
    @IBAction func noAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        roundViewCorners(view: self.containerView)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           if let touch = touches.first {
               if let touchedView = touch.view, touchedView != containerView {
                   self.dismiss(animated: true, completion: nil)
               }
           }
       }
}

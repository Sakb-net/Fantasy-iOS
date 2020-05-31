//
//  SuccessPopUP.swift
//  GameClub
//
//  Created by Basma on 5/21/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class SuccessPopUP: ParentViewController {
    @IBOutlet weak var okBT: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBAction func okAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundViewCornersNoShadow(view: okBT)
        roundViewCorners(view: containerView)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           if let touch = touches.first {
               if let touchedView = touch.view, touchedView != containerView {    self.dismiss(animated: true, completion: nil)
               }
           }
       }
}

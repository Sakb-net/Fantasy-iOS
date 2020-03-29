//
//  PriceRangeTF.swift
//  GameClub
//
//  Created by Basma on 3/25/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class PriceRangeTF: ParentViewController {

   
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var searchBT: UIButton!
    @IBAction func searchAction(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        roundViewCorners(view: containerView)
        roundViewCornersNoShadow(view: searchBT)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           if let touch = touches.first {
               if let touchedView = touch.view, touchedView != containerView {
                   self.dismiss(animated: true, completion: nil)
               }
           }
       }
}

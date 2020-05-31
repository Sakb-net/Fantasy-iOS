//
//  BestLeaguePopUp.swift
//  GameClub
//
//  Created by Basma on 5/30/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class BestLeaguePopUp: ParentViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var confirmBT: UIButton!
    @IBOutlet weak var cancelBT: UIButton!
    @IBAction func ConfirmAction(_ sender: Any) {
    }
    @IBAction func CancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        roundViewCornersNoShadow(view: containerView)
        roundViewCornersNoShadow(view: confirmBT)
        roundViewCornersNoShadow(view: cancelBT)

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let touchedView = touch.view, touchedView != containerView {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

//
//  CardPopUp.swift
//  GameClub
//
//  Created by Basma on 5/16/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class CardPopUp: ParentViewController {
    var popUpType = ""
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var confirmBT: UIButton!
    @IBOutlet weak var cancelBT: UIButton!
    @IBAction func ConfirmAction(_ sender: Any) {
    }
    @IBAction func CancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if popUpType == "sub_card" {
            imageView.image = UIImage(named: "rocket")
            titleLbl.text = "احتساب نقاط البدلاء"
            contentLbl.text = "هذه الورقة تسمح لك أن تلعب بـ15 لاعب، أي أنه يحتسب نقاط لاعبين البدلاء وكأنهم أساسيين ويمكنك استخدامها مرة واحدة فقط خلال الموسم"
        }else if popUpType == "three_card" {
            imageView.image = UIImage(named: "x3")
            titleLbl.text = "ورقة الكابتن الثلاثية"
            contentLbl.text = "هذه الورقة تضرب نقاط الكابتن بـ3 بدل أن تضاعف فقط ويمكنك استخدامها مرة واحدة فقط خلال الموسم"
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let touchedView = touch.view, touchedView != containerView {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

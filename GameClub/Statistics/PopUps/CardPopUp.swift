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
    var benchCard = 0
    var tripleCard = 0
    var delegate : cardActivationDelegat?
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var confirmBT: UIButton!
    @IBOutlet weak var cancelBT: UIButton!
    @IBAction func ConfirmAction(_ sender: Any) {
        if popUpType == "sub_card" || popUpType == "three_card" {
            confirmAction ()
        }else {
            self.delegate?.isCardActivated(cardType : self.popUpType)
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func CancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        roundViewCornersNoShadow(view: confirmBT)
        roundViewCornersNoShadow(view: cancelBT)
        if popUpType == "sub_card" {
            imageView.image = UIImage(named: "rocket")
            titleLbl.text = "احتساب نقاط البدلاء"
            contentLbl.text = "هذه الورقة تسمح لك أن تلعب بـ15 لاعب، أي أنه يحتسب نقاط لاعبين البدلاء وكأنهم أساسيين ويمكنك استخدامها مرة واحدة فقط خلال الموسم"
        }else if popUpType == "three_card" {
            imageView.image = UIImage(named: "x3")
            titleLbl.text = "ورقة الكابتن الثلاثية"
            contentLbl.text = "هذه الورقة تضرب نقاط الكابتن بـ3 بدل أن تضاعف فقط ويمكنك استخدامها مرة واحدة فقط خلال الموسم"
        }else if popUpType == "silver_card" {
            imageView.image = UIImage(named: "Sliver-card")
            titleLbl.text = "الكارت الفضي"
            contentLbl.text = "هذا الكارت يسمح لك بإجراء انتقالات مجانية غير محدودة خلال الجولة ويمكنك استخدامها مرة واحدة فقط خلال الموسم"
        }else if popUpType == "golden_card"{
            imageView.image = UIImage(named: "golden-card")
            titleLbl.text = "الكارت الذهبي"
            contentLbl.text = "هذا الكارت يسمح لك بإجراء انتقالات مجانية غير محدودة خلال الجولة ويمكنك شرائها أكثر من مرة خلال الموسم"
        }
    }
    
    func confirmAction () {
        var url = ""
        if popUpType == "sub_card" {
            url = Urls().bench_players_card()
        }else if popUpType == "three_card"{
            url = Urls().triple_captain_card()
        }
        MyTeamPresenter().activateCard(url: url, onSuccess: { (data, message) in
            
            if data == 1{
                self.delegate?.isCardActivated(cardType : self.popUpType)
                self.dismiss(animated: true, completion: nil)
                
            }else {
                if self.benchCard == 0 && self.tripleCard == 0 {
                    self.showAlert(title: "", message: "Pick Captain".localized, shouldpop: false)
                }else {
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }) { (errorMessage) in
            //                self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
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
protocol cardActivationDelegat {
    func isCardActivated(cardType : String)
}

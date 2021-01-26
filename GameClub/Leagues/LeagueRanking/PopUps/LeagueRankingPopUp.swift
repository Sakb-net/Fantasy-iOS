//
//  LeagueRankingPopUp.swift
//  SAKB FANTASY
//
//  Created by Basma on 1/26/21.
//  Copyright © 2021 Basma. All rights reserved.
//

import UIKit

class LeagueRankingPopUp: ParentViewController {
    
    var delegate : LeagueRankingPopUpDelegate?
    var isWinPopUp = true
    
    @IBOutlet weak var winButton: UIButton!
    @IBOutlet weak var lossButton: UIButton!
    @IBOutlet weak var containerView: UIStackView!
    
    @IBAction func winAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
        if isWinPopUp {
            delegate?.returnChoiceType(type:"win")
        }else {
            delegate?.returnChoiceType(type:"home")
        }
    }
    
    @IBAction func lossAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
        if isWinPopUp {
            delegate?.returnChoiceType(type:"loss")
        }else {
            delegate?.returnChoiceType(type:"away")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundViewCornersNoShadow(view: winButton)
        roundViewCornersNoShadow(view: lossButton)
        
        if !isWinPopUp {
            winButton.setTitle("Home".localized, for: .normal)
            lossButton.setTitle("Away".localized, for: .normal)
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
protocol LeagueRankingPopUpDelegate {
    func returnChoiceType(type:String)
}

//
//  ChooseCaptinPopUp.swift
//  GameClub
//
//  Created by Basma on 4/3/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class ChooseCaptinPopUp: ParentViewController {
    var delegate : MyTeamProtocol?
    var playerBT = UIButton ()
    var playerView = UIView()
    var player : MyTeam?
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var changePlayerBT: UIButton!
    @IBOutlet weak var chooseCaptinBT: UIButton!
    @IBOutlet weak var chooseViceCaptinBT: UIButton!
    @IBOutlet weak var playerDetailsBT: UIButton!
    @IBAction func changePlayerAction(_ sender: Any) {
        delegate?.changePlayer(view : playerView, button: playerBT, player: player!)
        self.dismiss(animated: true, completion: nil)

    }
    @IBAction func chooseCaptinAction(_ sender: Any) {
    }
    @IBAction func chooseViceCaptinAction(_ sender: Any) {
    }
    @IBAction func playerDetailsAction(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
    }
    
    func viewConfig() {
        roundViewCorners(view: self.containerView)
        roundViewCornersNoShadow(view: changePlayerBT)
        roundViewCornersNoShadow(view: chooseCaptinBT)
        roundViewCornersNoShadow(view: chooseViceCaptinBT)
        roundViewCornersNoShadow(view: playerDetailsBT)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let touchedView = touch.view, touchedView != containerView {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

}
protocol MyTeamProtocol {
    func changePlayer (view : UIView, button : UIButton, player : MyTeam)
}

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
    var isSub = false
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var changePlayerBT: UIButton!
    @IBOutlet weak var chooseCaptinBT: UIButton!
    @IBOutlet weak var chooseViceCaptinBT: UIButton!
    @IBOutlet weak var playerDetailsBT: UIButton!
    @IBAction func changePlayerAction(_ sender: Any) {
        if isSub {
            delegate?.orderSubPlayer(view : playerView, button: playerBT, player: player!)
        }else{
            delegate?.changePlayer(view : playerView, button: playerBT, player: player!)
        }
        self.dismiss(animated: true, completion: nil)

    }
    @IBAction func chooseCaptinAction(_ sender: Any) {
        delegate?.chooseCaptain_assist(player: player!, type: 0)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func chooseViceCaptinAction(_ sender: Any) {
        delegate?.chooseCaptain_assist(player: player!, type: 1)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func playerDetailsAction(_ sender: Any) {
        delegate?.openPlayerDetails(player: player!)
        self.dismiss(animated: true, completion: nil)
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
        if isSub {
            self.chooseCaptinBT.isHidden = true
            self.chooseViceCaptinBT.isHidden = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let touchedView = touch.view, touchedView != containerView {
                delegate?.resetButtons()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

}
protocol MyTeamProtocol {
    func changePlayer (view : UIView, button : UIButton, player : MyTeam)
    func orderSubPlayer (view : UIView, button : UIButton, player: MyTeam)
    func chooseCaptain_assist (player: MyTeam, type : Int)
    func openPlayerDetails (player : MyTeam)
    func resetButtons()
}

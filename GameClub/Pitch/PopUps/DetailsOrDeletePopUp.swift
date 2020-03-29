//
//  DetailsOrDeletePopUp.swift
//  GameClub
//
//  Created by Basma on 3/21/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class DetailsOrDeletePopUp: ParentViewController {
    var delegate : checkDeletePlayer?
    var player = MyTeam()
    var btName : String?
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var playerDetailsBT: UIButton!
    @IBOutlet weak var deletePlayerBT: UIButton!
    @IBAction func playerDetailsAction(_ sender: Any) {
        let playerDetailsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "PlayerDetailsVC") as! PlayerDetailsVC
        playerDetailsVC.fromPitch = true
        playerDetailsVC.team = player
        present(playerDetailsVC, animated: true, completion: nil)
    }
    @IBAction func deletePlayerAction(_ sender: Any) {
        delegate?.checkDelete(btName: btName!)
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let touchedView = touch.view, touchedView != containerView {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    func viewConfig(){
        roundViewCornersNoShadow(view: self.deletePlayerBT)
        roundViewCornersNoShadow(view: self.playerDetailsBT)
        roundViewCorners(view: self.containerView)
    }
}

protocol checkDeletePlayer {
    func checkDelete(btName : String)
}

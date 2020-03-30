//
//  DeletedPlayerOptionsPopUp.swift
//  GameClub
//
//  Created by Basma on 3/21/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class DeletedPlayerOptionsPopUp: ParentViewController {
    var delegate : playerDeletedDelegate?
    var playerLink = ""
    var eldwry_link = ""
    var btName = ""
    var player = MyTeam()
    var bt : UIButton?
    var presenter = PlayersPresenter()
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var getPlayerBT: UIButton!
    @IBOutlet weak var changePlayerBT: UIButton!
    @IBOutlet weak var playerDetailsBT: UIButton!
    @IBOutlet weak var deletePlayerBT: UIButton!
    
    @IBAction func getPlayerAction(_ sender: Any) {
        UserDefaults.standard.set(0, forKey: self.btName)
        self.delegate?.getPlayerBack(bt: bt!)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func changePlayerAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        self.delegate?.replacePlayer(player: player, bt: bt!, btName: btName, delegate: delegate!)
    }
    @IBAction func playerDetailsAction(_ sender: Any) {
        let playerDetailsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "PlayerDetailsVC") as! PlayerDetailsVC
        playerDetailsVC.fromPitch = true
        playerDetailsVC.team = player
        present(playerDetailsVC, animated: true, completion: nil)
    }
    @IBAction func deletePlayerAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.showLoader()
        presenter.deletePlayer(player_link: player.link_player!, eldwry_link: player.eldwry_link!, onSuccess: { (message) in
            self.delegate?.playerDeleted(message: message)
            UserDefaults.standard.set(0, forKey: self.btName)
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
    }

    func viewConfig(){
        roundViewCornersNoShadow(view: self.getPlayerBT)
        roundViewCornersNoShadow(view: self.changePlayerBT)
//        roundViewCornersNoShadow(view: self.deletePlayerBT)
        roundViewCornersNoShadow(view: self.playerDetailsBT)
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

protocol playerDeletedDelegate {
    func playerDeleted(message : String)
    func getPlayerBack(bt : UIButton)
    func replacePlayer(player : MyTeam, bt : UIButton, btName : String, delegate : playerDeletedDelegate)
}

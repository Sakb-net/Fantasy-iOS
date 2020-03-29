//
//  PlayerDetailsVC.swift
//  GameClub
//
//  Created by Basma on 3/11/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class PlayerDetailsVC: ParentViewController {
    var player = Player()
    var team = MyTeam()
    var fromPitch = false
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var playerIV: UIImageView!
    @IBOutlet weak var playerNameLbl: UILabel!
    @IBOutlet weak var playerTeamLbl: UILabel!
    @IBOutlet weak var playerPositionLbl: UILabel!
    @IBAction func backAction(_ sender: Any) {
        if fromPitch {
            dismiss(animated: true, completion: nil)
        }else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if fromPitch{
            self.playerIV.sd_setImage(with: URL(string: Urls.baseUrl + self.team.image_player! ), placeholderImage: UIImage(named: "placeholder"))
            self.playerNameLbl.text = self.team.name_player
            self.playerTeamLbl.text = self.team.team
            self.playerPositionLbl.text = self.team.location_player
            self.titleLbl.text = self.team.name_player
        }else {
        self.playerIV.sd_setImage(with: URL(string: Urls.baseUrl + self.player.image! ), placeholderImage: UIImage(named: "placeholder"))
        self.playerNameLbl.text = self.player.name
        self.playerTeamLbl.text = self.player.team
        self.playerPositionLbl.text = self.player.location_player
        self.titleLbl.text = self.player.name
        }
    }
    
}

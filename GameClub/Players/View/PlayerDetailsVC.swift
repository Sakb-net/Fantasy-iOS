//
//  PlayerDetailsVC.swift
//  GameClub
//
//  Created by Basma on 3/11/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class PlayerDetailsVC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "PlayerMatchCell", for: indexPath) as! PlayerMatchCell
        
        if indexPath.row == 0 {
            return cell1
        }else {
            return cell2
        }

    }
    
    var player = Player()
    var team = MyTeam()
    var fromPitch = false
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var playerStateLbl: UILabel!
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
        tableView.delegate = self
        tableView.dataSource = self
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

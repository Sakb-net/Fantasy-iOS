//
//  PlayerDetailsVC.swift
//  GameClub
//
//  Created by Basma on 3/11/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class PlayerDetailsVC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    
    var presenter = PlayersPresenter()
    var playersStatics = [PlayerStatistics]()
    var player = Player()
    var team = MyTeam()
    var playerLink = ""
    var playerTeam = ""
    var fromPitch = false
    var playerStatistics = PlayerStatistics ()
    @IBOutlet weak var formLbl: UILabel!
    @IBOutlet weak var weekLbl: UILabel!
    @IBOutlet weak var totalPointsLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var selectPercentageLbl: UILabel!
    @IBOutlet weak var influenceLbl: UILabel!
    @IBOutlet weak var creativityLbl: UILabel!
    @IBOutlet weak var threatsLbl: UILabel!
    @IBOutlet weak var ictIndexLbl: UILabel!
    
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
            self.playerLink = self.team.link_player!
            self.playerTeam = self.team.team!
        }else {
            self.playerIV.sd_setImage(with: URL(string: Urls.baseUrl + self.player.image! ), placeholderImage: UIImage(named: "placeholder"))
            self.playerNameLbl.text = self.player.name
            self.playerTeamLbl.text = self.player.team
            self.playerPositionLbl.text = self.player.location_player
            self.titleLbl.text = self.player.name
            self.playerLink = self.player.link!
            self.playerTeam = self.player.team!
        }
        getPlayersDetails()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.playersStatics.count + 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == 0 {
                 return 1
            }else{
                if self.playersStatics[section-1].isOpended! {
                return 2
            }else {
                return 1
            }
            }
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "PlayerMatchCell", for: indexPath) as! PlayerMatchCell
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "PlayerStaticsCell", for: indexPath) as! PlayerStaticsCell
            
            if indexPath.section == 0 {
                return cell1
            }else {
                if indexPath.row == 0 {
                    cell2.firstTeamLbl.text = self.playerTeam
                    cell2.secondTeamLbl.text = self.playersStatics[indexPath.section-1].againestTeam
                    let totalGWPoints = self.playersStatics[indexPath.section-1].points
                    if let points = totalGWPoints {
                        cell2.pointsLbl.text = String(points)
                    }
                    let gameweek = self.playersStatics[indexPath.section-1].week
                    if let gameWeek = gameweek {
                        cell2.roundLbl.text = String(gameWeek)
                    }
                    return cell2
                }else{
                    let costPlayer = self.team.cost_player
                    if let cost = costPlayer {
                        cell3.GWValueLbl.text = String(cost)
                    }
                    let cleansheet = self.playersStatics[indexPath.section-1].cleanSheet
                    if let cs = cleansheet {
                        cell3.CSValueLbl.text = String(cs)
                    }
                    let minutes = self.playersStatics[indexPath.section-1].minsPlayed
                    if let mins = minutes {
                        cell3.minValueLbl.text = String(mins)
                    }
                    return cell3
                }
            }
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if playersStatics[indexPath.section-1].isOpended!{
                playersStatics[indexPath.section-1].isOpended! = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }else{
                playersStatics[indexPath.section-1].isOpended! = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
    
    func getPlayersDetails(){
        self.showLoader()
        presenter.getPlayerDetails(playerLink: self.playerLink ,onSuccess: { (playersStatics) in
            for item in playersStatics {
                item.isOpended = false
            }
            self.playersStatics = playersStatics
            self.tableView.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
}

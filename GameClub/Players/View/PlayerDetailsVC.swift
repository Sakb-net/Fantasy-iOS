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
    var playerGeneralData = PlayerGeneralData()
    var player = Player()
    var team = MyTeam()
    var gw = ""
    var playerLink = ""
    var playerTeam = ""
    var fromPitch = false
    var playerStatistics = PlayerStatistics()
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
        navigationController?.popViewController(animated: true)
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
                    cell2.firstTeamLbl.text = self.playersStatics[indexPath.section-1].ownTeam
                    cell2.secondTeamLbl.text = self.playersStatics[indexPath.section-1].againestTeam
                    let firstS = self.playersStatics[indexPath.section-1].ownTeamResult
                    let secondS = self.playersStatics[indexPath.section-1].againestTeamResult
                    var firstScore = ""
                    var secondScore = ""
                    if let first = firstS {
                        firstScore = String(first)
                    }
                    if let second = secondS {
                        secondScore = String(second)
                    }
                    if "lang".localized == "en"{
                        cell2.scoreLbl.text = firstScore + "-" + secondScore
                    }else if "lang".localized == "ar"{
                        cell2.scoreLbl.text = secondScore + "-" + firstScore
                    }

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
                    cell3.index = indexPath.section-1
                    cell3.delegate = self
                    let costPlayer = self.team.cost_player
                    if let cost = costPlayer {
                        cell3.GWValueLbl.text = String(cost)
                    }
                    let stats = self.playersStatics[indexPath.section-1].statistic
                    let minPlayed = self.playersStatics[indexPath.section-1].minsPlayed ?? 0
                    if stats!.isEmpty {
                        cell3.titleLbl.text = "Minutes".localized
                        cell3.valueLbl.text = String(minPlayed)
                        cell3.pointsLbl.text = "0"
                    }else{
                        var title = ""
                        var value = ""
                        var points = ""
                        for n in 0...stats!.count-1 {
                            if n != stats!.count - 1 {
                                title = title + stats![n].lang_point! + "\n"
                                let val = stats![n].number ?? 0
                                value = value + String(val) + "\n"
                                let pts = stats![n].points ?? 0
                                points = points + String(pts) + "Pts" + "\n"
                            }else {
                                title = title + stats![n].lang_point!
                                let val = stats![n].number ?? 0
                                value = value + String(val)
                                let pts = stats![n].points ?? 0
                                points = points + String(pts) + "Pts"
                            }
                        }
                        cell3.titleLbl.text = title
                        cell3.valueLbl.text = value
                        cell3.pointsLbl.text = points
                    }
                    return cell3
                }
            }
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.section  != 0{
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
        }
    
    func getPlayersDetails(){
        self.showLoader()
        presenter.getPlayerDetails(playerLink: self.playerLink ,onSuccess: { (playersStatics, playerGeneralData) in
            for item in playersStatics {
                item.isOpended = false
            }
            self.playersStatics = playersStatics
            self.playerGeneralData = playerGeneralData
            if let form = playerGeneralData.form {
                self.formLbl.text = String(form)
            }
            if let week = playerGeneralData.week {
                self.weekLbl.text = String(week)
            }
            if let points = playerGeneralData.point {
                self.totalPointsLbl.text = String(points)
            }
            if let price = playerGeneralData.cost {
                self.priceLbl.text = String(price)
            }
            if let sel_percentage = playerGeneralData.sel_percentage {
                self.selectPercentageLbl.text = String(sel_percentage)
            }
            if let influence = playerGeneralData.influence {
                self.influenceLbl.text = String(influence)
            }
            if let creativity = playerGeneralData.creativity {
                self.creativityLbl.text = String(creativity)
            }
            if let threats = playerGeneralData.threats {
                self.threatsLbl.text = String(threats)
            }
            if let ICT_index = playerGeneralData.ICT_index {
                self.ictIndexLbl.text = String(ICT_index)
            }
            self.tableView.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
}
extension PlayerDetailsVC : ViewMatchDetails{
    func viewMatch(index : Int) {
        let matchDetailsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "MatchDetailsVC") as! MatchDetailsVC
        matchDetailsVC.page = 1
        matchDetailsVC.firstTeam = self.playersStatics[index].ownTeam!
        matchDetailsVC.secondTeam = self.playersStatics[index].againestTeam!
        matchDetailsVC.firstTeamScore = self.playersStatics[index].ownTeamResult!
        matchDetailsVC.secondTeamScore = self.playersStatics[index].againestTeamResult!
        matchDetailsVC.link = self.playersStatics[index].link_match!
        navigationController?.pushViewController(matchDetailsVC, animated: false)
    }
}

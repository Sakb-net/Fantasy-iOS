//
//  PitchVC.swift
//  GameClub
//
//  Created by Basma on 3/5/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SideMenu
import SwiftSVG

class PitchVC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    
    var presenter = PlayersPresenter()
    var pitchPresenter = PitchPresenter()
    var pageType = 0
    var remainingMoney = 0.0
    var totalMoney = 0.0
    
    @IBOutlet weak var freeTransView: UIView!
    @IBOutlet weak var freeTransNumLbl: UILabel!
    
    @IBOutlet weak var autoSelectView: UIView!
    @IBOutlet weak var autoSelectBT: UIButton!
    @IBOutlet weak var resetBT: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var goalKeeperBT1: UIButton!
    @IBOutlet weak var goalKeeperBT2: UIButton!
    
    @IBOutlet weak var defenderBT1: UIButton!
    @IBOutlet weak var defenderBT2: UIButton!
    @IBOutlet weak var defenderBT3: UIButton!
    @IBOutlet weak var defenderBT4: UIButton!
    @IBOutlet weak var defenderBT5: UIButton!
    @IBOutlet weak var midBT1: UIButton!
    @IBOutlet weak var midBT2: UIButton!
    @IBOutlet weak var midBT3: UIButton!
    @IBOutlet weak var midBT4: UIButton!
    @IBOutlet weak var midBT5: UIButton!
    @IBOutlet weak var attackerBT1: UIButton!
    @IBOutlet weak var attackerBT2: UIButton!
    @IBOutlet weak var attackerBT3: UIButton!
    
    @IBOutlet weak var goalKeeperLbl1: UILabel!
    @IBOutlet weak var goalKeeperLbl2: UILabel!
    @IBOutlet weak var defenderLbl1: UILabel!
    @IBOutlet weak var defenderLbl2: UILabel!
    @IBOutlet weak var defenderLbl3: UILabel!
    @IBOutlet weak var defenderLbl4: UILabel!
    @IBOutlet weak var defenderLbl5: UILabel!
    @IBOutlet weak var midLbl1: UILabel!
    @IBOutlet weak var midLbl2: UILabel!
    @IBOutlet weak var midLbl3: UILabel!
    @IBOutlet weak var midLbl4: UILabel!
    @IBOutlet weak var midLbl5: UILabel!
    @IBOutlet weak var attackerLbl1: UILabel!
    @IBOutlet weak var attackerLbl2: UILabel!
    @IBOutlet weak var attackerLbl3: UILabel!
    
    @IBOutlet weak var goalKeeperCostLbl1: UILabel!
    @IBOutlet weak var goalKeeperCostLbl2: UILabel!
    @IBOutlet weak var defenderCostLbl1: UILabel!
    @IBOutlet weak var defenderCostLbl2: UILabel!
    @IBOutlet weak var defenderCostLbl3: UILabel!
    @IBOutlet weak var defenderCostLbl4: UILabel!
    @IBOutlet weak var defenderCostLbl5: UILabel!
    @IBOutlet weak var midCostLbl1: UILabel!
    @IBOutlet weak var midCostLbl2: UILabel!
    @IBOutlet weak var midCostLbl3: UILabel!
    @IBOutlet weak var midCostLbl4: UILabel!
    @IBOutlet weak var midCostLbl5: UILabel!
    @IBOutlet weak var attackerCostLbl1: UILabel!
    @IBOutlet weak var attackerCostLbl2: UILabel!
    @IBOutlet weak var attackerCostLbl3: UILabel!


    
    @IBOutlet weak var pageTitleLbl: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var numPlayerLabel: UILabel!
    @IBOutlet weak var remainCostLabel: UILabel!
    @IBOutlet weak var viewListBT: UIButton!
    @IBOutlet weak var viewPitchBT: UIButton!
    @IBOutlet weak var saveBT: UIButton!
    @IBAction func autoSelectAction(_ sender: Any) {
        getMyTeam(type: 1)
    }
    @IBAction func resetAction(_ sender: Any) {
        presenter.resetAllPlayers(onSuccess: { (message) in
            self.hideLoader()
            self.showAlert(title: "", message: message, shouldpop: false)
            self.getMyTeam(type: 0)
            
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    @IBAction func pickGoalKeeperAction1(_ sender: Any) {
        foundPlayerOptions(player: self.goalKeepersCopy, index: 0, stringValue: "goalkeeper", screenPosition: "bt1", bt : self.goalKeeperBT1)
    }
    @IBAction func pickGoalKeeperAction2(_ sender: Any) {
        foundPlayerOptions(player: self.goalKeepersCopy, index: 1, stringValue: "goalkeeper", screenPosition: "bt2", bt: self.goalKeeperBT2)
    }
    @IBAction func pickDefenderAction1(_ sender: Any) {
        foundPlayerOptions(player: self.defendersCopy, index: 0, stringValue: "defender", screenPosition: "bt3", bt: self.defenderBT1)
    }
    @IBAction func pickDefenderAction2(_ sender: Any) {
        foundPlayerOptions(player: self.defendersCopy, index: 1, stringValue: "defender", screenPosition: "bt4", bt: self.defenderBT2)
    }
    @IBAction func pickDefenderAction3(_ sender: Any) {
        foundPlayerOptions(player: self.defendersCopy, index: 2, stringValue: "defender", screenPosition: "bt5", bt: self.defenderBT3)
    }
    @IBAction func pickDefenderAction4(_ sender: Any) {
        foundPlayerOptions(player: self.defendersCopy, index: 3, stringValue: "defender", screenPosition: "bt6", bt: self.defenderBT4)
    }
    @IBAction func pickDefenderAction5(_ sender: Any) {
        foundPlayerOptions(player: self.defendersCopy, index: 4, stringValue: "defender", screenPosition: "bt7", bt: self.defenderBT5)
    }
    @IBAction func pickMidAction1(_ sender: Any) {
        foundPlayerOptions(player: self.midsCopy, index: 0, stringValue: "line", screenPosition: "bt8", bt: self.midBT1)
    }
    @IBAction func pickMidAction2(_ sender: Any) {
        foundPlayerOptions(player: self.midsCopy, index: 1, stringValue: "line", screenPosition: "bt9", bt: self.midBT2)
    }
    @IBAction func pickMidAction3(_ sender: Any) {
        foundPlayerOptions(player: self.midsCopy, index: 2, stringValue: "line", screenPosition: "bt10", bt: self.midBT3)
    }
    @IBAction func pickMidAction4(_ sender: Any) {
        foundPlayerOptions(player: self.midsCopy, index: 3, stringValue: "line", screenPosition: "bt11", bt: self.midBT4)
    }
    @IBAction func pickMidAction5(_ sender: Any) {
        foundPlayerOptions(player: self.midsCopy, index: 4, stringValue: "line", screenPosition: "bt12", bt: self.midBT5)
    }
    @IBAction func pickAttackerAction1(_ sender: Any) {
        foundPlayerOptions(player: self.attackersCopy, index: 0, stringValue: "attacker", screenPosition: "bt13", bt: self.attackerBT1)
    }
    @IBAction func pickAttackerAction2(_ sender: Any) {
        foundPlayerOptions(player: self.attackersCopy, index: 1, stringValue: "attacker", screenPosition: "bt14", bt: self.attackerBT2)
    }
    @IBAction func pickAttackerAction3(_ sender: Any) {
        foundPlayerOptions(player: self.attackersCopy, index: 2, stringValue: "attacker", screenPosition: "bt15", bt: self.attackerBT3)
    }
    
    func foundPlayerOptions (player : [MyTeam], index : Int, stringValue : String, screenPosition : String, bt : UIButton){
        if player[index].found_player == 1{
            let isDelete = UserDefaults.standard.integer(forKey: screenPosition)
            if isDelete == 1 {
                let popUpVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "DeletedPlayerOptionsPopUp") as! DeletedPlayerOptionsPopUp
                popUpVC.btName = screenPosition
                popUpVC.delegate = self
                popUpVC.listener = self
                popUpVC.player = player[index]
                popUpVC.playerType = stringValue
                popUpVC.index = index
                popUpVC.bt = bt
                present(popUpVC, animated: true
                    , completion: nil)
            }else {
                let popUpVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "DetailsOrDeletePopUp") as! DetailsOrDeletePopUp
                popUpVC.btName = screenPosition
                popUpVC.delegate = self
                popUpVC.player = player[index]
                popUpVC.btName = screenPosition
                present(popUpVC, animated: true
                    , completion: nil)
            }
        }else{
            openPlayerVC(playerType: stringValue)
        }
    }
    
    @IBAction func viewPitchAction(_ sender: Any) {
        self.tableView.isHidden = true
        
    }
    @IBAction func viewListAction(_ sender: Any) {
        self.tableView.isHidden = false
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if pageType == 0 {
            let popUpVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "NameTeamPopUp") as! NameTeamPopUp
            present(popUpVC, animated: true
                , completion: nil)
        }else {
            let subs = pitchPresenter.getSubstitutions (oldPlayers: [goalKeepers,defenders,mids,attackers], newPlayers: [goalKeepersCopy,defendersCopy,midsCopy,attackersCopy])
            let confirmTransfersVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "ConfirmTransfersVC") as! ConfirmTransfersVC
            confirmTransfersVC.allSubs = subs
            confirmTransfersVC.delegate = self
            confirmTransfersVC.payementSuccessDelegate = self
            self.navigationController?.pushViewController(confirmTransfersVC, animated: true)
            
        }
    }
    
    
    @IBAction func menuAction(_ sender: Any) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! UISideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    var goalKeepers = [MyTeam]()
    var defenders = [MyTeam]()
    var mids = [MyTeam]()
    var attackers = [MyTeam]()
    var goalKeepersCopy = [MyTeam]()
    var defendersCopy = [MyTeam]()
    var midsCopy = [MyTeam]()
    var attackersCopy = [MyTeam]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let endDate = UserDefaults.standard.string(forKey: "END_DATE") ?? ""
        let gameWeek = UserDefaults.standard.string(forKey: "GAME_WEEK") ?? ""
        let mainLblString = "End date for GW ".localized + gameWeek + ": " + endDate
        endTimeLabel.text = mainLblString
        if pageType == 1 {self.autoSelectView.isHidden = true
            self.freeTransView.isHidden = false
            self.saveBT.isEnabled = false
            self.saveBT.alpha = 0.5
            self.pageTitleLbl.text = "Transfers".localized
            let freeTrans = UserDefaults.standard.integer(forKey: "count_free_weekgamesubstitute")
            self.freeTransNumLbl.text = String(freeTrans)
            if isNetworkReachable{
                getMyTeam(type: 0)
            }else{
                self.showAlert(title: "", message: "Internet is not available", shouldpop: true)
            }
        }
        pitchPresenter.resetBTs()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if pageType == 0 {
            if isNetworkReachable{
                getMyTeam(type: 0)
            }else{
                self.showAlert(title: "", message: "Internet is not available", shouldpop: true)
            }
        }else {}
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count1 = self.goalKeepers.count
        let count2 = self.defenders.count
        let count3 = self.mids.count
        let count4 = self.attackers.count
        
        return count1 + count2 + count3 + count4 + 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "PichCell", for: indexPath) as! PichCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "PichHeaderCell", for: indexPath) as! PichHeaderCell
        if indexPath.row == 0 {
            cell2.positionLbl.text = "GoalKeeper".localized
            cell2.contentView.backgroundColor = Color.goalKeeper.value
            return cell2
        }else if indexPath.row > 0 && indexPath.row <= self.goalKeepersCopy.count{
            let index = indexPath.row - 1
            cell1.nameLbl.text = self.goalKeepersCopy[indexPath.row - 1].name_player
            cell1.clubLb.text = self.goalKeepersCopy[indexPath.row - 1].team
            let price = self.goalKeepersCopy[indexPath.row - 1].cost_player
            if let playerPrice = price {
                cell1.buyCost.text = String(playerPrice)
            }
            let points = self.goalKeepersCopy[indexPath.row - 1].point_player
            if let playerPoints = points {
                cell1.pointsLbl.text = String(playerPoints)
            }
            return cell1
        } else if indexPath.row == self.goalKeepersCopy.count + 1{
            cell2.positionLbl.text = "Defender".localized
            cell2.contentView.backgroundColor = Color.defender.value
            return cell2
        }else if indexPath.row > self.goalKeepersCopy.count + 1 && indexPath.row <= self.goalKeepersCopy.count + self.defendersCopy.count + 1 {
            let index = indexPath.row - self.goalKeepersCopy.count - 2
            cell1.nameLbl.text = self.defendersCopy[indexPath.row - self.goalKeepersCopy.count - 2].name_player
            cell1.clubLb.text = self.defendersCopy[indexPath.row - self.goalKeepersCopy.count - 2].team
            let price = self.defendersCopy[indexPath.row - self.goalKeepersCopy.count - 2].cost_player
            if let playerPrice = price {
                cell1.buyCost.text = String(playerPrice)
            }
            let points = self.defendersCopy[indexPath.row - self.goalKeepersCopy.count - 2].point_player
            if let playerPoints = points {
                cell1.pointsLbl.text = String(playerPoints)
            }
            return cell1
        }else if indexPath.row == self.goalKeepersCopy.count + self.defendersCopy.count + 2{
            cell2.positionLbl.text = "Mid".localized
            cell2.contentView.backgroundColor = Color.mid.value
            return cell2
        }else if indexPath.row > (self.goalKeepersCopy.count + self.defendersCopy.count + 2) && indexPath.row <= self.goalKeepersCopy.count + self.defendersCopy.count + self.midsCopy.count + 2 {
            let index = indexPath.row - self.goalKeepersCopy.count - self.defendersCopy.count - 3
            cell1.nameLbl.text = self.midsCopy[indexPath.row - self.goalKeepersCopy.count - self.defendersCopy.count - 3].name_player
            cell1.clubLb.text = self.midsCopy[indexPath.row - self.goalKeepersCopy.count - self.defendersCopy.count - 3].team
            let price = self.midsCopy[indexPath.row - self.goalKeepersCopy.count - self.defendersCopy.count - 3].cost_player
            if let playerPrice = price {
                cell1.buyCost.text = String(playerPrice)
            }
            let points = self.midsCopy[indexPath.row - self.goalKeepersCopy.count - self.defendersCopy.count - 3].point_player
            if let playerPoints = points {
                cell1.pointsLbl.text = String(playerPoints)
            }
            return cell1
        }else if indexPath.row == (self.goalKeepersCopy.count + self.defendersCopy.count + self.midsCopy.count + 3){
            cell2.positionLbl.text = "Attacker".localized
            cell2.contentView.backgroundColor = Color.attacker.value
            return cell2
        }else {
            let index = indexPath.row - self.goalKeepersCopy.count - self.defendersCopy.count - self.midsCopy.count - 4
            cell1.nameLbl.text = self.attackersCopy[indexPath.row - self.goalKeepersCopy.count - self.defendersCopy.count - self.midsCopy.count - 4].name_player
            cell1.clubLb.text = self.attackersCopy[indexPath.row - self.goalKeepersCopy.count - self.defendersCopy.count - self.midsCopy.count - 4].team
            let price = self.attackersCopy[indexPath.row - self.goalKeepersCopy.count - self.defendersCopy.count - self.midsCopy.count - 4].cost_player
            if let playerPrice = price {
                cell1.buyCost.text = String(playerPrice)
            }
            let points = self.attackersCopy[indexPath.row - self.goalKeepersCopy.count - self.defendersCopy.count - self.midsCopy.count - 4].point_player
            if let playerPoints = points {
                cell1.pointsLbl.text = String(playerPoints)
            }
            return cell1
        }
    }
    
    
    func getMyTeam(type : Int){
        presenter.getMyTeam( type: type, onSuccess: { (goalKeepers, defenders, mids, attackers, numPlayers, remainGold, totalGold) in
            self.hideLoader()
            self.goalKeepers = goalKeepers
            self.defenders = defenders
            self.mids = mids
            self.attackers = attackers
            
            self.goalKeepersCopy = goalKeepers
            self.defendersCopy = defenders
            self.midsCopy = mids
            self.attackersCopy = attackers
            
            self.remainingMoney = remainGold
            self.totalMoney = Double(totalGold)
            let remainG = Double(round(10*remainGold)/10)
            self.remainCostLabel.text = String(remainG)
            self.numPlayerLabel.text = String(numPlayers) + " / " + "15"
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
            self.fillView ()
        }) { (errorMessage, code) in
            self.hideLoader()
            if code == 11 ||  code == 41{
                let loginVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                self.navigationController?.pushViewController(loginVC, animated: true)
            }else {
                self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
            }
        }
    }
    func fillView (){
        let goalKeeper1 = self.goalKeepersCopy[0]
        let goalKeeper2 = self.goalKeepersCopy[1]
        
        if goalKeeper1.found_player == 1 {
            self.goalKeeperLbl1.text = goalKeeper1.name_player
            self.goalKeeperCostLbl1.text = String(goalKeeper1.cost_player ?? 0)
            self.goalKeeperBT1.sd_setImage(with: URL(string:Urls.baseUrl + goalKeeper1.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt1")
            if isDelete == 1 {
                self.goalKeeperBT1.alpha = 0.5
            }
        }else {
            resetBT(label: self.goalKeeperLbl1, costLbl: goalKeeperCostLbl1,bt: self.goalKeeperBT1, btTitle: "GoalKeeper".localized)
        }
        if goalKeeper2.found_player == 1 {
            self.goalKeeperLbl2.text = goalKeeper2.name_player
            self.goalKeeperCostLbl2.text = String(goalKeeper1.cost_player ?? 0)
            self.goalKeeperBT2.sd_setImage(with: URL(string:Urls.baseUrl + goalKeeper2.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt2")
            if isDelete == 1 {
                self.goalKeeperBT2.alpha = 0.5
            }
        }else {
            resetBT(label: self.goalKeeperLbl2, costLbl: goalKeeperCostLbl2,bt: self.goalKeeperBT2, btTitle: "GoalKeeper".localized)
            
        }
        
        let defender1 = self.defendersCopy[0]
        let defender2 = self.defendersCopy[1]
        let defender3 = self.defendersCopy[2]
        let defender4 = self.defendersCopy[3]
        let defender5 = self.defendersCopy[4]
        
        if defender1.found_player == 1 {
            self.defenderLbl1.text = defender1.name_player
            self.defenderCostLbl1.text = String(goalKeeper1.cost_player ?? 0)
            self.defenderBT1.sd_setImage(with: URL(string:Urls.baseUrl + defender1.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt3")
            if isDelete == 1 {
                self.defenderBT1.alpha = 0.5
            }else {self.defenderBT1.alpha = 1.0}
        }else {
            resetBT(label: self.defenderLbl1, costLbl: defenderCostLbl1,bt: self.defenderBT1, btTitle: "Defender".localized)
            
        }
        if defender2.found_player == 1 {
            self.defenderLbl2.text = defender2.name_player
            self.defenderCostLbl2.text = String(goalKeeper1.cost_player ?? 0)
            self.defenderBT2.sd_setImage(with: URL(string:Urls.baseUrl + defender2.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt4")
            if isDelete == 1 {
                self.defenderBT2.alpha = 0.5
            }
        }else {
            resetBT(label: self.defenderLbl2, costLbl: defenderCostLbl2,bt: self.defenderBT2, btTitle: "Defender".localized)
        }
        if defender3.found_player == 1 {
            self.defenderLbl3.text = defender3.name_player
            self.defenderCostLbl3.text = String(goalKeeper1.cost_player ?? 0)
            self.defenderBT3.sd_setImage(with: URL(string:Urls.baseUrl + defender3.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt5")
            if isDelete == 1 {
                self.defenderBT3.alpha = 0.5
            }
        }else {
            resetBT(label: self.defenderLbl3, costLbl: defenderCostLbl3,bt: self.defenderBT3, btTitle: "Defender".localized)
        }
        if defender4.found_player == 1 {
            self.defenderLbl4.text = defender4.name_player
            self.defenderCostLbl4.text = String(goalKeeper1.cost_player ?? 0)
            self.defenderBT4.sd_setImage(with: URL(string:Urls.baseUrl + defender4.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt6")
            if isDelete == 1 {
                self.defenderBT4.alpha = 0.5
            }
        }else {
            resetBT(label: self.defenderLbl4, costLbl: defenderCostLbl4,bt: self.defenderBT4, btTitle: "Defender".localized)
        }
        if defender5.found_player == 1 {
            self.defenderLbl5.text = defender5.name_player
            self.defenderCostLbl5.text = String(goalKeeper1.cost_player ?? 0)
            self.defenderBT5.sd_setImage(with: URL(string:Urls.baseUrl + defender5.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt7")
            if isDelete == 1 {
                self.defenderBT5.alpha = 0.5
            }
        }else {
            resetBT(label: self.defenderLbl5, costLbl: defenderCostLbl5,bt: self.defenderBT5, btTitle: "Defender".localized)
        }
        
        let mid1 = self.midsCopy[0]
        let mid2 = self.midsCopy[1]
        let mid3 = self.midsCopy[2]
        let mid4 = self.midsCopy[3]
        let mid5 = self.midsCopy[4]
        
        if mid1.found_player == 1 {
            self.midLbl1.text = mid1.name_player
            self.midCostLbl1.text = String(goalKeeper1.cost_player ?? 0)
            self.midBT1.sd_setImage(with: URL(string:Urls.baseUrl + mid1.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt8")
            if isDelete == 1 {
                self.midBT1.alpha = 0.5
            }
        }else {
            resetBT(label: self.midLbl1, costLbl: midCostLbl1,bt: self.midBT1, btTitle: "Mid".localized)
        }
        if mid2.found_player == 1 {
            self.midLbl2.text = mid2.name_player
            self.midCostLbl2.text = String(goalKeeper1.cost_player ?? 0)
            self.midBT2.sd_setImage(with: URL(string:Urls.baseUrl + mid2.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt9")
            if isDelete == 1 {
                self.midBT2.alpha = 0.5
            }
        }else {
            resetBT(label: self.midLbl2, costLbl: midCostLbl2,bt: self.midBT2, btTitle: "Mid".localized)
        }
        if mid3.found_player == 1 {
            self.midLbl3.text = mid3.name_player
            self.midCostLbl3.text = String(goalKeeper1.cost_player ?? 0)
            self.midBT3.sd_setImage(with: URL(string:Urls.baseUrl + mid3.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt10")
            if isDelete == 1 {
                self.midBT3.alpha = 0.5
            }
        }else {
            resetBT(label: self.midLbl3, costLbl: midCostLbl3,bt: self.midBT3, btTitle: "Mid".localized)
        }
        if mid4.found_player == 1 {
            self.midLbl4.text = mid4.name_player
            self.midCostLbl4.text = String(goalKeeper1.cost_player ?? 0)
            self.midBT4.sd_setImage(with: URL(string:Urls.baseUrl + mid4.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt11")
            if isDelete == 1 {
                self.midBT4.alpha = 0.5
            }
        }else {
            resetBT(label: self.midLbl4, costLbl: midCostLbl4,bt: self.midBT4, btTitle: "Mid".localized)
        }
        if mid5.found_player == 1 {
            self.midLbl5.text = mid5.name_player
            self.midCostLbl5.text = String(goalKeeper1.cost_player ?? 0)
            self.midBT5.sd_setImage(with: URL(string:Urls.baseUrl + mid5.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt12")
            if isDelete == 1 {
                self.midBT5.alpha = 0.5
            }
        }else {
            resetBT(label: self.midLbl5, costLbl: midCostLbl5,bt: self.midBT5, btTitle: "Mid".localized)
        }
        
        let attacker1 = self.attackersCopy[0]
        let attacker2 = self.attackersCopy[1]
        let attacker3 = self.attackersCopy[2]
        
        if attacker1.found_player == 1 {
            self.attackerLbl1.text = attacker1.name_player
            self.attackerCostLbl1.text = String(goalKeeper1.cost_player ?? 0)
            self.attackerBT1.sd_setImage(with: URL(string:Urls.baseUrl + attacker1.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt13")
            if isDelete == 1 {
                self.attackerBT1.alpha = 0.5
            }
        }else {
            resetBT(label: self.attackerLbl1, costLbl: attackerCostLbl1,bt: self.attackerBT1, btTitle: "Attacker".localized)
        }
        if attacker2.found_player == 1 {
            self.attackerLbl2.text = attacker2.name_player
            self.attackerCostLbl2.text = String(goalKeeper1.cost_player ?? 0)
            self.attackerBT2.sd_setImage(with: URL(string:Urls.baseUrl + attacker2.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt14")
            if isDelete == 1 {
                self.attackerBT2.alpha = 0.5
            }
        }else {
            resetBT(label: self.attackerLbl2, costLbl: attackerCostLbl2,bt: self.attackerBT2, btTitle: "Attacker".localized)
        }
        if attacker3.found_player == 1 {
            self.attackerLbl3.text = attacker3.name_player
            self.attackerCostLbl3.text = String(goalKeeper1.cost_player ?? 0)
            self.attackerBT3.sd_setImage(with: URL(string:Urls.baseUrl + attacker3.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt15")
            if isDelete == 1 {
                self.attackerBT3.alpha = 0.5
            }
        }else {
            resetBT(label: self.attackerLbl3,costLbl: attackerCostLbl3, bt: self.attackerBT3, btTitle: "Attacker".localized)
        }
    }
    func resetBT (label : UILabel, costLbl: UILabel, bt : UIButton, btTitle : String){
        label.text = btTitle
        costLbl.text = "0"
        bt.setImage(UIImage(named: "add_player"), for: .normal)
        bt.alpha = 1
    }
    func openPlayerVC (playerType : String){
        let playersByTypeVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "PlayersByTypeVC") as! PlayersByTypeVC
        playersByTypeVC.type = playerType
        playersByTypeVC.listener = self
        if pageType == 0 {playersByTypeVC.isTransferes = false }else {playersByTypeVC.isTransferes = true}
        self.navigationController?.pushViewController(playersByTypeVC, animated: true)
    }
}

extension PitchVC : DetailsOrDeletePopUpDelegate, playerDeletedDelegate, replacementListenner, PayementSuccessDelegate {
    func PayementSuccess(message : String) {
        showAlert(title: "", message: message, shouldpop: false)
    }
    
    func openPlayerDetails(fromPitch: Bool, player: MyTeam) {
        playerDetailsAction (fromPitch: fromPitch, player: player)
    }
    func playerDetails(fromPitch: Bool, player: MyTeam) {
        playerDetailsAction (fromPitch: fromPitch, player: player)
    }
    func playerDetailsAction (fromPitch: Bool, player: MyTeam){
        let playerDetailsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "PlayerDetailsVC") as! PlayerDetailsVC
        playerDetailsVC.fromPitch = fromPitch
        playerDetailsVC.team = player
        navigationController?.pushViewController(playerDetailsVC, animated: false)
    }
    
    func subIsSuccess() {
        self.showAlert(title: "", message: "تم التبديل بنجاح", shouldpop: false)
        self.saveBT.isEnabled = false
        self.saveBT.alpha = 0.5
        if isNetworkReachable{
            getMyTeam(type: 0)
        }else{
            self.showAlert(title: "", message: "Internet is not available", shouldpop: true)
        }
    }
    
    func returnPlayer(player: Player, index: Int, playerType: String, bt: UIButton, btName : String) {
        let playerID = player.id
        self.saveBT.isEnabled = true
        self.saveBT.alpha = 1.0
        UserDefaults.standard.set(0, forKey: btName)
        bt.alpha = 1.0
        let newPlayer = MyTeam(found_player: 1, name_player: player.name ?? "", link_player: player.link ?? "", image_player: player.image ?? "", team: player.team ?? "", location_player: player.location_player ?? "", type_loc_player: playerType , player_id: player.id ?? 0, cost_player: player.cost ?? 0, eldwry_link: player.eldwry_link ?? "")
        var originalIndex = 0
        if playerType == "goalkeeper"{
            goalKeepersCopy.remove(at: index)
            goalKeepersCopy.insert(newPlayer, at: index)
            
            for n in 0...self.goalKeepers.count-1 {
                if goalKeepers[n].player_id == playerID {
                    originalIndex = n
                    break
                    
                }
            }
            
            if goalKeepers[originalIndex].player_id == playerID {
                setNewRemainingMoneyForCase(players : goalKeepers, playersCopy : goalKeepersCopy, player : newPlayer, index : index, n : originalIndex)
                let playerAtIndex = goalKeepersCopy[originalIndex]
                goalKeepersCopy.remove(at: originalIndex)
                goalKeepersCopy.insert(self.goalKeepers[originalIndex], at: originalIndex)
                goalKeepersCopy.remove(at: index)
                goalKeepersCopy.insert(playerAtIndex, at: index)
            }else{
                setNewRemainingMoney(players : goalKeepersCopy, player : newPlayer, index : index)
                goalKeepersCopy.remove(at: index)
                goalKeepersCopy.insert(newPlayer, at: index)
            }
            
        }else if playerType == "defender" {
            for n in 0...self.defenders.count-1 {
                if self.defenders[n].player_id == playerID {
                    originalIndex = n
                    break
                }
                
            }
            if self.defenders[originalIndex].player_id == playerID {
                setNewRemainingMoneyForCase(players : defenders, playersCopy : defendersCopy, player : newPlayer, index : index, n : originalIndex)
                let playerAtIndex = defendersCopy[originalIndex]
                defendersCopy.remove(at: originalIndex)
                defendersCopy.insert(self.defenders[originalIndex], at: originalIndex)
                defendersCopy.remove(at: index)
                defendersCopy.insert(playerAtIndex, at: index)
            }else{
                setNewRemainingMoney(players : defendersCopy, player : newPlayer, index : index)
                defendersCopy.remove(at: index)
                defendersCopy.insert(newPlayer, at: index)
            }
        }else if playerType == "line"{
            for n in 0...self.mids.count-1 {
                if mids[n].player_id == playerID {
                    originalIndex = n
                    break
                }
            }
            if mids[originalIndex].player_id == playerID {
                setNewRemainingMoneyForCase(players : mids, playersCopy : midsCopy, player : newPlayer, index : index, n : originalIndex)
                let playerAtIndex = midsCopy[originalIndex]
                midsCopy.remove(at: originalIndex)
                midsCopy.insert(self.mids[originalIndex], at: originalIndex)
                midsCopy.remove(at: index)
                midsCopy.insert(playerAtIndex, at: index)
            }else{
                setNewRemainingMoney(players : midsCopy, player : newPlayer, index : index)
                midsCopy.remove(at: index)
                midsCopy.insert(newPlayer, at: index)
            }
        }else if playerType == "attacker"{
            
            for n in 0...self.attackers.count-1 {
                if attackers[n].player_id == playerID {
                    originalIndex = n
                    break
                }
            }
            if attackers[originalIndex].player_id == playerID {
                setNewRemainingMoneyForCase(players : attackers, playersCopy : attackersCopy, player : newPlayer, index : index, n : originalIndex)
                let playerAtIndex = attackersCopy[originalIndex]
                attackersCopy.remove(at: originalIndex)
                attackersCopy.insert(self.attackers[originalIndex], at: originalIndex)
                attackersCopy.remove(at: index)
                attackersCopy.insert(playerAtIndex, at: index)
            }else{
                setNewRemainingMoney(players : attackersCopy, player : newPlayer, index : index)
                attackersCopy.remove(at: index)
                attackersCopy.insert(newPlayer, at: index)
            }
        }
        fillView()
    }
    
    func setNewRemainingMoney(players : [MyTeam], player : MyTeam, index : Int){
        let costDeference = (players[index].cost_player ?? 0) - (player.cost_player ?? 0)
        remainingMoney = remainingMoney + Double(costDeference)
        remainCostLabel.text = String(remainingMoney)
    }
    
    func setNewRemainingMoneyForCase(players : [MyTeam], playersCopy : [MyTeam], player : MyTeam, index : Int, n :Int){
        let originalPlayerCost = players[n].cost_player ?? 0
        let firstPlayerCost = playersCopy[n].cost_player ?? 0
        let deference = originalPlayerCost - firstPlayerCost
        remainingMoney = remainingMoney + (-0.1 * Double(deference))
        let newPlayerCost = player.cost_player ?? 0
        let newDeference = newPlayerCost - firstPlayerCost
        remainingMoney = Double(remainingMoney) + Double(newDeference)
        remainCostLabel.text = String(remainingMoney)
    }
    
    func showPlayer(bt: UIButton) {
        
    }
    
    func showMessage(message: String){
        self.showAlert(title: "", message: message, shouldpop: false)
    }
    
    func replacePlayer(player : MyTeam, index: Int, playerType: String,listener: replacementListenner, bt : UIButton, btName : String, delegate : playerDeletedDelegate) {
        let playersByTypeVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "PlayersByTypeVC") as! PlayersByTypeVC
        playersByTypeVC.type = player.type_loc_player
        playersByTypeVC.isReplace = true
        playersByTypeVC.eldawry_link = player.eldwry_link!
        playersByTypeVC.deleted_player_link = player.link_player!
        playersByTypeVC.index = index
        playersByTypeVC.playerType = playerType
        playersByTypeVC.bt = bt
        playersByTypeVC.btName = btName
        playersByTypeVC.delegate = delegate
        playersByTypeVC.listener = listener
        if player.type_loc_player == "goalkeeper"{
            playersByTypeVC.localPlayers = self.goalKeepersCopy
            playersByTypeVC.oldLink = self.goalKeepers[index].link_player ?? ""
        }else if player.type_loc_player == "defender" {
            playersByTypeVC.localPlayers = self.defendersCopy
            playersByTypeVC.oldLink = self.defenders[index].link_player ?? ""
        }else if player.type_loc_player == "line"{
            playersByTypeVC.localPlayers = self.midsCopy
            playersByTypeVC.oldLink = self.mids[index].link_player ?? ""
        }else if player.type_loc_player == "attacker"{
            playersByTypeVC.localPlayers = self.attackersCopy
            playersByTypeVC.oldLink = self.attackers[index].link_player ?? ""
        }
        
        if pageType == 0 {playersByTypeVC.isTransferes = false }else {playersByTypeVC.isTransferes = true}
        self.navigationController?.pushViewController(playersByTypeVC, animated: true)
        
    }
    
    func getPlayerBack(bt: UIButton) {
        bt.alpha = 1
    }
    
    func playerDeleted(message: String) {
        self.showAlert(title: "", message: message, shouldpop: false)
        getMyTeam(type: 0)
    }
    
    func checkDelete (btName : String) {
        if btName == "bt1" {
            self.goalKeeperBT1.alpha = 0.5
            UserDefaults.standard.set(1, forKey: btName)
        }else if btName == "bt2" {
            self.goalKeeperBT2.alpha = 0.5
            UserDefaults.standard.set(1, forKey: btName)
        }else if btName == "bt3" {
            self.defenderBT1.alpha = 0.5
            UserDefaults.standard.set(1, forKey: btName)
        }else if btName == "bt4" {
            self.defenderBT2.alpha = 0.5
            UserDefaults.standard.set(1, forKey: btName)
        }else if btName == "bt5" {
            self.defenderBT3.alpha = 0.5
            UserDefaults.standard.set(1, forKey: btName)
        }else if btName == "bt6" {
            self.defenderBT4.alpha = 0.5
            UserDefaults.standard.set(1, forKey: btName)
        }else if btName == "bt7" {
            self.defenderBT5.alpha = 0.5
            UserDefaults.standard.set(1, forKey: btName)
        }else if btName == "bt8" {
            self.midBT1.alpha = 0.5
            UserDefaults.standard.set(1, forKey: btName)
        }else if btName == "bt9" {
            self.midBT2.alpha = 0.5
            UserDefaults.standard.set(1, forKey: btName)
        }else if btName == "bt10" {
            self.midBT3.alpha = 0.5
            UserDefaults.standard.set(1, forKey: btName)
        }else if btName == "bt11" {
            self.midBT4.alpha = 0.5
            UserDefaults.standard.set(1, forKey: btName)
        }else if btName == "bt12" {
            self.midBT5.alpha = 0.5
            UserDefaults.standard.set(1, forKey: btName)
        }else if btName == "bt13" {
            self.attackerBT1.alpha = 0.5
            UserDefaults.standard.set(1, forKey: btName)
        }else if btName == "bt14" {
            self.attackerBT2.alpha = 0.5
            UserDefaults.standard.set(1, forKey: btName)
        }else if btName == "bt15" {
            self.attackerBT3.alpha = 0.5
            UserDefaults.standard.set(1, forKey: btName)
        }
    }
    
}


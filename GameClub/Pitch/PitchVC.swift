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
    var pageType = 0
    
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
        foundPlayerOptions(player: self.goalKeepers, index: 0, stringValue: "goalkeeper", screenPosition: "bt1", bt : self.goalKeeperBT1)
    }
    @IBAction func pickGoalKeeperAction2(_ sender: Any) {
        foundPlayerOptions(player: self.goalKeepers, index: 1, stringValue: "goalkeeper", screenPosition: "bt2", bt: self.goalKeeperBT2)
    }
    @IBAction func pickDefenderAction1(_ sender: Any) {
        foundPlayerOptions(player: self.defenders, index: 0, stringValue: "defender", screenPosition: "bt3", bt: self.defenderBT1)
    }
    @IBAction func pickDefenderAction2(_ sender: Any) {
        foundPlayerOptions(player: self.defenders, index: 1, stringValue: "defender", screenPosition: "bt4", bt: self.defenderBT2)
    }
    @IBAction func pickDefenderAction3(_ sender: Any) {
        foundPlayerOptions(player: self.defenders, index: 2, stringValue: "defender", screenPosition: "bt5", bt: self.defenderBT3)
    }
    @IBAction func pickDefenderAction4(_ sender: Any) {
        foundPlayerOptions(player: self.defenders, index: 3, stringValue: "defender", screenPosition: "bt6", bt: self.defenderBT4)
    }
    @IBAction func pickDefenderAction5(_ sender: Any) {
        foundPlayerOptions(player: self.defenders, index: 4, stringValue: "defender", screenPosition: "bt7", bt: self.defenderBT5)
    }
    @IBAction func pickMidAction1(_ sender: Any) {
        foundPlayerOptions(player: self.mids, index: 0, stringValue: "line", screenPosition: "bt8", bt: self.midBT1)
    }
    @IBAction func pickMidAction2(_ sender: Any) {
        foundPlayerOptions(player: self.mids, index: 1, stringValue: "line", screenPosition: "bt9", bt: self.midBT2)
    }
    @IBAction func pickMidAction3(_ sender: Any) {
        foundPlayerOptions(player: self.mids, index: 2, stringValue: "line", screenPosition: "bt10", bt: self.midBT3)
    }
    @IBAction func pickMidAction4(_ sender: Any) {
        foundPlayerOptions(player: self.mids, index: 3, stringValue: "line", screenPosition: "bt11", bt: self.midBT4)
    }
    @IBAction func pickMidAction5(_ sender: Any) {
        foundPlayerOptions(player: self.mids, index: 4, stringValue: "line", screenPosition: "bt12", bt: self.midBT5)
    }
    @IBAction func pickAttackerAction1(_ sender: Any) {
        foundPlayerOptions(player: self.attackers, index: 0, stringValue: "attacker", screenPosition: "bt13", bt: self.attackerBT1)
    }
    @IBAction func pickAttackerAction2(_ sender: Any) {
        foundPlayerOptions(player: self.attackers, index: 1, stringValue: "attacker", screenPosition: "bt14", bt: self.attackerBT2)
    }
    @IBAction func pickAttackerAction3(_ sender: Any) {
        foundPlayerOptions(player: self.attackers, index: 2, stringValue: "attacker", screenPosition: "bt15", bt: self.attackerBT3)
    }
    
    func foundPlayerOptions (player : [MyTeam], index : Int, stringValue : String, screenPosition : String, bt : UIButton){
        if player[index].found_player == 1{
            let isDelete = UserDefaults.standard.integer(forKey: screenPosition)
            if isDelete == 1 {
                let popUpVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "DeletedPlayerOptionsPopUp") as! DeletedPlayerOptionsPopUp
                popUpVC.btName = screenPosition
                popUpVC.delegate = self
                popUpVC.player = player[index]
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
        let popUpVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "NameTeamPopUp") as! NameTeamPopUp
               present(popUpVC, animated: true
                   , completion: nil)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        if pageType == 1 {self.autoSelectView.isHidden = true
            self.freeTransView.isHidden = false}
        resetBTs()
        viewConfig()
            }
    override func viewWillAppear(_ animated: Bool) {
        getMyTeam(type: 0)
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
            cell2.positionLbl.text = "حارس مرمى"
            cell2.contentView.backgroundColor = Color.goalKeeper.value
            return cell2
        }else if indexPath.row > 0 && indexPath.row <= self.goalKeepers.count{
            let index = indexPath.row - 1
            cell1.nameLbl.text = self.goalKeepers[indexPath.row - 1].name_player
            cell1.clubLb.text = self.goalKeepers[indexPath.row - 1].team
            let price = self.goalKeepers[indexPath.row - 1].cost_player
            if let playerPrice = price {
                cell1.buyCost.text = String(playerPrice)
            }
            let points = self.goalKeepers[indexPath.row - 1].point_player
            if let playerPoints = points {
                cell1.pointsLbl.text = String(playerPoints)
            }
            return cell1
        } else if indexPath.row == self.goalKeepers.count + 1{
            cell2.positionLbl.text = "دفاع"
            cell2.contentView.backgroundColor = Color.defender.value
            return cell2
        }else if indexPath.row > self.goalKeepers.count + 1 && indexPath.row <= self.goalKeepers.count + self.defenders.count + 1 {
            let index = indexPath.row - self.goalKeepers.count - 2
            cell1.nameLbl.text = self.defenders[indexPath.row - self.goalKeepers.count - 2].name_player
            cell1.clubLb.text = self.defenders[indexPath.row - self.goalKeepers.count - 2].team
            let price = self.defenders[indexPath.row - self.goalKeepers.count - 2].cost_player
            if let playerPrice = price {
                cell1.buyCost.text = String(playerPrice)
            }
            let points = self.defenders[indexPath.row - self.goalKeepers.count - 2].point_player
            if let playerPoints = points {
                cell1.pointsLbl.text = String(playerPoints)
            }
            return cell1
        }else if indexPath.row == self.goalKeepers.count + self.defenders.count + 2{
            cell2.positionLbl.text = "خط وسط"
            cell2.contentView.backgroundColor = Color.mid.value
            return cell2
        }else if indexPath.row > (self.goalKeepers.count + self.defenders.count + 2) && indexPath.row <= self.goalKeepers.count + self.defenders.count + self.mids.count + 2 {
            let index = indexPath.row - self.goalKeepers.count - self.defenders.count - 3
            cell1.nameLbl.text = self.mids[indexPath.row - self.goalKeepers.count - self.defenders.count - 3].name_player
            cell1.clubLb.text = self.mids[indexPath.row - self.goalKeepers.count - self.defenders.count - 3].team
            let price = self.mids[indexPath.row - self.goalKeepers.count - self.defenders.count - 3].cost_player
            if let playerPrice = price {
                cell1.buyCost.text = String(playerPrice)
            }
            let points = self.mids[indexPath.row - self.goalKeepers.count - self.defenders.count - 3].point_player
            if let playerPoints = points {
                cell1.pointsLbl.text = String(playerPoints)
            }
            return cell1
        }else if indexPath.row == (self.goalKeepers.count + self.defenders.count + self.mids.count + 3){
            cell2.positionLbl.text = "هجوم"
            cell2.contentView.backgroundColor = Color.attacker.value
            return cell2
        }else {
            let index = indexPath.row - self.goalKeepers.count - self.defenders.count - self.mids.count - 4
            cell1.nameLbl.text = self.attackers[indexPath.row - self.goalKeepers.count - self.defenders.count - self.mids.count - 4].name_player
            cell1.clubLb.text = self.attackers[indexPath.row - self.goalKeepers.count - self.defenders.count - self.mids.count - 4].team
            let price = self.attackers[indexPath.row - self.goalKeepers.count - self.defenders.count - self.mids.count - 4].cost_player
            if let playerPrice = price {
                cell1.buyCost.text = String(playerPrice)
            }
            let points = self.attackers[indexPath.row - self.goalKeepers.count - self.defenders.count - self.mids.count - 4].point_player
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
            let remainG = Double(round(10*remainGold)/10)
            self.remainCostLabel.text = String(remainG) + " / " + String(totalGold)
            self.numPlayerLabel.text = String(numPlayers) + " / " + "15"
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
            self.fillView ()
        }) { (errorMessage, code) in
            self.hideLoader()
            if code == 11 ||  code == 41{
                let noTeamVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "NoTeamVC") as! NoTeamVC
                noTeamVC.isLogin = true
                self.navigationController?.pushViewController(noTeamVC, animated: true)
            }else {
                self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
            }
        }
    }
    func fillView (){
        let goalKeeper1 = self.goalKeepers[0]
        let goalKeeper2 = self.goalKeepers[1]

        if goalKeeper1.found_player == 1 {
            self.goalKeeperLbl1.text = goalKeeper1.name_player
            self.goalKeeperBT1.sd_setImage(with: URL(string:Urls.baseUrl + goalKeeper1.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt1")
            if isDelete == 1 {
                self.goalKeeperBT1.alpha = 0.5
            }
        }else {
            resetBT(label: self.goalKeeperLbl1, bt: self.goalKeeperBT1, btTitle: "حارس مرمى")
        }
        if goalKeeper2.found_player == 1 {
            self.goalKeeperLbl2.text = goalKeeper2.name_player
            self.goalKeeperBT2.sd_setImage(with: URL(string:Urls.baseUrl + goalKeeper2.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt2")
            if isDelete == 1 {
                self.goalKeeperBT2.alpha = 0.5
            }
        }else {
            resetBT(label: self.goalKeeperLbl2, bt: self.goalKeeperBT2, btTitle: "حارس مرمى")

        }
        
        let defender1 = self.defenders[0]
        let defender2 = self.defenders[1]
        let defender3 = self.defenders[2]
        let defender4 = self.defenders[3]
        let defender5 = self.defenders[4]

        if defender1.found_player == 1 {
            self.defenderLbl1.text = defender1.name_player
            self.defenderBT1.sd_setImage(with: URL(string:Urls.baseUrl + defender1.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt3")
            if isDelete == 1 {
                self.defenderBT1.alpha = 0.5
            }
        }else {
            resetBT(label: self.defenderLbl1, bt: self.defenderBT1, btTitle: "مدافع")

        }
        if defender2.found_player == 1 {
            self.defenderLbl2.text = defender2.name_player
            self.defenderBT2.sd_setImage(with: URL(string:Urls.baseUrl + defender2.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt4")
            if isDelete == 1 {
                self.defenderBT2.alpha = 0.5
            }
        }else {
            resetBT(label: self.defenderLbl2, bt: self.defenderBT2, btTitle: "مدافع")
        }
        if defender3.found_player == 1 {
            self.defenderLbl3.text = defender3.name_player
            self.defenderBT3.sd_setImage(with: URL(string:Urls.baseUrl + defender3.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt5")
            if isDelete == 1 {
                self.defenderBT3.alpha = 0.5
            }
        }else {
            resetBT(label: self.defenderLbl3, bt: self.defenderBT3, btTitle: "مدافع")
        }
        if defender4.found_player == 1 {
            self.defenderLbl4.text = defender4.name_player
            self.defenderBT4.sd_setImage(with: URL(string:Urls.baseUrl + defender4.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt6")
            if isDelete == 1 {
                self.defenderBT4.alpha = 0.5
            }
        }else {
            resetBT(label: self.defenderLbl4, bt: self.defenderBT4, btTitle: "مدافع")
        }
        if defender5.found_player == 1 {
            self.defenderLbl5.text = defender5.name_player
            self.defenderBT5.sd_setImage(with: URL(string:Urls.baseUrl + defender5.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt7")
            if isDelete == 1 {
                self.defenderBT5.alpha = 0.5
            }
        }else {
            resetBT(label: self.defenderLbl5, bt: self.defenderBT5, btTitle: "مدافع")
        }
        
        let mid1 = self.mids[0]
        let mid2 = self.mids[1]
        let mid3 = self.mids[2]
        let mid4 = self.mids[3]
        let mid5 = self.mids[4]
        
        if mid1.found_player == 1 {
            self.midLbl1.text = mid1.name_player
            self.midBT1.sd_setImage(with: URL(string:Urls.baseUrl + mid1.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt8")
            if isDelete == 1 {
                self.midBT1.alpha = 0.5
            }
        }else {
            resetBT(label: self.midLbl1, bt: self.midBT1, btTitle: "خط وسط")
        }
        if mid2.found_player == 1 {
            self.midLbl2.text = mid2.name_player
            self.midBT2.sd_setImage(with: URL(string:Urls.baseUrl + mid2.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt9")
            if isDelete == 1 {
                self.midBT2.alpha = 0.5
            }
        }else {
            resetBT(label: self.midLbl2, bt: self.midBT2, btTitle: "خط وسط")
        }
        if mid3.found_player == 1 {
            self.midLbl3.text = mid3.name_player
            self.midBT3.sd_setImage(with: URL(string:Urls.baseUrl + mid3.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt10")
            if isDelete == 1 {
                self.midBT3.alpha = 0.5
            }
        }else {
            resetBT(label: self.midLbl3, bt: self.midBT3, btTitle: "خط وسط")
        }
        if mid4.found_player == 1 {
            self.midLbl4.text = mid4.name_player
            self.midBT4.sd_setImage(with: URL(string:Urls.baseUrl + mid4.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt11")
            if isDelete == 1 {
                self.midBT4.alpha = 0.5
            }
        }else {
            resetBT(label: self.midLbl4, bt: self.midBT4, btTitle: "خط وسط")
        }
        if mid5.found_player == 1 {
            self.midLbl5.text = mid5.name_player
            self.midBT5.sd_setImage(with: URL(string:Urls.baseUrl + mid5.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt12")
            if isDelete == 1 {
                self.midBT5.alpha = 0.5
            }
        }else {
            resetBT(label: self.midLbl5, bt: self.midBT5, btTitle: "خط وسط")
        }
        
        let attacker1 = self.attackers[0]
        let attacker2 = self.attackers[1]
        let attacker3 = self.attackers[2]

        if attacker1.found_player == 1 {
            self.attackerLbl1.text = attacker1.name_player
            self.attackerBT1.sd_setImage(with: URL(string:Urls.baseUrl + attacker1.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt13")
            if isDelete == 1 {
                self.attackerBT1.alpha = 0.5
            }
        }else {
            resetBT(label: self.attackerLbl1, bt: self.attackerBT1, btTitle: "مهاجم")
        }
        if attacker2.found_player == 1 {
            self.attackerLbl2.text = attacker2.name_player
            self.attackerBT2.sd_setImage(with: URL(string:Urls.baseUrl + attacker2.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt14")
            if isDelete == 1 {
                self.attackerBT2.alpha = 0.5
            }
        }else {
            resetBT(label: self.attackerLbl2, bt: self.attackerBT2, btTitle: "مهاجم")
        }
        if attacker3.found_player == 1 {
            self.attackerLbl3.text = attacker3.name_player
            self.attackerBT3.sd_setImage(with: URL(string:Urls.baseUrl + attacker3.image_player!), for: .normal)
            let isDelete = UserDefaults.standard.integer(forKey: "bt15")
            if isDelete == 1 {
                self.attackerBT3.alpha = 0.5
            }
        }else {
            resetBT(label: self.attackerLbl3, bt: self.attackerBT3, btTitle: "مهاجم")
        }
    }
    func resetBT (label : UILabel, bt : UIButton, btTitle : String){
        label.text = btTitle
        bt.setImage(UIImage(named: "add_player"), for: .normal)
        bt.alpha = 1
    }
    func openPlayerVC (playerType : String){
        let playersByTypeVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "PlayersByTypeVC") as! PlayersByTypeVC
        playersByTypeVC.type = playerType
        playersByTypeVC.listener = self
        self.navigationController?.pushViewController(playersByTypeVC, animated: true)
    }
    
    func viewConfig(){
        roundViewCornersNoShadow(view: viewPitchBT)
        roundViewCornersNoShadow(view: viewListBT)
        roundViewCornersNoShadow(view: saveBT)
        roundViewCornersNoShadow(view: goalKeeperLbl1)
        roundViewCornersNoShadow(view: goalKeeperLbl2)
        roundViewCornersNoShadow(view: defenderLbl1)
        roundViewCornersNoShadow(view: defenderLbl2)
        roundViewCornersNoShadow(view: defenderLbl3)
        roundViewCornersNoShadow(view: defenderLbl4)
        roundViewCornersNoShadow(view: defenderLbl5)
        roundViewCornersNoShadow(view: midLbl1)
        roundViewCornersNoShadow(view: midLbl2)
        roundViewCornersNoShadow(view: midLbl3)
        roundViewCornersNoShadow(view: midLbl4)
        roundViewCornersNoShadow(view: midLbl5)
        roundViewCornersNoShadow(view: attackerLbl1)
        roundViewCornersNoShadow(view: attackerLbl2)
        roundViewCornersNoShadow(view: attackerLbl3)
    }
}
extension PitchVC : checkDeletePlayer, playerDeletedDelegate, replacementListenner {
    func showPlayer(bt: UIButton) {
        
    }
    
    func showMessage(message: String){
        self.showAlert(title: "", message: message, shouldpop: false)
    }
    
    func replacePlayer(player : MyTeam, bt : UIButton, btName : String, delegate : playerDeletedDelegate) {
        let playersByTypeVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "PlayersByTypeVC") as! PlayersByTypeVC
               playersByTypeVC.type = player.type_loc_player
               playersByTypeVC.isReplace = true
               playersByTypeVC.eldawry_link = player.eldwry_link!
               playersByTypeVC.deleted_player_link = player.link_player!
            playersByTypeVC.bt = bt
        playersByTypeVC.btName = btName
        playersByTypeVC.delegate = delegate
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
    func resetBTs () {
                UserDefaults.standard.set(0, forKey: "bt1")
                UserDefaults.standard.set(0, forKey: "bt2")
                UserDefaults.standard.set(0, forKey: "bt3")
                UserDefaults.standard.set(0, forKey: "bt4")
                UserDefaults.standard.set(0, forKey: "bt5")
                UserDefaults.standard.set(0, forKey: "bt6")
                UserDefaults.standard.set(0, forKey: "bt7")
                UserDefaults.standard.set(0, forKey: "bt8")
                UserDefaults.standard.set(0, forKey: "bt9")
                UserDefaults.standard.set(0, forKey: "bt10")
                UserDefaults.standard.set(0, forKey: "bt11")
                UserDefaults.standard.set(0, forKey: "bt12")
                UserDefaults.standard.set(0, forKey: "bt13")
                UserDefaults.standard.set(0, forKey: "bt14")
                UserDefaults.standard.set(0, forKey: "bt15")
    }
}


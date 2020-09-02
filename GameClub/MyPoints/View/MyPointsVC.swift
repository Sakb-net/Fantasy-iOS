//
//  MyPointsVC.swift
//  GameClub
//
//  Created by Basma on 4/18/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SideMenu

class MyPointsVC: ParentViewController {
    var presenter = PointsPresenter()
    var gameWeeks = [GWsPointsModel] ()
    
    var goalKeepers = [MyTeam]()
    var defenders = [MyTeam]()
    var mids = [MyTeam]()
    var attackers = [MyTeam]()
    var subs = [MyTeam]()
    var subsNotGoalkeeper = [MyTeam] ()
    var subGoalkeeper = [MyTeam] ()
    var subsTypes = [String]()
    var captin_icon = "c-icon"
    var assist_icon = "v-icon"
    var currentGWLink = ""
    
    @IBOutlet weak var gwView: UIView!
    @IBOutlet weak var gwLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var avgLbl: UILabel!
    @IBOutlet weak var highLbl: UILabel!
    @IBOutlet weak var gwRankLbl: UILabel!
    @IBOutlet weak var transfereLbl: UILabel!
    @IBOutlet weak var finalPointsLbl: UILabel!

    @IBOutlet weak var goalKeeperView: UIView!
    @IBOutlet weak var defendView1: UIView!
    @IBOutlet weak var defendView2: UIView!
    @IBOutlet weak var defendView3: UIView!
    @IBOutlet weak var defendView4: UIView!
    @IBOutlet weak var defendView5: UIView!
    @IBOutlet weak var midView1: UIView!
    @IBOutlet weak var midView2: UIView!
    @IBOutlet weak var midView3: UIView!
    @IBOutlet weak var midView4: UIView!
    @IBOutlet weak var midView5: UIView!
    @IBOutlet weak var attackView1: UIView!
    @IBOutlet weak var attackView2: UIView!
    @IBOutlet weak var attackView3: UIView!
    @IBOutlet weak var subView1: UIView!
    @IBOutlet weak var subView2: UIView!
    @IBOutlet weak var subView3: UIView!
    @IBOutlet weak var subView4: UIView!
    
    @IBOutlet weak var subBT1: UIButton!
    @IBOutlet weak var subBT2: UIButton!
    @IBOutlet weak var subBT3: UIButton!
    @IBOutlet weak var subBT4: UIButton!
       
    @IBOutlet weak var subNameLbl1: UILabel!
    @IBOutlet weak var subNameLbl2: UILabel!
    @IBOutlet weak var subNameLbl3: UILabel!
    @IBOutlet weak var subNameLbl4: UILabel!

    @IBOutlet weak var subPointsLbl1: UILabel!
    @IBOutlet weak var subPointsLbl2: UILabel!
    @IBOutlet weak var subPointsLbl3: UILabel!
    @IBOutlet weak var subPointsLbl4: UILabel!
       
    @IBOutlet weak var goalKeeperBT: UIButton!
    @IBOutlet weak var defendBT1: UIButton!
    @IBOutlet weak var defendBT2: UIButton!
    @IBOutlet weak var defendBT3: UIButton!
    @IBOutlet weak var defendBT4: UIButton!
    @IBOutlet weak var defendBT5: UIButton!
    @IBOutlet weak var midBT1: UIButton!
    @IBOutlet weak var midBT2: UIButton!
    @IBOutlet weak var midBT3: UIButton!
    @IBOutlet weak var midBT4: UIButton!
    @IBOutlet weak var midBT5: UIButton!
    @IBOutlet weak var attackBT1: UIButton!
    @IBOutlet weak var attackBT2: UIButton!
    @IBOutlet weak var attackBT3: UIButton!

    @IBOutlet weak var goalKeeperNameLbl: UILabel!
    @IBOutlet weak var defendLbl1: UILabel!
    @IBOutlet weak var defendLbl2: UILabel!
    @IBOutlet weak var defendLbl3: UILabel!
    @IBOutlet weak var defendLbl4: UILabel!
    @IBOutlet weak var defendLbl5: UILabel!
    @IBOutlet weak var midLbl1: UILabel!
    @IBOutlet weak var midLbl2: UILabel!
    @IBOutlet weak var midLbl3: UILabel!
    @IBOutlet weak var midLbl4: UILabel!
    @IBOutlet weak var midLbl5: UILabel!
    @IBOutlet weak var attackLbl1: UILabel!
    @IBOutlet weak var attackLbl2: UILabel!
    @IBOutlet weak var attackLbl3: UILabel!

    @IBOutlet weak var playerPointLbl: UILabel!
    @IBOutlet weak var defendPointLbl1: UILabel!
    @IBOutlet weak var defendPointLbl2: UILabel!
    @IBOutlet weak var defendPointLbl3: UILabel!
    @IBOutlet weak var defendPointLbl4: UILabel!
    @IBOutlet weak var defendPointLbl5: UILabel!
    @IBOutlet weak var midPointLbl1: UILabel!
    @IBOutlet weak var midPointLbl2: UILabel!
    @IBOutlet weak var midPointLbl3: UILabel!
    @IBOutlet weak var midPointLbl4: UILabel!
    @IBOutlet weak var midPointLbl5: UILabel!
    @IBOutlet weak var attackPointLbl1: UILabel!
    @IBOutlet weak var attackPointLbl2: UILabel!
    @IBOutlet weak var attackPointLbl3: UILabel!
       
    @IBOutlet weak var pitchBT: UIButton!
    @IBOutlet weak var listBT: UIButton!
       
    @IBAction func goalkeeperAction(_ sender: Any) {
        openPlayerDetails(index: 0, players: goalKeepers)
       }
    @IBAction func defendAction1(_ sender: Any) {
        openPlayerDetails(index: 0, players: defenders)
    }
    @IBAction func defendAction2(_ sender: Any) {
       openPlayerDetails(index: 1, players: defenders)
    }
    @IBAction func defendAction3(_ sender: Any) {
        openPlayerDetails(index: 2, players: defenders)
    }
    @IBAction func defendAction4(_ sender: Any) {
        openPlayerDetails(index: 3, players: defenders)
    }
    @IBAction func defendAction5(_ sender: Any) {
        openPlayerDetails(index: 4, players: defenders)
    }
    @IBAction func midAction1(_ sender: Any) {
        openPlayerDetails(index: 0, players: mids)
    }
    @IBAction func midAction2(_ sender: Any) {
        openPlayerDetails(index: 1, players: mids)
    }
    @IBAction func midAction3(_ sender: Any) {
        openPlayerDetails(index: 2, players: mids)
    }
    @IBAction func midAction4(_ sender: Any) {
        openPlayerDetails(index: 3, players: mids)
    }
    @IBAction func midAction5(_ sender: Any) {
        openPlayerDetails(index: 4, players: mids)
    }
    @IBAction func attackAction1(_ sender: Any) {
        openPlayerDetails(index: 0, players: attackers)
    }
    @IBAction func attackAction2(_ sender: Any) {
        openPlayerDetails(index: 1, players: attackers)
    }
    @IBAction func attackAction3(_ sender: Any) {
        openPlayerDetails(index: 2, players: attackers)
    }
    @IBAction func subAction1(_ sender: Any) {
        openPlayerDetails(index: 0, players: subGoalkeeper)
    }
    @IBAction func subAction2(_ sender: Any) {
        openPlayerDetails(index: 0, players: subsNotGoalkeeper)
    }
    @IBAction func subAction3(_ sender: Any) {
       openPlayerDetails(index: 1, players: subsNotGoalkeeper)
    }
    @IBAction func subAction4(_ sender: Any) {
        openPlayerDetails(index: 2, players: subsNotGoalkeeper)
    }
    
    @IBAction func menuAction(_ sender: Any) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! UISideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showPitchAction(_ sender: Any) {
     self.tableView.isHidden = true
    }
    @IBAction func showListAction(_ sender: Any) {
     self.tableView.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundViewCornersNoShadow(view: pitchBT)
        roundViewCornersNoShadow(view: listBT)
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.selectGW))
        self.gwView.addGestureRecognizer(gesture)
        tableView.delegate = self
        tableView.dataSource = self
        getGameWeeks ()
    }
    
    @objc func selectGW(sender : UITapGestureRecognizer) {
        let dropDownVC = Storyboard().dropDownStoryboard.instantiateViewController(withIdentifier: "DropDownVC") as! DropDownVC
        
        dropDownVC.selectDelegate = self
        dropDownVC.selectedType = .gameWeek
        dropDownVC.gameWeeks = gameWeeks
        
        present(dropDownVC, animated: true
            , completion: nil)
    }
    func openPlayerDetails(index : Int, players : [MyTeam]) {
        let playerDetailsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "PlayerDetailsVC") as! PlayerDetailsVC
        playerDetailsVC.fromPitch = true
        playerDetailsVC.gw = currentGWLink
        playerDetailsVC.team = players[index]
        present(playerDetailsVC, animated: true, completion: nil)
    }
    func getGameWeeks (){
        self.showLoader()
        PointsPresenter().getPointsGWs(onSuccess: { (gameWeeks) in
            self.gameWeeks = gameWeeks
            self.currentGWLink = gameWeeks[0].link!
            self.gwLbl.text = gameWeeks[0].lang_num_week
            self.getMyTeam()
            self.hideLoader()
        }) { (errorMessage, code) in
            self.hideLoader()
            if code == 11 || code == 41{
                let noTeamVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//                noTeamVC.isLogin = true
                self.navigationController?.pushViewController(noTeamVC, animated: true)
            }else {
                self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
            }
        }
    }
    func getMyTeam(){
        for item in self.captain_icons {
            item.isHidden = true
        }
        for item in self.assist_icons {
            item.isHidden = true
        }    
            self.showLoader()
        presenter.getPoints(link: currentGWLink, onSuccess: { (gwData, goalKeepers, defenders, mids, attackers, subs, lineup) in
                self.hideLoader()
                if goalKeepers[0].found_player == 0 {
                    let noTeamVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "NoTeamVC") as! NoTeamVC
                    self.navigationController?.pushViewController(noTeamVC, animated: true)
                }else {
                self.goalKeepers = goalKeepers
                self.defenders = defenders
                self.mids = mids
                self.attackers = attackers
                self.subs = subs
                    if let  finalPoints = gwData.final_point {
                        self.finalPointsLbl.text = String(finalPoints)
                    }
                    if let  avg_point = gwData.avg_point {
                        self.avgLbl.text = String(avg_point)
                    }
                    if let  heigh_point = gwData.heigh_point {
                        self.highLbl.text = String(heigh_point)
                    }
                    if let  sort_gwla = gwData.sort_gwla {
                        self.gwRankLbl.text = String(sort_gwla)
                    }
                    if let  transfer = gwData.transfer {
                        self.transfereLbl.text = String(transfer)
                    }
                let count = goalKeepers.count + defenders.count + mids.count + attackers.count + subs.count
                for i in 0..<count {
                    
                }
                    self.tableView.reloadData()
                self.fillView ()
                }
            }) { (errorMessage, code) in
                self.hideLoader()
                if code == 11 || code == 41{
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

        fillItem(players: goalKeeper1, button: self.goalKeeperBT, playerNameLbl: self.goalKeeperNameLbl, playerPointsLbl: self.playerPointLbl, playerView: self.goalKeeperView)

        
        let defender1 = self.defenders[0]
        let defender2 = self.defenders[1]
        let defender3 = self.defenders[2]
            
        fillItem(players: defender1, button: self.defendBT1, playerNameLbl: self.defendLbl1, playerPointsLbl: self.defendPointLbl1, playerView: self.defendView1)
        fillItem(players: defender2, button: self.defendBT2, playerNameLbl: self.defendLbl2, playerPointsLbl: self.defendPointLbl2, playerView: self.defendView2)
        if self.defenders.count >= 3 {
            fillItem(players: defender3, button: self.defendBT3, playerNameLbl: self.defendLbl3, playerPointsLbl: self.defendPointLbl3, playerView: self.defendView3)
        }
        if self.defenders.count >= 4{
                let defender4 = self.defenders[3]
            fillItem(players: defender4, button: self.defendBT4, playerNameLbl: self.defendLbl4, playerPointsLbl: self.defendPointLbl4, playerView: self.defendView4)
        }
        if self.defenders.count >= 5 {
        let defender5 = self.defenders[4]
            fillItem(players: defender5, button: self.defendBT5, playerNameLbl: self.defendLbl5, playerPointsLbl: self.defendPointLbl5, playerView: self.defendView5)
        }
        
        switch self.defenders.count {
        case 3:
            self.defendView1.isHidden = false
            self.defendView2.isHidden = false
            self.defendView3.isHidden = false
            self.defendView4.isHidden = true
            self.defendView5.isHidden = true
        case 4:
            self.defendView1.isHidden = false
            self.defendView2.isHidden = false
            self.defendView3.isHidden = false
            self.defendView4.isHidden = false
            self.defendView5.isHidden = true
        case 5:
            self.defendView1.isHidden = false
            self.defendView2.isHidden = false
            self.defendView3.isHidden = false
            self.defendView4.isHidden = false
            self.defendView5.isHidden = false
        default:
            break
        }
        

        
        let mid1 = self.mids[0]
        let mid2 = self.mids[1]
           
        fillItem(players: mid1, button: self.midBT1, playerNameLbl: self.midLbl1, playerPointsLbl: self.midPointLbl1, playerView: self.midView1)
        fillItem(players: mid2, button: self.midBT2, playerNameLbl: self.midLbl2, playerPointsLbl: self.midPointLbl2, playerView: self.midView2)
        if self.mids.count >= 3 {
            let mid3 = self.mids[2]
            fillItem(players: mid3, button: self.midBT3, playerNameLbl: self.midLbl3, playerPointsLbl: self.midPointLbl3, playerView: self.midView3)
        }
        if self.mids.count >= 4 {
            let mid4 = self.mids[3]
            fillItem(players: mid4, button: self.midBT4, playerNameLbl: self.midLbl4, playerPointsLbl: self.midPointLbl4, playerView: self.midView4)
        }
        if self.mids.count >= 5 {
            let mid5 = self.mids[4]
            fillItem(players: mid5, button: self.midBT5, playerNameLbl: self.midLbl5, playerPointsLbl: self.midPointLbl5, playerView: self.midView5)
        }
        switch self.mids.count {
        case 2:
            self.midView1.isHidden = false
            self.midView2.isHidden = false
            self.midView3.isHidden = true
            self.midView4.isHidden = true
            self.midView5.isHidden = true
        case 3:
            self.midView1.isHidden = false
            self.midView2.isHidden = false
            self.midView3.isHidden = false
            self.midView4.isHidden = true
            self.midView5.isHidden = true
        case 4:
            self.midView1.isHidden = false
            self.midView2.isHidden = false
            self.midView3.isHidden = false
            self.midView4.isHidden = false
            self.midView5.isHidden = true
        case 5:
            self.midView1.isHidden = false
            self.midView2.isHidden = false
            self.midView3.isHidden = false
            self.midView4.isHidden = false
            self.midView5.isHidden = false
                  
        default: break
            
        }
        
        
        let attacker1 = self.attackers[0]

        fillItem(players: attacker1, button: self.attackBT1, playerNameLbl: self.attackLbl1, playerPointsLbl: self.attackPointLbl1, playerView: self.attackView1)
        if self.attackers.count >= 2 {
            let attacker2 = self.attackers[1]
            fillItem(players: attacker2, button: self.attackBT2, playerNameLbl: self.attackLbl2, playerPointsLbl: self.attackPointLbl2, playerView: self.attackView2)
        }
        if self.attackers.count >= 3 {
            let attacker3 = self.attackers[2]
            fillItem(players: attacker3, button: self.attackBT3, playerNameLbl: self.attackLbl3, playerPointsLbl: self.attackPointLbl3, playerView: self.attackView3)
        }
        
        switch self.attackers.count {
        case 1:
            self.attackView1.isHidden = false
            self.attackView2.isHidden = true
            self.attackView3.isHidden = true
        case 2:
            self.attackView1.isHidden = false
            self.attackView2.isHidden = false
            self.attackView3.isHidden = true
        case 3:
            self.attackView1.isHidden = false
            self.attackView2.isHidden = false
            self.attackView3.isHidden = false
        default:
            break
        }
        
        
        for item in self.subs {
            let type = item.type_loc_player
            if type != "goalkeeper"{
                subsNotGoalkeeper.append(item)
                self.subsTypes.append(type!)
            }else {
                subGoalkeeper.append(item)
            }
        }
        let sub1 = subsNotGoalkeeper[0]
        let sub2 = subsNotGoalkeeper[1]
        let sub3 = subsNotGoalkeeper[2]
        fillItem(players: subGoalkeeper[0], button: self.subBT1, playerNameLbl: self.subNameLbl1, playerPointsLbl: self.subPointsLbl1, playerView: self.subView1)
        fillItem(players: sub1, button: self.subBT2, playerNameLbl: self.subNameLbl2, playerPointsLbl: self.subPointsLbl2, playerView: self.subView2)
        fillItem(players: sub2, button: self.subBT3, playerNameLbl: self.subNameLbl3, playerPointsLbl: self.subPointsLbl3, playerView: self.subView3)
        fillItem(players: sub3, button: self.subBT4, playerNameLbl: self.subNameLbl4, playerPointsLbl: self.subPointsLbl4, playerView: self.subView4)

    }
    
    func fillItem (players : MyTeam, button : UIButton, playerNameLbl : UILabel, playerPointsLbl : UILabel, playerView : UIView){
        playerNameLbl.text = players.name_player
        if let points = players.point_player{
        playerPointsLbl.text = String(points)
        }
            button.sd_setImage(with: URL(string:Urls.baseUrl + players.image_player!), for: .normal)
        let captin_assist = players.type_key_coatch
        var isAttack = false
        if players.type_loc_player == "attacker" {
            isAttack = true
        }

        if captin_assist == "captain" {
            addCaptin_assistIcon(icon_name: self.captin_icon, view_name: playerView, button: button, isAttack: isAttack)
        }else if captin_assist == "sub_captain"{
            addCaptin_assistIcon(icon_name: self.assist_icon, view_name: playerView, button: button, isAttack: isAttack)
        }
            
    }
    var captain_icons = [UIImageView] ()
       var assist_icons = [UIImageView] ()
       func addCaptin_assistIcon (icon_name : String, view_name : UIView, button : UIButton, isAttack : Bool){
           let imageName = icon_name
           let image = UIImage(named: imageName)
           let imageView = UIImageView(image: image!)
           var x = 0
           if isAttack{
               x = 25
           }else{
               x = 10
           }
           imageView.frame = CGRect(x: x, y: 45, width: 20, height: 20)
           view_name.addSubview(imageView)
           if icon_name == "c-icon"{
               captain_icons.append(imageView)
           }else{
               assist_icons.append(imageView)
           }
       }
}
extension MyPointsVC : SelectedDropDownType, UITableViewDelegate, UITableViewDataSource {
    func selectedType(selectedType: DropDownTypes, selectedItem: Any) {
        if selectedType == .gameWeek {
            let selectedGW = selectedItem as! GWsPointsModel
            self.gwLbl.text = selectedGW.lang_num_week
            self.currentGWLink = selectedGW.link!
            getMyTeam()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count1 = self.goalKeepers.count
        let count2 = self.defenders.count
        let count3 = self.mids.count
        let count4 = self.attackers.count
        let count5 = self.subs.count
        
        return count1 + count2 + count3 + count4 + count5 + 5
       }
    func checkCaptain (player : MyTeam , cell : PichCell){
        let player = player.type_key_coatch
        if player == "captain" {
            cell.imageV!.isHidden = false
            cell.imageV!.image = UIImage(named: "c-icon")
        }else if player == "sub_captain"{
            cell.imageV!.isHidden = false
            cell.imageV!.image = UIImage(named: "v-icon")
        }else {
            cell.imageV!.isHidden = true
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "PichCell2", for: indexPath) as! PichCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "PichHeaderCell2", for: indexPath) as! PichHeaderCell
        
        if indexPath.row == 0 {
            cell2.positionLbl.text = "GoalKeeper".localized
            cell2.contentView.backgroundColor = Color.goalKeeper.value
            return cell2
        }else if indexPath.row > 0 && indexPath.row <= self.goalKeepers.count{
            let index = indexPath.row - 1
            checkCaptain (player : self.goalKeepers[index] , cell : cell1)
            return fillCell (cell : cell1 , player : self.goalKeepers[index])
        } else if indexPath.row == self.goalKeepers.count + 1{
            cell2.positionLbl.text = "Defender".localized
            cell2.contentView.backgroundColor = Color.defender.value
            return cell2
        }else if indexPath.row > self.goalKeepers.count + 1 && indexPath.row <= self.goalKeepers.count + self.defenders.count + 1 {
            let index = indexPath.row - self.goalKeepers.count - 2
            checkCaptain (player : self.defenders[index] , cell : cell1)
            return fillCell (cell : cell1 , player : self.defenders[index])
        }else if indexPath.row == self.goalKeepers.count + self.defenders.count + 2{
            cell2.positionLbl.text = "Mid".localized
            cell2.contentView.backgroundColor = Color.mid.value
            return cell2
        }else if indexPath.row > (self.goalKeepers.count + self.defenders.count + 2) && indexPath.row <= self.goalKeepers.count + self.defenders.count + self.mids.count + 2 {
            let index = indexPath.row - self.goalKeepers.count - self.defenders.count - 3
            checkCaptain (player : self.mids[index] , cell : cell1)
            return fillCell (cell : cell1 , player : self.mids[index])
        }else if indexPath.row == (self.goalKeepers.count + self.defenders.count + self.mids.count + 3){
            cell2.positionLbl.text = "Attacker".localized
            cell2.contentView.backgroundColor = Color.attacker.value
            return cell2
        }else if indexPath.row > (self.goalKeepers.count + self.defenders.count + self.mids.count + 3) && indexPath.row <= self.goalKeepers.count + self.defenders.count + self.mids.count + self.attackers.count + 3{
            let index = indexPath.row - self.goalKeepers.count - self.defenders.count - self.mids.count - 4
            checkCaptain (player : self.attackers[index] , cell : cell1)
            return fillCell (cell : cell1 , player : self.attackers[index])
        }else if indexPath.row == (self.goalKeepers.count + self.defenders.count + self.mids.count + self.attackers.count + 4){
            cell2.positionLbl.text = "Subs".localized
            cell2.contentView.backgroundColor = Color.sub.value
            return cell2
        }else {
            let index = indexPath.row - self.goalKeepers.count - self.defenders.count - self.mids.count - self.attackers.count - 5
            cell1.imageV.isHidden = true
            return fillCell (cell : cell1 , player : self.subs[index])
        }
       }
    
    func fillCell (cell : PichCell , player : MyTeam) -> PichCell {
        cell.nameLbl.text = player.name_player
        cell.clubLb.text = player.team
        let price = player.cost_player
        if let playerPrice = price {
            cell.buyCost.text = String(playerPrice)
        }
        let points = player.point_player
        if let playerPoints = points {
            cell.pointsLbl.text = String(playerPoints)
        }
        return cell
    }
    
}

//
//  MyTeamVC.swift
//  GameClub
//
//  Created by Basma on 3/30/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SideMenu

class MyTeamVC: ParentViewController {
    var benchCard = 0
    var tripleCard = 0
    var goalKeepers = [MyTeam]()
    var defenders = [MyTeam]()
    var mids = [MyTeam]()
    var attackers = [MyTeam]()
    var subs = [MyTeam]()
    var subsTypes = [String]()
    var subsNotGoalkeeper = [MyTeam] ()
    var subGoalkeeper = MyTeam ()
    var presenter = MyTeamPresenter ()
    var allViews = [UIView] ()
    var allButtons = [UIButton] ()
    var allSubsView = [UIView] ()
    var allSubsButtons = [UIButton]()
    var playersIDs = [Int] ()
    var selectedPlayerLink = ""
    var fromMainToSub = false
    var fromSubToMain = false
    var captin_icon = "c-icon"
    var assist_icon = "v-icon"
    @IBOutlet weak var tableView: UITableView!
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
    
    @IBOutlet weak var captinCardBT: UIButton!
    @IBOutlet weak var substitutionsCardBT: UIButton!
    
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var pitchBT: UIButton!
    @IBOutlet weak var listBT: UIButton!
    
    @IBOutlet weak var cancelCardBT: UIButton!
    @IBAction func cancelCardAction(_ sender: Any) {
        cancelCards (type : "bench")
        cancelCards (type : "triple")
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
    @IBAction func substitutionsCardAction(_ sender: Any) {
        presenter.openCardPopUp (cardType : "sub_card", delegate : self, vc : self, benchCard: benchCard, tripleCard: tripleCard)
        
    }
    @IBAction func captinCardAction(_ sender: Any) {
        presenter.openCardPopUp (cardType : "three_card", delegate : self, vc : self, benchCard: benchCard, tripleCard: tripleCard)
    }
    
    @IBAction func goalkeeperAction(_ sender: Any) {
        if !self.fromSubToMain{ OpenPopUp (view : self.goalKeeperView, button: self.goalKeeperBT, player : self.goalKeepers[0], isSub : 1)}else {
            selectPlayer (player : self.goalKeepers[0])
        }
    }
    @IBAction func defendAction1(_ sender: Any) {
        if !self.fromSubToMain{ OpenPopUp (view : self.defendView1, button: self.defendBT1, player : self.defenders[0], isSub : 1)} else{
            selectPlayer (player : self.defenders[0])
        }
    }
    @IBAction func defendAction2(_ sender: Any) {
        if !self.fromSubToMain{ OpenPopUp (view : self.defendView2, button: self.defendBT2, player : self.defenders[1], isSub : 1)}else{
            selectPlayer (player : self.defenders[1])}
    }
    @IBAction func defendAction3(_ sender: Any) {
        if !self.fromSubToMain{ OpenPopUp (view : self.defendView3, button: self.defendBT3, player : self.defenders[2], isSub : 1)} else {
            selectPlayer (player : self.defenders[2])}
    }
    @IBAction func defendAction4(_ sender: Any) {
        if !self.fromSubToMain{ OpenPopUp (view : self.defendView4, button: self.defendBT4, player : self.defenders[3], isSub : 1)} else {
            selectPlayer (player : self.defenders[3])}
    }
    @IBAction func defendAction5(_ sender: Any) {
        if !self.fromSubToMain{ OpenPopUp (view : self.defendView5, button: self.defendBT5, player : self.defenders[4], isSub : 1)} else {
            selectPlayer (player : self.defenders[4])}
    }
    @IBAction func midAction1(_ sender: Any) {
        if !self.fromSubToMain{ OpenPopUp (view : self.midView1, button: self.midBT1, player : self.mids[0], isSub : 1)} else{
            selectPlayer (player : self.mids[0])}
    }
    @IBAction func midAction2(_ sender: Any) {
        if !self.fromSubToMain{ OpenPopUp (view : self.midView2, button: self.midBT2, player : self.mids[1], isSub : 1)} else{
            selectPlayer (player : self.mids[1])}
    }
    @IBAction func midAction3(_ sender: Any) {
        if !self.fromSubToMain{ OpenPopUp (view : self.midView3, button: self.midBT3, player : self.mids[2], isSub : 1)} else{
            selectPlayer (player : self.mids[2])}
    }
    @IBAction func midAction4(_ sender: Any) {
        if !self.fromSubToMain{ OpenPopUp (view : self.midView4, button: self.midBT4, player : self.mids[3], isSub : 1)} else{
            selectPlayer (player : self.mids[3])}
    }
    @IBAction func midAction5(_ sender: Any) {
        if !self.fromSubToMain{ OpenPopUp (view : self.midView5, button: self.midBT5, player : self.mids[4], isSub : 1)} else{
            selectPlayer (player : self.mids[4])}
    }
    @IBAction func attackAction1(_ sender: Any) {
        if !self.fromSubToMain{ OpenPopUp (view : self.attackView1, button: self.attackBT1, player : self.attackers[0], isSub : 1)} else{
            selectPlayer (player : self.attackers[0])}
    }
    @IBAction func attackAction2(_ sender: Any) {
        if !self.fromSubToMain{ OpenPopUp (view : self.attackView2, button: self.attackBT2, player : self.attackers[1], isSub : 1)} else{
            selectPlayer (player : self.attackers[1])}
    }
    @IBAction func attackAction3(_ sender: Any) {
        if !self.fromSubToMain{ OpenPopUp (view : self.attackView3, button: self.attackBT3, player : self.attackers[2], isSub : 1)} else{
            selectPlayer (player : self.attackers[2])}
    }
    @IBAction func subAction1(_ sender: Any) {
        if !fromMainToSub {
            OpenPopUp(view: self.subView1, button: self.subBT1, player: self.subGoalkeeper, isSub : 0)
        }else{
            selectPlayer (player : self.subGoalkeeper)
        }
    }
    @IBAction func subAction2(_ sender: Any) {
        if !fromMainToSub {
            if !selectedPlayerLink.isEmpty && selectedPlayerLink != self.subsNotGoalkeeper[0].link_player{
                selectPlayer (player : self.subsNotGoalkeeper[0])
            }else{
                OpenPopUp(view: self.subView2, button: self.subBT2, player: self.subsNotGoalkeeper[0], isSub : 0)
            }
        }else{
            selectPlayer (player : self.subsNotGoalkeeper[0])
        }
    }
    @IBAction func subAction3(_ sender: Any) {
        if !fromMainToSub {
            if !selectedPlayerLink.isEmpty && selectedPlayerLink != self.subsNotGoalkeeper[1].link_player{
                selectPlayer (player : self.subsNotGoalkeeper[1])
            }else{
                OpenPopUp(view: self.subView3, button: self.subBT2, player: self.subsNotGoalkeeper[1], isSub : 0)
            }
        }else{
            selectPlayer (player : self.subsNotGoalkeeper[1])
        }
    }
    @IBAction func subAction4(_ sender: Any) {
        if !fromMainToSub {
            if !selectedPlayerLink.isEmpty && selectedPlayerLink != self.subsNotGoalkeeper[2].link_player{
                selectPlayer (player : self.subsNotGoalkeeper[2])
            }else{
                OpenPopUp(view: self.subView4, button: self.subBT2, player: self.subsNotGoalkeeper[2], isSub : 0)
            }
        }else{
            selectPlayer (player : self.subsNotGoalkeeper[2])
        }
    }
    
    func cancelCards (type : String) {
        presenter.cancelCards(type: type, onSuccess: { (success) in
            self.captinCardBT.isEnabled = true
            self.captinCardBT.alpha = 1.0
            self.substitutionsCardBT.isEnabled = true
            self.substitutionsCardBT.alpha = 1.0
            self.cancelCardBT.isHidden = true
            self.benchCard = 0
            self.tripleCard = 0
        }){(errorMessage) in
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)

        }
    }
    
    func selectPlayer (player : MyTeam) {
        if fromSubToMain {
            self.presenter.addPlayerWithLink(playerLink1: self.selectedPlayerLink, playerLink2: player.link_player!,onSuccess: { (response) in
                //            self.showAlert(title: "", message: response, shouldpop: false)
                self.playersIDs = [Int] ()
                self.subsNotGoalkeeper = [MyTeam]()
                self.subGoalkeeper = MyTeam ()
                self.defenders = [MyTeam]()
                self.mids = [MyTeam]()
                self.attackers = [MyTeam]()
                self.goalKeepers = [MyTeam]()
                self.subsTypes = [String]()
                self.resetCaptinAssistIVs()
                self.getMyTeam()
                self.resetView ()
                self.fromMainToSub = false
                self.fromSubToMain = false
                self.selectedPlayerLink = ""
            }) { (errorMessage) in
                //                self.hideLoader()
                self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
            }
        }else{
            if !playersIDs.isEmpty{
                presenter.check_insideChange(link: player.link_player!, onSuccess: { (response) in
                    self.playersIDs.append(response.ch_game_player_id_two!)
                    self.playersIDs.append(response.ch_player_id_two!)
                    self.presenter.addPlayer(playersIDs: self.playersIDs, onSuccess: { (response) in
                        //            self.showAlert(title: "", message: response, shouldpop: false)
                        self.playersIDs = [Int] ()
                        self.subsNotGoalkeeper = [MyTeam]()
                        self.subGoalkeeper = MyTeam ()
                        self.defenders = [MyTeam]()
                        self.mids = [MyTeam]()
                        self.attackers = [MyTeam]()
                        self.goalKeepers = [MyTeam]()
                        self.subsTypes = [String]()
                        self.resetCaptinAssistIVs()
                        self.getMyTeam()
                        self.resetView ()
                        self.fromMainToSub = false
                        self.fromSubToMain = false
                        self.selectedPlayerLink = ""
                    }) { (errorMessage) in
                        //                self.hideLoader()
                        self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
                    }
                }) { (errorMessage) in
                    //                self.hideLoader()
                    self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
                }
            }
        }
    }
    func resetCaptinAssistIVs(){
        for item in self.captain_icons {
            item.isHidden = true
        }
        for item in self.assist_icons {
            item.isHidden = true
        }    }
    func resetView (){
        self.fromMainToSub = false
        self.fromSubToMain = false
        self.selectedPlayerLink = ""
        for item in self.allViews {
            item.alpha = 1
            item.backgroundColor = UIColor.clear
        }
        for item in self.allButtons {
            item.isEnabled = true
        }
        for item in self.allSubsView {
            item.alpha = 1
            item.backgroundColor = UIColor.clear
        }
        for item in self.allSubsButtons {
            item.isEnabled = true
        }
    }
    func addSubToView (view : UIView, button : UIButton) {
        self.view.backgroundColor = Color.selectedPlayer.value
        for item in self.allViews {
            if item != view {
                item.alpha = 0.5
            }
        }
        for item in self.allButtons {
            if item != button {
                item.isEnabled = false
            }
        }
    }
    func OpenPopUp (view : UIView, button : UIButton, player : MyTeam, isSub : Int) {
        if isSub == 0{self.fromMainToSub = false
            self.fromSubToMain = true}else if isSub == 1 {self.fromMainToSub = true
            self.fromSubToMain = false}
        
        if view.backgroundColor == Color.selectedPlayer.value {
            resetView ()
            
        }else {
            let popUpVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "ChooseCaptinPopUp") as! ChooseCaptinPopUp
            popUpVC.player = player
            popUpVC.playerView = view
            popUpVC.playerBT = button
            popUpVC.delegate = self
            popUpVC.isSub = isSub
            present(popUpVC, animated: true
                , completion: nil)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        checkBtStates()
    }
    override func viewDidLoad() {
        roundViewCornersNoShadow(view: pitchBT)
        roundViewCornersNoShadow(view: listBT)
        roundViewCornersNoShadow(view: captinCardBT)
        roundViewCornersNoShadow(view: substitutionsCardBT)
        roundViewCornersNoShadow(view: cancelCardBT)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        appendView ()
        getMyTeam()
        let endDate = UserDefaults.standard.string(forKey: "END_DATE") ?? ""
        let gameWeek = UserDefaults.standard.string(forKey: "GAME_WEEK") ?? ""
        let mainLblString = "End date for GW ".localized + gameWeek + ": " + endDate
        mainLbl.text = mainLblString
    }
    var allPlayers = [MyTeam]()
    func getMyTeam(){
        //        self.showLoader()
        presenter.getMyTeam( onSuccess: { (goalKeepers, defenders, mids, attackers, subs, lineup) in
            //            self.hideLoader()
            if goalKeepers[0].found_player == 0 {
                let noTeamVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "NoTeamVC") as! NoTeamVC
                self.navigationController?.pushViewController(noTeamVC, animated: true)
            }else {
                self.goalKeepers = goalKeepers
                self.defenders = defenders
                self.mids = mids
                self.attackers = attackers
                self.subs = subs
                let count = goalKeepers.count + defenders.count + mids.count + attackers.count + subs.count
                for i in 0..<count {
                    
                }
                self.tableView.reloadData()
                self.fillView ()
            }
        }) { (errorMessage, code) in
            //            self.hideLoader()
            if code == 11 || code == 41{
                let noTeamVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                //                noTeamVC.isLogin = true
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
                subGoalkeeper = item
            }
        }
        let sub1 = subsNotGoalkeeper[0]
        let sub2 = subsNotGoalkeeper[1]
        let sub3 = subsNotGoalkeeper[2]
        fillItem(players: subGoalkeeper, button: self.subBT1, playerNameLbl: self.subNameLbl1, playerPointsLbl: self.subPointsLbl1, playerView: self.subView1)
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
    
    func appendView () {
        allViews.append(self.goalKeeperView)
        allViews.append(self.defendView1)
        allViews.append(self.defendView2)
        allViews.append(self.defendView3)
        allViews.append(self.defendView4)
        allViews.append(self.defendView5)
        allViews.append(self.midView1)
        allViews.append(self.midView2)
        allViews.append(self.midView3)
        allViews.append(self.midView4)
        allViews.append(self.midView5)
        allViews.append(self.attackView1)
        allViews.append(self.attackView2)
        allViews.append(self.attackView3)
        
        allButtons.append(self.goalKeeperBT)
        allButtons.append(self.defendBT1)
        allButtons.append(self.defendBT2)
        allButtons.append(self.defendBT3)
        allButtons.append(self.defendBT4)
        allButtons.append(self.defendBT5)
        allButtons.append(self.midBT1)
        allButtons.append(self.midBT2)
        allButtons.append(self.midBT3)
        allButtons.append(self.midBT4)
        allButtons.append(self.midBT5)
        allButtons.append(self.attackBT1)
        allButtons.append(self.attackBT2)
        allButtons.append(self.attackBT3)
        
        allSubsView.append(self.subView1)
        allSubsView.append(self.subView2)
        allSubsView.append(self.subView3)
        allSubsView.append(self.subView4)
        
        allSubsButtons.append(self.subBT1)
        allSubsButtons.append(self.subBT2)
        allSubsButtons.append(self.subBT3)
        allSubsButtons.append(self.subBT4)
        
        
    }
    var listSelectedPlayers = [MyTeam]()
}

extension MyTeamVC : MyTeamProtocol , SubListDelegate, UITableViewDelegate, UITableViewDataSource, cardActivationDelegat{
    func isCardActivated(cardType : String) {
        self.showAlert(title: "", message: "Card is Activated".localized, shouldpop: false)
        self.captinCardBT.isEnabled = false
        self.captinCardBT.alpha = 0.5
        self.substitutionsCardBT.isEnabled = false
        self.substitutionsCardBT.alpha = 0.5
        self.cancelCardBT.isHidden = false
        if cardType == "sub_card" {
            self.benchCard = 1
            self.tripleCard = 0
        }else if cardType == "three_card"{
            self.benchCard = 0
            self.tripleCard = 1
        }
    }
    
    func changePlayerFromList(player: MyTeam, players: [MyTeam], popup : ChooseCaptinPopUp) {
        popup.dismiss(animated: true, completion: nil)
        let popUpVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "SubPlayersPopUp") as! SubPlayersPopUp
        popUpVC.selectedPlayer = player
        popUpVC.players = players
        popUpVC.delegate = self
        present(popUpVC, animated: true
            , completion: nil)
    }
    
    func reloadVCData() {
        listSelectedPlayers = [MyTeam] ()
        subsNotGoalkeeper = [MyTeam]()
        resetCaptinAssistIVs()
        resetView()
        getMyTeam()
    }
    
    func resetButtons() {
        self.fromMainToSub = false
        self.fromSubToMain = false
    }
    
    func chooseCaptain_assist(player: MyTeam, type: Int) {
        var player_type = ""
        if type == 0 {player_type = "captain"}else {player_type = "assist"}
        presenter.addCaptainOrAssist(playerLink: player.link_player!, type: player_type, onSuccess: { (response) in
            if type == 0 {
                for item in self.captain_icons {
                    item.isHidden = true
                }
            }else {
                for item in self.assist_icons {
                    item.isHidden = true
                }
            }
            self.subsTypes = [String] ()
            self.resetView()
            self.getMyTeam()
        }) { (errorMessage) in
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func openPlayerDetails(player: MyTeam) {
        let playerDetailsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "PlayerDetailsVC") as! PlayerDetailsVC
        playerDetailsVC.team = player
        playerDetailsVC.fromPitch = true
        self.navigationController?.pushViewController(playerDetailsVC, animated: true)
    }
    
    func changePlayer(view: UIView, button : UIButton, player: MyTeam) {
        view.backgroundColor = Color.selectedPlayer.value
        for item in self.allViews {
            if item != view {
                item.alpha = 0.5
            }
        }
        
        for item in self.allButtons {
            if item != button {
                item.isEnabled = false
            }
        }
        
        presenter.check_insideChange(link: player.link_player!, onSuccess: { (response) in
            self.playersIDs.append(response.ch_game_player_id_one!)
            self.playersIDs.append(response.ch_player_id_one!)
            let allHide = response.all_hide
            if allHide == 0{
                self.subView2.backgroundColor = Color.selectedPlayer.value
                self.subView3.backgroundColor = Color.selectedPlayer.value
                self.subView4.backgroundColor = Color.selectedPlayer.value
                self.subView1.alpha = 0.5
                self.subBT1.isEnabled = false
                
            }else{
                let type = player.type_loc_player
                if type == self.subsTypes[0]{
                    self.subView2.backgroundColor = Color.selectedPlayer.value
                }
                if type == self.subsTypes[1] {
                    self.subView3.backgroundColor = Color.selectedPlayer.value
                }
                if type == self.subsTypes[2] {
                    self.subView4.backgroundColor = Color.selectedPlayer.value
                }
                if type == "goalkeeper" {
                    self.subView1.backgroundColor = Color.selectedPlayer.value
                }
                
                
                if type != self.subsTypes[0]{
                    self.subView2.alpha = 0.5
                    self.subBT2.isEnabled = false
                }
                if type != self.subsTypes[1] {
                    self.subView3.alpha = 0.5
                    self.subBT3.isEnabled = false
                }
                if type != self.subsTypes[2] {
                    self.subView4.alpha = 0.5
                    self.subBT4.isEnabled = false
                }
                if type != "goalkeeper" {
                    self.subView1.alpha = 0.5
                    self.subBT1.isEnabled = false
                }
            }
        }) { (errorMessage) in
            //            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func orderSubPlayer (view : UIView, button : UIButton, player: MyTeam){
        self.selectedPlayerLink = player.link_player!
        
        if view != self.subView1{
            self.subView1.alpha = 0.5
            self.goalKeeperBT.isEnabled = false
            if player.type_loc_player != "attacker" && self.attackers.count > 1 {
                self.attackView1.backgroundColor = Color.selectedPlayer.value
                self.attackView2.backgroundColor = Color.selectedPlayer.value
                self.attackView3.backgroundColor = Color.selectedPlayer.value
            }
            if player.type_loc_player != "attacker" && self.attackers.count == 1 {
                self.attackView1.alpha = 0.5
                self.attackBT1.isEnabled = false
            }
            if player.type_loc_player == "attacker" {
                self.attackView1.backgroundColor = Color.selectedPlayer.value
                self.attackView2.backgroundColor = Color.selectedPlayer.value
                self.attackView3.backgroundColor = Color.selectedPlayer.value
            }
            
            if player.type_loc_player != "defender" && self.defenders.count > 3 {
                self.defendView1.backgroundColor = Color.selectedPlayer.value
                self.defendView2.backgroundColor = Color.selectedPlayer.value
                self.defendView3.backgroundColor = Color.selectedPlayer.value
                self.defendView4.backgroundColor = Color.selectedPlayer.value
                self.defendView5.backgroundColor = Color.selectedPlayer.value
            }
            if player.type_loc_player != "defender" && self.defenders.count == 3{
                self.defendView1.alpha = 0.5
                self.defendBT1.isEnabled = false
                self.defendView2.alpha = 0.5
                self.defendBT2.isEnabled = false
                self.defendView3.alpha = 0.5
                self.defendBT3.isEnabled = false
            }
            
            if player.type_loc_player == "defender" {
                self.defendView1.backgroundColor = Color.selectedPlayer.value
                self.defendView2.backgroundColor = Color.selectedPlayer.value
                self.defendView3.backgroundColor = Color.selectedPlayer.value
                self.defendView4.backgroundColor = Color.selectedPlayer.value
                self.defendView5.backgroundColor = Color.selectedPlayer.value
            }
            
            self.midView1.backgroundColor = Color.selectedPlayer.value
            self.midView2.backgroundColor = Color.selectedPlayer.value
            self.midView3.backgroundColor = Color.selectedPlayer.value
            self.midView4.backgroundColor = Color.selectedPlayer.value
            self.midView5.backgroundColor = Color.selectedPlayer.value
            
            
            for item in self.allSubsView {
                if item != self.subView1{
                    item.backgroundColor = UIColor.white
                }
            }
            view.backgroundColor = Color.selectedPlayer.value
            self.goalKeeperView.alpha = 0.5
            self.goalKeeperBT.isEnabled = false
        }else {
            self.goalKeeperView.backgroundColor = Color.selectedPlayer.value
            self.subView1.backgroundColor = Color.selectedPlayer.value
            for item in self.allViews {
                if item != self.goalKeeperView{
                    item.alpha = 0.5
                }
            }
            for item in self.allSubsView {
                if item != self.subView1{
                    item.alpha = 0.5
                }
            }
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
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "PichCell", for: indexPath) as! PichCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "PichHeaderCell", for: indexPath) as! PichHeaderCell
        
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var player = MyTeam()
        
        listSelectedPlayers = [MyTeam]()
        if indexPath.row > 0 && indexPath.row == 1 {
            player = self.goalKeepers[0]
            listSelectedPlayers.append(self.subGoalkeeper)
            openSubListPopUp (player : player, players : listSelectedPlayers, isSub: 3)
        }else if indexPath.row > 2 && indexPath.row <= self.goalKeepers.count + self.defenders.count + 1{
            player = self.defenders[indexPath.row - self.goalKeepers.count - 2]
            if self.defenders.count > 3 {
                for item in self.subsNotGoalkeeper{
                    listSelectedPlayers.append(item)
                }
            }else {
                for item in self.subsNotGoalkeeper{
                    if item.type_loc_player == "defender"{
                        listSelectedPlayers.append(item)
                    }
                }
            }
            openSubListPopUp (player : player, players : listSelectedPlayers, isSub: 3)
        }else if indexPath.row > (self.goalKeepers.count + self.defenders.count + 2) && indexPath.row <= self.goalKeepers.count + self.defenders.count + self.mids.count + 2 {
            player = self.mids[indexPath.row - self.goalKeepers.count - self.defenders.count - 3]
            for item in self.subsNotGoalkeeper{
                listSelectedPlayers.append(item)
            }
            openSubListPopUp (player : player, players : listSelectedPlayers, isSub: 3)
        }else if indexPath.row > (self.goalKeepers.count + self.defenders.count + self.mids.count + 3) && indexPath.row <= self.goalKeepers.count + self.defenders.count + self.mids.count + self.attackers.count + 3{
            player = self.attackers[indexPath.row - self.goalKeepers.count - self.defenders.count - self.mids.count - 4]
            if self.attackers.count > 1 {
                for item in self.subsNotGoalkeeper{
                    listSelectedPlayers.append(item)
                }
            }else {
                for item in self.subsNotGoalkeeper{
                    if item.type_loc_player == "attacker"{
                        listSelectedPlayers.append(item)
                    }
                }
            }
            openSubListPopUp (player : player, players : listSelectedPlayers, isSub: 3)
        }else if indexPath.row == self.goalKeepers.count + self.defenders.count + self.mids.count + self.attackers.count + 4{
            
        }else if indexPath.row > (self.goalKeepers.count + self.defenders.count + self.mids.count + self.attackers.count + 4){
            player = self.subs[indexPath.row - self.goalKeepers.count - self.defenders.count - self.mids.count - self.attackers.count - 5]
            if player.type_loc_player == "goalkeeper"{
                listSelectedPlayers.append(goalKeepers[0])
            }else if player.type_loc_player != "defender"{
                if defenders.count > 3 {
                    for item in defenders {
                        listSelectedPlayers.append(item)
                    }
                }
                for item in mids {
                    listSelectedPlayers.append(item)
                }
                for item in attackers{
                    listSelectedPlayers.append(item)
                }
            }else if player.type_loc_player == "defender" {
                for item in defenders {
                    listSelectedPlayers.append(item)
                }
                for item in mids {
                    listSelectedPlayers.append(item)
                }
                for item in attackers{
                    listSelectedPlayers.append(item)
                }
            }else if player.type_loc_player != "attacker"{
                if attackers.count > 1 {
                    for item in attackers {
                        listSelectedPlayers.append(item)
                    }
                }
                for item in mids {
                    listSelectedPlayers.append(item)
                }
                for item in defenders{
                    listSelectedPlayers.append(item)
                }
            }
            openSubListPopUp (player : player, players : listSelectedPlayers, isSub: 4)
        }
    }
    func openSubListPopUp (player : MyTeam, players : [MyTeam], isSub : Int){
        
        let popUpVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "ChooseCaptinPopUp") as! ChooseCaptinPopUp
        popUpVC.player = player
        popUpVC.players = players
        popUpVC.delegate = self
        popUpVC.isSub = isSub
        present(popUpVC, animated: true
            , completion: nil)
    }
    func checkBtStates () {
        MyTeamPresenter().check_btns_status(onSuccess: { (benchCard, tripleCard) in
            self.benchCard = benchCard
            self.tripleCard = tripleCard
            if benchCard == 1 || tripleCard == 1{
                self.substitutionsCardBT.isEnabled = false
                self.substitutionsCardBT.alpha = 0.5
                self.captinCardBT.isEnabled = false
                self.captinCardBT.alpha = 0.5
                self.cancelCardBT.isHidden = false
            }
            
        }) { (errorMessage) in
            //                self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
}

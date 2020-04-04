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
       
       @IBAction func menuAction(_ sender: Any) {
       let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! UISideMenuNavigationController
               present(menu, animated: true, completion: nil)
           }
       @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
       }
       @IBAction func showPitchAction(_ sender: Any) {
       }
       @IBAction func showListAction(_ sender: Any) {
       }
       @IBAction func substitutionsCardAction(_ sender: Any) {
       }
       @IBAction func captinCardAction(_ sender: Any) {
       }
       @IBAction func goalkeeperAction(_ sender: Any) {
        OpenPopUp (view : self.goalKeeperView, button: self.goalKeeperBT, player : self.goalKeepers[0])
       }
    @IBAction func defendAction1(_ sender: Any) {
        OpenPopUp (view : self.defendView1, button: self.defendBT1, player : self.defenders[0])
    }
    @IBAction func defendAction2(_ sender: Any) {
        OpenPopUp (view : self.defendView2, button: self.defendBT2, player : self.defenders[1])
    }
    @IBAction func defendAction3(_ sender: Any) {
        OpenPopUp (view : self.defendView3, button: self.defendBT3, player : self.defenders[2])
    }
    @IBAction func defendAction4(_ sender: Any) {
        OpenPopUp (view : self.defendView4, button: self.defendBT4, player : self.defenders[3])
    }
    @IBAction func defendAction5(_ sender: Any) {
        OpenPopUp (view : self.defendView5, button: self.defendBT5, player : self.defenders[4])
    }
    @IBAction func midAction1(_ sender: Any) {
        OpenPopUp (view : self.midView1, button: self.midBT1, player : self.mids[0])
    }
    @IBAction func midAction2(_ sender: Any) {
        OpenPopUp (view : self.midView2, button: self.midBT2, player : self.mids[1])
    }
    @IBAction func midAction3(_ sender: Any) {
        OpenPopUp (view : self.midView3, button: self.midBT3, player : self.mids[2])
    }
    @IBAction func midAction4(_ sender: Any) {
        OpenPopUp (view : self.midView4, button: self.midBT4, player : self.mids[3])
    }
    @IBAction func midAction5(_ sender: Any) {
        OpenPopUp (view : self.midView5, button: self.midBT5, player : self.mids[4])
    }
    @IBAction func attackAction1(_ sender: Any) {
        OpenPopUp (view : self.attackView1, button: self.attackBT1, player : self.attackers[0])
    }
    @IBAction func attackAction2(_ sender: Any) {
        OpenPopUp (view : self.attackView2, button: self.attackBT2, player : self.attackers[1])
    }
    @IBAction func attackAction3(_ sender: Any) {
        OpenPopUp (view : self.attackView3, button: self.attackBT3, player : self.attackers[2])
    }
    @IBAction func subAction1(_ sender: Any) {
        selectPlayer (player : self.subsNotGoalkeeper[0])
    }
    @IBAction func subAction2(_ sender: Any) {
        selectPlayer (player : self.subsNotGoalkeeper[1])
    }
    @IBAction func subAction3(_ sender: Any) {
        selectPlayer (player : self.subsNotGoalkeeper[2])
    }
    @IBAction func subAction4(_ sender: Any) {
        selectPlayer (player : self.subGoalkeeper)
    }
    
    func selectPlayer (player : MyTeam) {
        presenter.check_insideChange(link: player.link_player!, onSuccess: { (response) in
            self.playersIDs.append(response.ch_game_player_id_two!)
            self.playersIDs.append(response.ch_player_id_two!)
            self.presenter.addPlayer(playersIDs: self.playersIDs, onSuccess: { (response) in
            self.showAlert(title: "", message: response, shouldpop: false)
                self.getMyTeam()
                self.playersIDs = [Int] ()
                self.subsNotGoalkeeper = [MyTeam]()
                self.subGoalkeeper = MyTeam ()
                self.resetView ()
            }) { (errorMessage) in
//                self.hideLoader()
                self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
            }
            }) { (errorMessage) in
//                self.hideLoader()
                self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
            }

    }
    func resetView (){
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
    func OpenPopUp (view : UIView, button : UIButton, player : MyTeam) {
        
        if view.backgroundColor == Color.selectedPlayer.value {
        resetView ()
            
    }else {
        let popUpVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "ChooseCaptinPopUp") as! ChooseCaptinPopUp
        popUpVC.player = player
        popUpVC.playerView = view
        popUpVC.playerBT = button
        popUpVC.delegate = self
        present(popUpVC, animated: true
            , completion: nil)
    }
    }
    
    override func viewDidLoad() {
        appendView ()
        getMyTeam()
        
    }
    func getMyTeam(){
//        self.showLoader()
        presenter.getMyTeam( onSuccess: { (goalKeepers, defenders, mids, attackers, subs, lineup) in
//            self.hideLoader()
            self.goalKeepers = goalKeepers
            self.defenders = defenders
            self.mids = mids
            self.attackers = attackers
            self.subs = subs
            self.fillView ()
        }) { (errorMessage) in
//            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func fillView (){
        let goalKeeper1 = self.goalKeepers[0]

        fillItem(players: goalKeeper1, button: self.goalKeeperBT, playerNameLbl: self.goalKeeperNameLbl, playerPointsLbl: self.playerPointLbl)

        
        let defender1 = self.defenders[0]
        let defender2 = self.defenders[1]
        let defender3 = self.defenders[2]
            
        fillItem(players: defender1, button: self.defendBT1, playerNameLbl: self.defendLbl1, playerPointsLbl: self.defendPointLbl1)
        fillItem(players: defender2, button: self.defendBT2, playerNameLbl: self.defendLbl2, playerPointsLbl: self.defendPointLbl2)
        fillItem(players: defender3, button: self.defendBT3, playerNameLbl: self.defendLbl3, playerPointsLbl: self.defendPointLbl3)
        if self.defenders.count >= 4 {
            self.defendView4.isHidden = false
            let defender4 = self.defenders[3]
            fillItem(players: defender4, button: self.defendBT4, playerNameLbl: self.defendLbl4, playerPointsLbl: self.defendPointLbl4)
        }else {
            self.defendView5.isHidden = true
        }
        if self.defenders.count >= 5 {
            self.defendView5.isHidden = false
            let defender5 = self.defenders[4]
            fillItem(players: defender5, button: self.defendBT5, playerNameLbl: self.defendLbl5, playerPointsLbl: self.defendPointLbl5)
            }

        
        let mid1 = self.mids[0]
        let mid2 = self.mids[1]
           
        fillItem(players: mid1, button: self.midBT1, playerNameLbl: self.midLbl1, playerPointsLbl: self.midPointLbl1)
        fillItem(players: mid2, button: self.midBT2, playerNameLbl: self.midLbl2, playerPointsLbl: self.midPointLbl2)
        if self.mids.count >= 3 {
            self.midView3.isHidden = false
            let mid3 = self.mids[2]
            fillItem(players: mid3, button: self.midBT3, playerNameLbl: self.midLbl3, playerPointsLbl: self.midPointLbl3)
        }else {
            self.midView4.isHidden = true
            self.midView5.isHidden = true
        }
        if self.mids.count >= 4 {
            self.midView4.isHidden = false
            let mid4 = self.mids[3]
            fillItem(players: mid4, button: self.midBT4, playerNameLbl: self.midLbl4, playerPointsLbl: self.midPointLbl4)
        }else {
            self.midView5.isHidden = true
        }
        if self.mids.count >= 5 {
            self.midView5.isHidden = false
            let mid5 = self.mids[4]
            fillItem(players: mid5, button: self.midBT5, playerNameLbl: self.midLbl5, playerPointsLbl: self.midPointLbl5)
        }
        
        let attacker1 = self.attackers[0]

        fillItem(players: attacker1, button: self.attackBT1, playerNameLbl: self.attackLbl1, playerPointsLbl: self.attackPointLbl1)
        if self.attackers.count >= 2 {
            self.attackView2.isHidden = false
            let attacker2 = self.attackers[1]
            fillItem(players: attacker2, button: self.attackBT2, playerNameLbl: self.attackLbl2, playerPointsLbl: self.attackPointLbl2)
        }else {
            self.attackView3.isHidden = true
        }
        if self.attackers.count >= 3 {
            self.attackView3.isHidden = false
            let attacker3 = self.attackers[2]
            fillItem(players: attacker3, button: self.attackBT3, playerNameLbl: self.attackLbl3, playerPointsLbl: self.attackPointLbl3)
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
        fillItem(players: sub1, button: self.subBT1, playerNameLbl: self.subNameLbl1, playerPointsLbl: self.subPointsLbl1)
        fillItem(players: sub2, button: self.subBT2, playerNameLbl: self.subNameLbl2, playerPointsLbl: self.subPointsLbl2)
        fillItem(players: sub3, button: self.subBT3, playerNameLbl: self.subNameLbl3, playerPointsLbl: self.subPointsLbl3)
        fillItem(players: subGoalkeeper, button: self.subBT4, playerNameLbl: self.subNameLbl4, playerPointsLbl: self.subPointsLbl4)

    }
    
    func fillItem (players : MyTeam, button : UIButton, playerNameLbl : UILabel, playerPointsLbl : UILabel){
        playerNameLbl.text = players.name_player
        if let points = players.point_player{
        playerPointsLbl.text = String(points)
        }
            button.sd_setImage(with: URL(string:Urls.baseUrl + players.image_player!), for: .normal)
            
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

    }

extension MyTeamVC : MyTeamProtocol {
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
                self.subView1.backgroundColor = Color.selectedPlayer.value
                self.subView2.backgroundColor = Color.selectedPlayer.value
                self.subView3.backgroundColor = Color.selectedPlayer.value
                self.subView4.alpha = 0.5
                self.subBT4.isEnabled = false

            }else{
                let type = player.type_loc_player
                if type == self.subsTypes[0]{
                    self.subView1.backgroundColor = Color.selectedPlayer.value
                }
                if type == self.subsTypes[1] {
                    self.subView2.backgroundColor = Color.selectedPlayer.value
                }
                if type == self.subsTypes[2] {
                    self.subView3.backgroundColor = Color.selectedPlayer.value
                }
                if type == "goalkeeper" {
                    self.subView4.backgroundColor = Color.selectedPlayer.value
                }
                
                
                if type != self.subsTypes[0]{
                    self.subView1.alpha = 0.5
                }
                if type != self.subsTypes[1] {
                    self.subView2.alpha = 0.5
                }
                if type != self.subsTypes[2] {
                    self.subView3.alpha = 0.5
                }
                if type != "goalkeeper" {
                    self.subView4.alpha = 0.5
                }
            }
        }) { (errorMessage) in
//            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
}
    

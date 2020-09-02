//
//  MatchDetailsVC.swift
//  GameClub
//
//  Created by Basma on 6/2/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class MatchDetailsVC: ParentViewController {
    var fixture = Fixtures()
    var details = DetailsModel()
    var page = 0
    var link = ""
    var firstTeam = ""
    var secondTeam = ""
    var firstTeamScore = 0
    var secondTeamScore = 0
    var presenter = PlayersPresenter()
     @IBOutlet weak var pageTitleLbl: UILabel!
        @IBOutlet weak var firstClubName: UILabel!
        @IBOutlet weak var firstClubIV: UIImageView!
        @IBOutlet weak var secondClubName: UILabel!
        @IBOutlet weak var secondClubIV: UIImageView!
    //    @IBOutlet weak var timeLabel: UILabel!
        @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var goalsLbl1: UILabel!
    @IBOutlet weak var goalsLbl2: UILabel!
    @IBOutlet weak var participateLbl1: UILabel!
    @IBOutlet weak var participateLbl2: UILabel!
    @IBOutlet weak var yellowLbl1: UILabel!
    @IBOutlet weak var yellowLbl2: UILabel!
    @IBOutlet weak var redLbl1: UILabel!
    @IBOutlet weak var savesLbl1: UILabel!
    @IBOutlet weak var savesLbl2: UILabel!
    @IBOutlet weak var redLbl2: UILabel!
    @IBOutlet weak var bounsLbl1: UILabel!
    @IBOutlet weak var bounsLbl2: UILabel!
    @IBOutlet weak var systemBounsLbl1: UILabel!
    @IBOutlet weak var systemBounsLbl2: UILabel!
    @IBOutlet weak var goalsView: UIView!
    @IBOutlet weak var assistsView: UIView!
    @IBOutlet weak var ycView: UIView!
    @IBOutlet weak var rcView: UIView!
    @IBOutlet weak var savesView: UIView!
    @IBOutlet weak var bonusView: UIView!
    @IBOutlet weak var bonusPSView: UIView!



    override func viewDidLoad() {
        super.viewDidLoad()
        fillMainDetails()
    }
 
    func fillMainDetails(){
        if page == 0 {
            if fixture.name_first != nil {
             
             firstClubIV.sd_setImage(with: URL(string: Urls.baseUrl+fixture.image_first! ), placeholderImage: UIImage(named: "placeholder"))
             secondClubIV.sd_setImage(with: URL(string: Urls.baseUrl+fixture.image_second! ), placeholderImage: UIImage(named: "placeholder"))
                 
            firstClubName.text = fixture.name_first
            secondClubName.text = fixture.name_second
            let title = fixture.name_first! + " & " + fixture.name_second!
            pageTitleLbl.text = title
            scoreLabel.text = String(fixture.first_goon!) + " - " + String(fixture.second_goon!)
             }
            fillItem (item : fixture.details!.goals!, view : goalsView, lbl1 : goalsLbl1, lbl2 : goalsLbl2)
            fillItem (item : fixture.details!.goalAssist!, view : assistsView, lbl1 : participateLbl1, lbl2 : participateLbl1)
            fillItem (item : fixture.details!.yellowCard!, view : ycView, lbl1 : yellowLbl1, lbl2 : yellowLbl2)
            fillItem (item : fixture.details!.redCard!, view : rcView, lbl1 : redLbl1, lbl2 : redLbl2)
            fillItem (item : fixture.details!.saves!, view : savesView, lbl1 : savesLbl1, lbl2 : savesLbl2)
             fillItem (item : fixture.details!.bouns!, view : bonusView, lbl1 : bounsLbl1, lbl2 : bounsLbl2)

        }else {
            firstClubName.text = firstTeam
            secondClubName.text = secondTeam
            let title = secondTeam + " & " + firstTeam
            pageTitleLbl.text = title
//            if "lang".localized == "en"{
//                scoreLabel.text = String(firstTeamScore) + " - " + String(secondTeamScore)
//            }else if "lang".localized == "ar"{
//                scoreLabel.text = String(secondTeamScore) + " - " + String(firstTeamScore)
//            }
            getMatchDetails()
        }
        

    }
    
    func fillItem (item : FixturesDetailsItemModel, view : UIView, lbl1 : UILabel, lbl2 : UILabel){
        if item.first_team?.isEmpty ?? false && item.second_team?.isEmpty ?? false {
            view.isHidden = true
        }else {
            let firstTeam = item.first_team
            let secondTeam = item.second_team
            var firstValueString = ""
            var secondValueString = ""
            var index = 0
            if !(item.first_team!.isEmpty) {
                
                for item in firstTeam! {
                    let value = item.value!
                    if index != firstTeam!.count - 1 {
                    firstValueString = firstValueString + item.player_name! + " (\(value))" + "\n"
                        index += 1
                    }else {
                    firstValueString = firstValueString + item.player_name! + " (\(value))"
                        index = 0
                    }
                }
                lbl1.text = firstValueString
            }
                if !(item.second_team!.isEmpty) {
                for item in secondTeam! {
                    let value = item.value!
                    if index != secondTeam!.count - 1 {
                    secondValueString = secondValueString + item.player_name! + "(\(value))" + "\n"
                        index += 1
                    }else {
                    secondValueString = secondValueString + item.player_name! + "(\(value))"
                        index = 0
                    }
                }
                    lbl2.text = secondValueString
            }
                
        }
    }
    func getMatchDetails(){
            self.showLoader()
            presenter.getPlayerMatchDetails(matchLink: link ,onSuccess: { (details, generalData) in
                if "lang".localized == "en"{
                    self.scoreLabel.text = String(generalData.first_goon!) + " - " + String(generalData.second_goon!)
                }else if "lang".localized == "ar"{
                    self.scoreLabel.text = String(generalData.second_goon!) + " - " + String(generalData.first_goon!)
                }
                self.fillItem (item : details.goals!, view : self.goalsView, lbl1 : self.goalsLbl1, lbl2 : self.goalsLbl2)
                self.fillItem (item : details.goalAssist!, view : self.assistsView, lbl1 : self.participateLbl1, lbl2 : self.participateLbl1)
                self.fillItem (item : details.yellowCard!, view : self.ycView, lbl1 : self.yellowLbl1, lbl2 : self.yellowLbl2)
                self.fillItem (item : details.redCard!, view : self.rcView, lbl1 : self.redLbl1, lbl2 : self.redLbl2)
                self.fillItem (item : details.saves!, view : self.savesView, lbl1 : self.savesLbl1, lbl2 : self.savesLbl2)
                self.fillItem (item : details.bouns!, view : self.bonusView, lbl1 : self.bounsLbl1, lbl2 : self.bounsLbl2)

                self.hideLoader()
            }) { (errorMessage) in
                self.hideLoader()
                self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
            }
        }
    }

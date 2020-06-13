//
//  MatchDetailsVC.swift
//  GameClub
//
//  Created by Basma on 6/2/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class MatchDetailsVC: ParentViewController {
    var matchGroup = MatchGroup()
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
    @IBOutlet weak var redLbl2: UILabel!
    @IBOutlet weak var bounsLbl1: UILabel!
    @IBOutlet weak var bounsLbl2: UILabel!
    @IBOutlet weak var systemBounsLbl1: UILabel!
    @IBOutlet weak var systemBounsLbl2: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        fillMainDetails()
    }
 
    func fillMainDetails(){
        let title = matchGroup.name_first! + " و " + matchGroup.name_second!
        pageTitleLbl.text = title
        firstClubName.text = matchGroup.name_first
        secondClubName.text = matchGroup.name_second
        firstClubIV.sd_setImage(with: URL(string: Urls.baseUrl+matchGroup.image_first! ), placeholderImage: UIImage(named: "placeholder"))
        secondClubIV.sd_setImage(with: URL(string: Urls.baseUrl+matchGroup.image_second! ), placeholderImage: UIImage(named: "placeholder"))
        
        let firstScore = matchGroup.first_goon
        let secondScore = matchGroup.second_goon
        
        var firstScoreString = ""
        var secondScoreString = ""
        if let score1 = firstScore{
            firstScoreString = String(score1)
        }
        if let score2 = secondScore{
            secondScoreString = String(score2)
        }
        scoreLabel.text = firstScoreString + " - " + secondScoreString
        goalsLbl1.text = "عمرو السومة 15'" + "\n" + "محمد احمد 30'" + "\n" + "عمرو السومة 15'" + "\n" + "محمد احمد 30'"
        goalsLbl2.text = "عمرو السومة 45'" + "\n" + "محمد احمد 60'"
    }
}

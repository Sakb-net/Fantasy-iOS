//
//  StandingMatchCell.swift
//  GameClub
//
//  Created by Basma on 11/20/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class StandingMatchCell: UITableViewCell {

    @IBOutlet weak var firstTeamLbl: UILabel!
    @IBOutlet weak var secondTeamLbl: UILabel!
    @IBOutlet weak var firstUserLbl: UILabel!
    @IBOutlet weak var secondUserLbl: UILabel!
    @IBOutlet weak var pointsLbl: UILabel!
    
    var matchStandingsCellViewModel : MatchStandingsCellViewModel? {
        didSet {
            firstTeamLbl.text = matchStandingsCellViewModel?.firstTeam
            secondTeamLbl.text = matchStandingsCellViewModel?.seacondTeam
            firstUserLbl.text = matchStandingsCellViewModel?.firstUsername
            secondUserLbl.text = matchStandingsCellViewModel?.secondUsername
            pointsLbl.text = (matchStandingsCellViewModel?.firstPoints ?? "??") + "-" + (matchStandingsCellViewModel?.secondPoints ?? "??") 
            
        }
    
}
}

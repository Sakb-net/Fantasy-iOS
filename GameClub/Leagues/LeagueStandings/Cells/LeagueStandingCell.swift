//
//  LeagueStandingCell.swift
//  GameClub
//
//  Created by Basma on 10/10/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class LeagueStandingCell: UITableViewCell {
    
    var delegate : OpenLeagueSettingsDelegate?
    var link = ""
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var rankLbl: UILabel!
    @IBOutlet weak var pointsLbl: UILabel!
    @IBOutlet weak var GWPointsLbl: UILabel!
    
    var leagueStandingsCellViewModel : LeagueStandingsCellViewModel? {
        didSet {
            nameLbl.text = leagueStandingsCellViewModel?.name
            rankLbl.text = leagueStandingsCellViewModel?.rank
            pointsLbl.text = leagueStandingsCellViewModel?.points
            GWPointsLbl.text = leagueStandingsCellViewModel?.GWPoints
            
        }
    }
    
}

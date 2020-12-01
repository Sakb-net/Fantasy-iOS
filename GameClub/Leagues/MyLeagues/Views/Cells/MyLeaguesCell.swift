//
//  MyLeaguesCell.swift
//  GameClub
//
//  Created by Basma on 9/19/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class MyLeaguesCell: UITableViewCell {
    var delegate : OpenLeagueSettingsDelegate?
    var link = ""
    var leagueType = ""
    @IBOutlet weak var leagueNameLbl: UILabel!
    @IBOutlet weak var leagueRankLbl: UILabel!
    @IBOutlet weak var pointsLbl: UILabel!
    @IBOutlet weak var optionBT: UIButton!
    
    @IBAction func optionAction(_ sender: Any) {
        delegate!.openLeagueSettings(link : leagueCellViewModel?.link ?? "", league: leagueCellViewModel?.leagueName ?? "", id: leagueCellViewModel?.id ?? 0, leagueType : leagueType)
    }
    var leagueCellViewModel : MyLeagueCellViewModel? {
        didSet {
            leagueNameLbl.text = leagueCellViewModel?.leagueName
            leagueRankLbl.text = leagueCellViewModel?.leagueRank
        }
    }
    
}

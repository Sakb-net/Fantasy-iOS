//
//  LeagueRankingCell.swift
//  SAKB FANTASY
//
//  Created by Basma on 1/19/21.
//  Copyright © 2021 Basma. All rights reserved.
//

import UIKit

class LeagueRankingCell: UITableViewCell {
    var delegate : LeagueRankingCellDelegate?
    var section = 0
    @IBOutlet weak var rankLbl: UILabel!
    @IBOutlet weak var teamLogoIV: UIImageView!
    @IBOutlet weak var teamNameLbl: UILabel!
    @IBOutlet weak var playsLbl: UILabel!
    @IBOutlet weak var winLbl: UILabel!
    @IBOutlet weak var drawLbl: UILabel!
    @IBOutlet weak var lossLbl: UILabel!
    @IBOutlet weak var teamsLbl: UILabel!
    @IBOutlet weak var pointsLbl: UILabel!
    @IBOutlet weak var dropDownBT: UIButton!
    @IBAction func dropDownAction(_ sender: Any) {
        delegate?.expandCell(section : section)
    }
    var leagueRankingCellViewModel : LeagueRankingCellViewModel? {
        didSet {
            rankLbl.text = leagueRankingCellViewModel?.rank
            teamNameLbl.text = leagueRankingCellViewModel?.teamName
            playsLbl.text = leagueRankingCellViewModel?.plays
            winLbl.text = leagueRankingCellViewModel?.win
            drawLbl.text = leagueRankingCellViewModel?.draw
            lossLbl.text = leagueRankingCellViewModel?.loss
            teamsLbl.text = leagueRankingCellViewModel?.teams
            pointsLbl.text = leagueRankingCellViewModel?.points
            teamLogoIV.sd_setImage(with: URL(string: "https://devfantasy.sakb-co.com.sa/" + (leagueRankingCellViewModel?.teamImageName ?? "") ), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

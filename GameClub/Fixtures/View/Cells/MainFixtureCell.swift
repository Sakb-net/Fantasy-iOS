//
//  MainFixtureCell.swift
//  GameClub
//
//  Created by Basma on 3/2/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class MainFixtureCell: UITableViewCell {

    var delegate : HideScoreLabel?
    @IBOutlet weak var firstClubName: UILabel!
    @IBOutlet weak var firstClubIV: UIImageView!
    @IBOutlet weak var secondClubName: UILabel!
    @IBOutlet weak var secondClubIV: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    func hideLabel (scoreLabel: UILabel, timeLabel : UILabel, type : Int){
        delegate?.hideScoreLabel(scoreLabel: scoreLabel, timeLabel : timeLabel, type : type)
    }
}
protocol HideScoreLabel {
    func hideScoreLabel(scoreLabel : UILabel, timeLabel : UILabel, type : Int)
}

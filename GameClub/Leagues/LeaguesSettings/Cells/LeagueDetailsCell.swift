//
//  LeagueDetailsCell.swift
//  GameClub
//
//  Created by Basma on 9/24/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class LeagueDetailsCell: UITableViewCell {
    var delegate : LeagueSettingsDelegate?
    @IBOutlet weak var leagueNameTF: UITextField!
    @IBOutlet weak var leagueTF: UITextField!
    @IBOutlet weak var downBT: UIButton!
    @IBOutlet weak var saveBT: UIButton!
    
    @IBAction func downAction(_ sender: Any) {
        delegate?.chooseRound(textField: leagueTF)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        delegate?.saveNewInfo(name: leagueNameTF.text)
    }
}

//
//  DeleteLeagueCell.swift
//  GameClub
//
//  Created by Basma on 9/24/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class DeleteLeagueCell: UITableViewCell {
    var delegate : LeagueSettingsDelegate?
    @IBOutlet weak var deleteBT: UIButton!
    
    @IBAction func deleteAction(_ sender: Any) {
        delegate?.DeleteUserLeague()
    }
}

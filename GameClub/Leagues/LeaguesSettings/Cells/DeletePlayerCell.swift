//
//  DeletePlayerCell.swift
//  GameClub
//
//  Created by Basma on 9/24/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class DeletePlayerCell: UITableViewCell {
    var delegate : LeagueSettingsDelegate?
    var isAdmin = true
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var playerTF: UITextField!
    @IBOutlet weak var dropDownBT: UIButton!
    @IBOutlet weak var removeBT: UIButton!
    @IBAction func dropDowanAction(_ sender: Any) {
        delegate?.openPopUp(textField : playerTF)
    }
    @IBAction func removeAction(_ sender: Any) {
        delegate?.addAdminOrDeletePlayer(isAdmin : isAdmin)
    }
    
}

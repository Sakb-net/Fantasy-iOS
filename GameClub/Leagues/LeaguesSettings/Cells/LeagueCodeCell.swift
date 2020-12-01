//
//  LeagueCodeCell.swift
//  GameClub
//
//  Created by Basma on 9/24/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class LeagueCodeCell: UITableViewCell {

    @IBOutlet weak var codeTF: UITextField!
    @IBOutlet weak var copyBT: UIButton!
    @IBOutlet weak var shareBT: UIButton!
    
    @IBAction func copyAction(_ sender: Any) {
        let code = codeTF.text
        let pasteboard = UIPasteboard.general
        pasteboard.string = code
    }
    @IBAction func shareAction(_ sender: Any) {
    }
}

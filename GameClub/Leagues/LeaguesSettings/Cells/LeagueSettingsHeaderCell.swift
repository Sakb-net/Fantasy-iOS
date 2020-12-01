//
//  LeagueSettingsHeaderCell.swift
//  GameClub
//
//  Created by Basma on 9/24/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class LeagueSettingsHeaderCell: UITableViewCell {
    var delegate : expandCellDelegate?
    var tableView : UITableView?
    var indexPath : IndexPath?
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var dropDownBT: UIButton!
    
    @IBAction func downAction(_ sender: Any) {
    
        delegate?.expandCell(tableView: tableView!, indexPath: indexPath!, button: dropDownBT)
    }
    
}
protocol expandCellDelegate {
    func expandCell(tableView : UITableView, indexPath : IndexPath, button : UIButton)
}

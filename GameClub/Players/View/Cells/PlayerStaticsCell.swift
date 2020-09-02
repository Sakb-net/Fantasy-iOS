//
//  PlayerStaticsCell.swift
//  GameClub
//
//  Created by Basma on 7/2/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class PlayerStaticsCell: UITableViewCell {

    var delegate : ViewMatchDetails?
    var index : Int?
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    @IBOutlet weak var pointsLbl: UILabel!
//    @IBOutlet weak var CSValueLbl: UILabel!
//    @IBOutlet weak var CSPointsLbl: UILabel!
    @IBOutlet weak var GWValueLbl: UILabel!
    @IBOutlet weak var ICTLbl: UILabel!
    @IBOutlet weak var FormLbl: UILabel!
    @IBOutlet weak var viewMatchBT: UIButton!
    @IBAction func viewMatchAction(_ sender: Any) {
        delegate?.viewMatch(index: index!)
    }
}
protocol ViewMatchDetails {
    func viewMatch (index : Int)
}

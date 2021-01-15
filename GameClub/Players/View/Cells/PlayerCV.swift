//
//  PlayerCV.swift
//  GameClub
//
//  Created by Basma on 3/9/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class PlayerCV: UITableViewCell {
    var delegate : PlayerCellDelegate?
    var player = Player()
    @IBOutlet weak var nameBT: UIButton!
    @IBOutlet weak var infoBT: UIButton!
    @IBOutlet weak var positionLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var pointsLbl: UILabel!
    @IBOutlet weak var teamIV: UIImageView!
    @IBOutlet weak var addBT: UIButton!
    @IBAction func addAction(_ sender: Any) {
        delegate?.AddPlayer(player: player)
    }
    @IBAction func viewInfoAction(_ sender: Any) {
        delegate?.ViewInfo(player: player)
    }
    @IBAction func infoNameAction(_ sender: Any) {
        delegate?.ViewInfo(player: player)
    }
}

protocol PlayerCellDelegate {
    func AddPlayer(player: Player)
    func ViewInfo(player: Player)
}

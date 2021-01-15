//
//  LinksCell.swift
//  GameClub
//
//  Created by Basma on 6/27/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class LinksCell: UITableViewCell {

    @IBOutlet weak var myPointsView: UIView!
    @IBOutlet weak var myTeamView: UIView!
    @IBOutlet weak var transferesView: UIView!
    @IBOutlet weak var myPointsIV: UIImageView!
    @IBOutlet weak var myTeamIV: UIImageView!
    @IBOutlet weak var transferesIV: UIImageView!
    @IBOutlet weak var myPointsLbl: UILabel!
    @IBOutlet weak var myTeamLbl: UILabel!
    @IBOutlet weak var transLbl: UILabel!


    @IBOutlet weak var linksView: UIStackView!

    override func awakeFromNib() {
        if "lang".localized == "ar" {
            myPointsLbl.textAlignment = .right
            myTeamLbl.textAlignment = .right
            transLbl.textAlignment = .right
        }else {
            myPointsLbl.textAlignment = .left
            myTeamLbl.textAlignment = .left
            transLbl.textAlignment = .left
        }
    }
}

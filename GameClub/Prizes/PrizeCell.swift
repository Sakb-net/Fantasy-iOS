//
//  PrizeCell.swift
//  GameClub
//
//  Created by Basma on 6/6/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class PrizeCell: UITableViewCell {
    @IBOutlet weak var markView: UIView!
    @IBOutlet weak var prizeLbl: UILabel!
    
    override func awakeFromNib() {
        if "lang".localized == "ar"{
            prizeLbl.textAlignment = .right
        }else {
            prizeLbl.textAlignment = .left
        }
    }
}

//
//  InstructionsCell.swift
//  GameClub
//
//  Created by Basma on 4/16/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class InstructionsCell: UITableViewCell {
    var delegate : InstructionsDelegate?
    var isExpanded = true
    var index = 0
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dropDownBT: UIButton!
    @IBOutlet weak var contentTV: UITextView!
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    @IBOutlet var hightConstraint: NSLayoutConstraint!

    @IBAction func dropDownAction(_ sender: Any){
        self.delegate?.showHideTV(contentTV: self.contentTV, bottomConstraint: [self.bottomConstraint, hightConstraint], isExpanded : isExpanded, index: index)
    }
    
}

protocol InstructionsDelegate {
    func showHideTV (contentTV : UITextView, bottomConstraint : [NSLayoutConstraint], isExpanded : Bool, index : Int)
}

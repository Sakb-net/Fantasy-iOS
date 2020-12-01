//
//  NotifyTypeCell.swift
//  GameClub
//
//  Created by Basma on 11/24/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class NotifyTypeCell: UITableViewCell {
    
    var delegate :NotifyTypeDelegate?
    var index = 0
    var notifyBTChecked = false
    var emailBTChecked = false
    @IBOutlet weak var teamLbl: UILabel!
    @IBOutlet weak var notificationBT: UIButton!
    @IBOutlet weak var emailBT: UIButton!
    @IBAction func notificationAction(_ sender: Any) {
        delegate?.getNotifiedByNotifi(bt: notificationBT, index: index, isChecked: notifyBTChecked)
    }
    @IBAction func emailAction(_ sender: Any) {
        delegate?.getNotifiedByEmail(bt: emailBT, index: index, isChecked: emailBTChecked)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
protocol NotifyTypeDelegate {
    func getNotifiedByEmail(bt : UIButton, index : Int, isChecked : Bool)
    func getNotifiedByNotifi(bt : UIButton, index : Int, isChecked : Bool)
}

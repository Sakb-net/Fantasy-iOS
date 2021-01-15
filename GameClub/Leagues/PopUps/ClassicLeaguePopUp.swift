//
//  ClassicLeaguePopUp.swift
//  GameClub
//
//  Created by Basma on 5/30/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class ClassicLeaguePopUp: ParentViewController {
    var code = ""
    var delegate : navigationForClassicDelegate?
    var link = ""
    var leagueType = ""
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var codeLbl: UILabel!
    @IBOutlet weak var settingsBT: UIButton!
    @IBOutlet weak var myLeagueBT: UIButton!
    @IBAction func settingsAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
        delegate?.openSettings(link: link, leagueType: leagueType)
    }
    @IBAction func myLeaguesAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
        delegate?.openMyLeagues()
    }
    @IBAction func CopyAction(_ sender: Any) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = code
    }
    @IBAction func ShareAction(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        roundViewCornersNoShadow(view: containerView)
        roundViewCornersNoShadow(view: settingsBT)
        roundViewCornersNoShadow(view: myLeagueBT)
        roundViewCornersNoShadow(view: codeLbl)
        codeLbl.text = code
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let touchedView = touch.view, touchedView != containerView {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
protocol navigationForClassicDelegate {
    func openSettings(link: String, leagueType: String)
    func openMyLeagues()
}

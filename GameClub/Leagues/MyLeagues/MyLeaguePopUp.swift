//
//  MyLeaguePopUp.swift
//  GameClub
//
//  Created by Basma on 9/26/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class MyLeaguePopUp: ParentViewController {
    var leagueType = ""
    var link = ""
    var league = ""
    var id = 0
    var delegate : openSettingsDelegate?
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var standingsBT: UIButton!
    @IBOutlet weak var settingsBT: UIButton!
    @IBOutlet weak var leaveBT: UIButton!
    @IBAction func standingsAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
        delegate?.openStandings(link : link, league: league, leagueType: leagueType)
    }
    @IBAction func settingsAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
        delegate?.openSettings(link: link, leagueType : leagueType)
    }
    @IBAction func leaveAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
        delegate?.leaveLeague(link: link, leagueType: leagueType)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initView() 
    }
    func initView() {
        roundViewCornersNoShadow(view: standingsBT)
        roundViewCornersNoShadow(view: settingsBT)
        roundViewCornersNoShadow(view: leaveBT)
        roundViewCorners(view: containerView)
        if id != User.shared().id {
            settingsBT.isHidden = true
        }else {
            leaveBT.isHidden = true
        }

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let touchedView = touch.view, touchedView != containerView {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
protocol openSettingsDelegate {
    func openSettings(link : String, leagueType : String)
    func openStandings(link : String, league : String, leagueType : String)
    func leaveLeague(link : String, leagueType : String)
}

//
//  SubPlayersPopUp.swift
//  GameClub
//
//  Created by Basma on 4/11/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class SubPlayersPopUp: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    var players : [MyTeam]?
    var selectedPlayer : MyTeam?
    var secondPlayer = MyTeam()
    var presenter = MyTeamPresenter ()
    var delegate : SubListDelegate?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        roundViewCornersNoShadow(view: tableView)
        roundViewCornersNoShadow(view: containerView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.players!.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "SubPlayerHeaderCell", for: indexPath) as! SubPlayerHeaderCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "SubPlayersCell", for: indexPath) as! SubPlayersCell
        
        if indexPath.row == 0 {
            return cell1
        }else {
            cell2.nameLbl.text = self.players![indexPath.row - 1].name_player
            cell2.locLbl.text = self.players![indexPath.row - 1].team! + " " + self.players![indexPath.row - 1].location_player!
            if let points = self.players![indexPath.row - 1].point_player {
                cell2.pointsLbl.text = String(points)
            }
            if let price = self.players![indexPath.row - 1].cost_player {
                cell2.priceLbl.text = String(price)
            }
            let player = self.players![indexPath.row - 1].type_key_coatch
            if self.players![indexPath.row - 1].type_key_coatch == "captain" {
                cell2.captain_assisIV.isHidden = false
            }else if self.players![indexPath.row - 1].type_key_coatch == "sub_captain"{
                cell2.captain_assisIV.isHidden = false
                cell2.captain_assisIV.image = UIImage(named: "v-icon")
            }else {
                cell2.captain_assisIV.isHidden = true
            }
            return cell2
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.secondPlayer = self.players![indexPath.row - 1]
        subPlayers()
    }
    
    func subPlayers() {
        self.presenter.addPlayerWithLink(playerLink1: self.selectedPlayer!.link_player!, playerLink2: self.secondPlayer.link_player!,onSuccess: { (response) in
                    //            self.showAlert(title: "", message: response, shouldpop: false)
            self.delegate?.reloadVCData()
            self.dismiss(animated: true, completion: nil)

                                }) { (errorMessage) in
                    //                self.hideLoader()
                                    self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
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

protocol SubListDelegate {
    func reloadVCData()
}

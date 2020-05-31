//
//  BestLeagueVC.swift
//  GameClub
//
//  Created by Basma on 5/29/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SideMenu

class BestLeagueVC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    var leaguesNames = ["الدوري الأول","الدوري الثاني","الدوري الثالث","الدوري الرابع","الدوري الخامس"]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    @IBAction func menuAction(_ sender: Any) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! UISideMenuNavigationController
                    present(menu, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        roundViewCornersNoShadow(view: containerView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BestLeagueCell", for: indexPath) as! BestLeagueCell
        cell.nameLbl.text = leaguesNames[indexPath.row]
        let order = indexPath.row + 1
        cell.orderLbl.text = String(order)
        roundViewCornersNoShadow(view: cell.joinBT)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bestLeaguePopUp = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "BestLeaguePopUp") as! BestLeaguePopUp
        present(bestLeaguePopUp, animated: true
            , completion: nil)
    }

}

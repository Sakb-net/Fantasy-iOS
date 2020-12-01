//
//  LeaguesVC.swift
//  GameClub
//
//  Created by Basma on 5/21/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SideMenu

class LeaguesVC: ParentViewController {
    @IBOutlet weak var specialLeagueBT: UIButton!
    @IBOutlet weak var powerfulLeaguesBT: UIButton!
    @IBOutlet weak var headToHeadBT: UIButton!
    @IBOutlet weak var classicBT: UIButton!
    @IBOutlet weak var myLeagueBT: UIButton!
    
    @IBAction func joinHeadLeagueAction(_ sender: Any) {
        let joinLeagueVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "JoinLeagueVC") as! JoinLeagueVC
        joinLeagueVC.typeLeague = "head"
        self.navigationController?.pushViewController(joinLeagueVC, animated: true)
    }
    @IBAction func joinClassicLeagueAction(_ sender: Any) {
        let joinLeagueVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "JoinLeagueVC") as! JoinLeagueVC
        joinLeagueVC.typeLeague = "classic"
        self.navigationController?.pushViewController(joinLeagueVC, animated: true)
    }
    @IBAction func myLeagueAction(_ sender: Any) {
        let myLeaguesViewController = MyLeaguesViewController(nibName: "MyLeaguesViewController", bundle: nil)
        self.navigationController?.pushViewController(myLeaguesViewController, animated: true)
    }
    
    @IBAction func menuAction(_ sender: Any) {
        self.openMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designConfig ()
    }
    
    func designConfig (){
        roundViewCornersNoShadow(view: specialLeagueBT)
        roundViewCornersNoShadow(view: powerfulLeaguesBT)
        roundViewCornersNoShadow(view: headToHeadBT)
        roundViewCornersNoShadow(view: classicBT)
        roundViewCornersNoShadow(view: myLeagueBT)
    }
}

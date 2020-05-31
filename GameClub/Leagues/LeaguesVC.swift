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

    @IBAction func menuAction(_ sender: Any) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! UISideMenuNavigationController
        present(menu, animated: true, completion: nil)
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
    }
}

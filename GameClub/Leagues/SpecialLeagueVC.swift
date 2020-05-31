//
//  SpecialLeagueVC.swift
//  GameClub
//
//  Created by Basma on 5/21/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SideMenu

class SpecialLeagueVC: ParentViewController {

    @IBOutlet weak var codeViewContainer: UIView!
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var sendBT: UIButton!
    @IBAction func sendAction(_ sender: Any) {
        let successPopUP = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "SuccessPopUP") as! SuccessPopUP
        present(successPopUP, animated: true
            , completion: nil)
    }
    
    @IBAction func menuAction(_ sender: Any) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! UISideMenuNavigationController
               present(menu, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        roundViewCornersNoShadow(view: sendBT)
        roundViewCornersNoShadow(view: codeViewContainer)

    }
}

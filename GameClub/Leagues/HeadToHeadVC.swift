//
//  HeadToHeadVC.swift
//  GameClub
//
//  Created by Basma on 5/29/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SideMenu

class HeadToHeadVC: ParentViewController {
    @IBOutlet weak var roundsBT: UIButton!
    @IBOutlet weak var limitsBT: UIButton!
       @IBOutlet weak var leagueNameTF: UITextField!
       @IBOutlet weak var codeViewContainer: UIView!
          @IBOutlet weak var mainLbl: UILabel!
          @IBOutlet weak var createBT: UIButton!
    @IBOutlet weak var mainContainer: UIView!
    @IBAction func createAction(_ sender: Any) {
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
              roundViewCornersNoShadow(view: createBT)
              roundViewCornersNoShadow(view: codeViewContainer)
              roundViewCornersNoShadow(view: mainContainer)
          }
      
}

//
//  MyPointsVC.swift
//  GameClub
//
//  Created by Basma on 4/18/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SideMenu

class MyPointsVC: ParentViewController {
    
    @IBAction func menuAction(_ sender: Any) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! UISideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}

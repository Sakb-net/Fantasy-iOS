//
//  CheckVC.swift
//  SAKB FANTASY
//
//  Created by Basma on 1/14/21.
//  Copyright © 2021 Basma. All rights reserved.
//

import UIKit

class CheckVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        if User.shared().access_token == nil {
            let startPageVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "StartPageVC") as! StartPageVC
            self.navigationController?.pushViewController(startPageVC, animated: true)
        }else {
            let email = User.shared().email
            let addTeam = UserDefaults.standard.integer(forKey: email ?? "")
            if addTeam == 1 {
                let homeVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                self.navigationController?.pushViewController(homeVC, animated: true)
            }else {
                let startPageVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "StartPageVC") as! StartPageVC
                self.navigationController?.pushViewController(startPageVC, animated: true)
            }  
        }
    }
}

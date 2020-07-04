//
//  NoTeamVC.swift
//  GameClub
//
//  Created by Basma on 5/16/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SideMenu

class NoTeamVC: ParentViewController {
    var isLogin = false
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var chooseTeamBT: UIButton!
    @IBAction func chooseTeamAction(_ sender: Any) {
        if isLogin {
            let loginVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(loginVC, animated: true)
        }else {
            let pitchVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "PitchVC") as! PitchVC
            self.navigationController?.pushViewController(pitchVC, animated: true)
        }
    }
    @IBAction func menuAction(_ sender: Any) {
    let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! UISideMenuNavigationController
            present(menu, animated: true, completion: nil)
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.removeViewController(MyTeamVC.self)
        roundViewCornersNoShadow(view: chooseTeamBT)
        if isLogin {
            messageLbl.text = "You should Login first".localized
            chooseTeamBT.setTitle("Login".localized, for: .normal)
        }
    }
}
extension UINavigationController {

    func removeViewController(_ controller: UIViewController.Type) {
        if let viewController = viewControllers.first(where: { $0.isKind(of: controller.self) }) {
            viewController.removeFromParent()
        }
    }
}

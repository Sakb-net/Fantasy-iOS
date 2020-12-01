//
//  AccountVC.swift
//  GameClub
//
//  Created by Basma on 4/25/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SideMenu
import SkyFloatingLabelTextField
class AccountVC: ParentViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userIV: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var editProfileBT: UIButton!
    @IBOutlet weak var emailTF: SkyFloatingLabelTextField!
    @IBOutlet weak var favTeamTF: SkyFloatingLabelTextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var changePassBT: UIButton!
    @IBOutlet weak var backBT: UIButton!
    @IBOutlet weak var menuBT: UIButton!
    @IBAction func menuAction(_ sender: Any) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! UISideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func editProfileAction(_ sender: Any) {
    }
    @IBAction func changePassACtion(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
        let apiImgLink = User.shared().image ?? ""
        let imageLink = apiImgLink.replacingOccurrences(of: "https://fantgame.sakb-co.com.sa/", with: "")
        userIV.sd_setImage(with: URL(string: Urls.baseUrl +  imageLink), placeholderImage: UIImage(named: "user"))
        
    }
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = User.shared().display_name
        favTeamTF.text = User.shared().team_name
        emailTF.text = User.shared().email
        passTF.text = UserDefaults.standard.value(forKey: "password") as? String
        print(User.shared().access_token)
    }
    
    func viewConfig(){
        passTF.delegate = self
        emailTF.delegate = self
        favTeamTF.delegate = self
        
        self.favTeamTF.leftViewMode = .always
        if "lang".localized == "ar" {
            self.favTeamTF.textAlignment = .right
            self.emailTF.textAlignment = .right
            self.emailTF.titleLabel.textAlignment = .right
            self.favTeamTF.titleLabel.textAlignment = .right
        }else {
            self.favTeamTF.textAlignment = .left
            self.emailTF.textAlignment = .left
            self.emailTF.titleLabel.textAlignment = .left
            self.favTeamTF.titleLabel.textAlignment = .left
        }
        roundViewCorners(view: containerView)
        roundViewCornersNoShadow(view: userIV)
        roundViewCornersNoShadow(view: changePassBT)
    }

}

//
//  StartPageVC.swift
//  SAKB FANTASY
//
//  Created by Basma on 1/14/21.
//  Copyright © 2021 Basma. All rights reserved.
//

import UIKit
import SideMenu

class StartPageVC: ParentViewController {
    var addTeam = 0
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var chooseTeamBT: UIButton!
    @IBOutlet weak var loginBT: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!

    @IBAction func chooseTeamAction(_ sender: Any) {
        
        if User.shared().access_token == nil {
            let loginVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(loginVC, animated: true)
        }else{
            if addTeam == 1 {
                let myTeamVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "MyTeamVC") as! MyTeamVC
                self.navigationController?.pushViewController(myTeamVC, animated: true)
            }else {
                let myTeamVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "PitchVC") as! PitchVC
                self.navigationController?.pushViewController(myTeamVC, animated: true)
            }
        }
    }
    @IBAction func loginAction(_ sender: Any) {
        if User.shared().access_token == nil {
            let loginVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(loginVC, animated: true)
        }else {
            User.shared().logoutUser()
            loginBT.setTitle("Login".localized, for: .normal)
        }
    }
    
    @IBAction func menuAction(_ sender: Any) {
        let menu = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "RightMenu") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.removeViewController(LoginVC.self)
        navigationController!.removeViewController(CheckVC.self)
        navigationController!.removeViewController(NotifyTypeVC.self)
        navigationController!.removeViewController(FavTeamVC.self)

        navigationController?.navigationBar.isHidden = true
        let email = User.shared().email
        addTeam = UserDefaults.standard.integer(forKey: email ?? "")
        viewConfig()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if User.shared().access_token == nil {
            loginBT.setTitle("Login".localized, for: .normal)
        }else{
            loginBT.setTitle("Logout".localized, for: .normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let email = User.shared().email
        if UserDefaults.standard.integer(forKey: email ?? "") == 1{
            let homeVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            self.navigationController?.pushViewController(homeVC, animated: false)
        }
    }
    
    func viewConfig(){
        roundViewCorners(view: headerView)
        roundViewCornersNoShadow(view: chooseTeamBT)
    }
}


extension StartPageVC : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SponsorsCVC", for: indexPath) as! SponsorsCVC
        
        return cell

    }
}

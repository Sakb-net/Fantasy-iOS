//
//  ClassicLeagueVC.swift
//  GameClub
//
//  Created by Basma on 5/21/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SideMenu

class ClassicLeagueVC: ParentViewController {
    var gmPresenter = FixturesPresenter()
    var gameWeeks = [GWsPointsModel]()
    var currentGWLink = ""
    @IBOutlet weak var roundsBT: UIButton!
    @IBOutlet weak var leagueNameTF: UITextField!
    @IBOutlet weak var codeViewContainer: UIView!
    @IBOutlet weak var createBT: UIButton!
    @IBOutlet weak var mainContainer: UIView!
    @IBAction func gameWeeksAction(_ sender: Any) {
        let dropDownVC = Storyboard().dropDownStoryboard.instantiateViewController(withIdentifier: "DropDownVC") as! DropDownVC
        dropDownVC.selectDelegate = self
        dropDownVC.selectedType = .gameWeek
        dropDownVC.gameWeeks = gameWeeks
        
        present(dropDownVC, animated: true
            , completion: nil)
    }
    @IBAction func createAction(_ sender: Any) {
        guard let leagueName = self.leagueNameTF.text, leagueName != "" else {
            self.showAlert(title: "", message: "Please enter league name.".localized, shouldpop: false)
            return
        }
        if isNetworkReachable {
            createLeague (name : leagueName)
        }else{
            self.showAlert(title: "", message: "Internet is not available", shouldpop: true)
        }
    }
    
    @IBAction func menuAction(_ sender: Any) {
        openMenu()
    }
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        roundViewCornersNoShadow(view: createBT)
        roundViewCornersNoShadow(view: codeViewContainer)
        roundViewCornersNoShadow(view: mainContainer)
        getGameWeeks ()
    }
    
    func createLeague (name : String){
        let parameters:[String:Any] = [
            "link_subeldwry": currentGWLink,
            "name" : name
        ]
        let url = Urls().createLeague(type : "classic")
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let data = response!["data"]["status"].intValue
                if data == 1 {
                    let code = response!["data"]["group_eldwry"]["code"].stringValue
                    let classicLeaguePopUp = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "ClassicLeaguePopUp") as! ClassicLeaguePopUp
                    classicLeaguePopUp.code = code
                    classicLeaguePopUp.delegate = self
                    self.present(classicLeaguePopUp, animated: true
                        , completion: nil)
                }
            }else{
                //failure
            }
        }
    }
    
    func getGameWeeks (){
        self.showLoader()
        PointsPresenter().getPointsGWs(onSuccess: { (gameWeeks) in
            self.gameWeeks = gameWeeks
            self.currentGWLink = gameWeeks[0].link!
            self.roundsBT.setTitle(gameWeeks[0].lang_num_week, for: .normal)
            self.hideLoader()
        }) { (errorMessage, code) in
            self.hideLoader()
            if code == 11 || code == 41{
                
            }else {
                self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
            }
        }
    }
    
}
extension ClassicLeagueVC : SelectedDropDownType, navigationForClassicDelegate{
    func openSettings() {
        let leaguesSettingsViewController = LeaguesSettingsViewController(nibName: "LeaguesSettingsViewController", bundle: nil)
        self.navigationController?.pushViewController(leaguesSettingsViewController, animated: false)
    }
    
    func openMyLeagues() {
        let myLeaguesViewController = MyLeaguesViewController(nibName: "MyLeaguesViewController", bundle: nil)
        self.navigationController?.pushViewController(myLeaguesViewController, animated: false)
    }
    
    func selectedType(selectedType: DropDownTypes, selectedItem: Any) {
        if selectedType == .gameWeek {
            let selectedGW = selectedItem as! GWsPointsModel
            roundsBT.setTitle(selectedGW.lang_num_week, for: .normal)
            self.currentGWLink = selectedGW.link!
        }
    }
}

//
//  SpecialLeagueVC.swift
//  GameClub
//
//  Created by Basma on 5/21/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SideMenu

class JoinLeagueVC: ParentViewController {
    var typeLeague = "classic"
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var leagueTypeLbl: UILabel!
    @IBOutlet weak var codeViewContainer: UIView!
    @IBOutlet weak var sendBT: UIButton!
    @IBOutlet weak var codeTF: UITextField!
    @IBAction func sendAction(_ sender: Any) {
        guard let code = self.codeTF.text, code != "" else {
            self.showAlert(title: "", message: "Please enter league code.".localized, shouldpop: false)
            return
        }
        if isNetworkReachable {
            joinLeague (code : code)
        }else{
            self.showAlert(title: "", message: "Internet is not available", shouldpop: true)
        }
    }
    
    @IBAction func menuAction(_ sender: Any) {
        openMenu()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        roundViewCornersNoShadow(view: sendBT)
        roundViewCornersNoShadow(view: codeViewContainer)
        if typeLeague == "head" {
            titleLbl.text = "Head to head".localized
            leagueTypeLbl.text = "Join Head to head league".localized
        }else {
            titleLbl.text = "Classic".localized
            leagueTypeLbl.text = "Join classic league".localized
        }
    }
    func joinLeague (code : String){
        let parameters:[String:Any] = [
            "val_code": code
        ]
        let url = Urls().joinLeague(type: typeLeague)
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let data = response!["data"]["status"].intValue
                if data == 2 {
                    let successPopUP = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "SuccessPopUP") as! SuccessPopUP
                    self.present(successPopUP, animated: true
                        , completion: nil)
                }
            }else{
                //failure
            }
        }
    }
}

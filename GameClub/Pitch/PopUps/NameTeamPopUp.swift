//
//  NameTeamPopUp.swift
//  GameClub
//
//  Created by Basma on 3/21/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class NameTeamPopUp: ParentViewController {

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var saveBT: UIButton!
    @IBAction func saveAction(_ sender: Any) {
        saveName ()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
    }
    
    func saveName () {
        guard let name = self.nameTF.text, name != "" else {
            self.showAlert(title: "", message: "الرجاء إدخال اسم الفريق", shouldpop: false)
            return
        }
        self.showLoader()
        self.nameTeam(name: name, onSuccess: { (message) in
            self.showAlert(title: "", message: message, shouldpop: false)
            self.dismiss(animated: true, completion: nil)

            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
        
    }
    
    func viewConfig(){
        roundViewCorners(view: self.popUpView)
        roundViewCornersNoShadow(view: self.saveBT)
    }

    func nameTeam(name:String, onSuccess: @escaping (String) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().nameMyTeam()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage(),
            "name_team": name
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                let message = response!["Message"].stringValue
                    
                    onSuccess(message)
                    
                }else{
                    let message = response!["Message"].stringValue
                    onFailure(message)
                }
            }
            else
            {
                onFailure(error!.localizedDescription)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let touchedView = touch.view, touchedView != popUpView {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

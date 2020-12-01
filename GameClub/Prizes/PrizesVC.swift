//
//  PrizesVC.swift
//  GameClub
//
//  Created by Basma on 6/6/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SideMenu

class PrizesVC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    let titles = ["  جائزة المركز الأول:", "  جائزة المركز الثاني:", "  جائزة المركز الثالث:"]
    var prizes = [PrizeCatModel] ()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return prizes.count
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return self.titles[section]
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerText = UILabel()
        headerText.adjustsFontSizeToFitWidth = true
        headerText.textAlignment = .center
        headerText.font = UIFont(name:"HelveticaNeueW23forSKY-Reg",size:15)

        headerText.text = self.prizes[section].title

        return headerText
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prizes[section].content!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrizeCell", for: indexPath) as! PrizeCell
        roundViewCornersNoShadow(view: cell.markView)
        cell.prizeLbl.text = self.prizes[indexPath.section].content![indexPath.row]
        return cell
    }
    

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func menuAction(_ sender: Any) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! UISideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        roundViewCornersNoShadow(view: containerView)
        roundViewCornersNoShadow(view: tableView)
        
        
        getPrizes(onSuccess: { (response) in
            self.prizes = response
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
            }) { (errorMessage) in
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
            }
        
    }
    func getPrizes(onSuccess: @escaping ([PrizeCatModel]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().prizes()
        
        ServiceManager.callAPI(url: url, method: .post, parameters: nil, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                if let data = response!["data"].dictionary {
                    var prizes = [PrizeCatModel]()
                    
                    for item in data["content_items"]?.arrayValue ?? [] {
                        prizes.append(PrizeCatModel(parametersJson: item.dictionaryValue))
                    }
                    onSuccess(prizes)
                    }
                    
                }else{
                    let message = response!["Message"].stringValue
                    onFailure(message)
                }
            }
            else
            {
                onFailure("Something went wrong try again later!".localized)
            }
        }
    }
}

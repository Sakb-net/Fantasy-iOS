//
//  SubDaweryPopUp.swift
//  SAKB FANTASY
//
//  Created by Basma on 1/26/21.
//  Copyright © 2021 Basma. All rights reserved.
//

import UIKit

class SubDaweryPopUp: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    var delegate : SubDaweryPopUpDelegate?
    var subDaweryModels = [SubDaweryModel]()
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subDaweryModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 50
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubDaweryCell", for: indexPath) as! SubDaweryCell
        cell.subDaweryLbl.text = subDaweryModels[indexPath.row].lang_num_week
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
        delegate?.returnSubDawery(model:subDaweryModels[indexPath.row])
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        getGWs()
    }
    
    func initView(){
        tableView.register(LeagueRankingExtendedCell.self, forCellReuseIdentifier: "SubDaweryCell")
        tableView.register(UINib(nibName: "SubDaweryCell", bundle: nil), forCellReuseIdentifier: "SubDaweryCell")
        tableView.delegate = self
        tableView.dataSource = self
        roundViewCornersNoShadow(view: tableView)
    }
    
    func getGWs()
    {
        let url = "https://devfantasy.sakb-co.com.sa/api/v1/ranking_eldwry/subeldwry"
        
        ServiceManager.callAPI(url: url, method: .get, parameters: nil, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    if let data = response!["data"].array {
                        
                        for subDaweryItem in data {
                            self.subDaweryModels.append(SubDaweryModel(parametersJson: subDaweryItem.dictionaryValue))
                        }
                        self.tableView.reloadData()
                    }else{
                    }
                }else{
                    let message = response!["Message"].stringValue
                }
            }
            else
            {
                let message = "Something went wrong try again later!".localized
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if let touchedView = touch.view, touchedView != tableView {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
protocol SubDaweryPopUpDelegate {
    func returnSubDawery(model : SubDaweryModel)
}

//
//  MyLeaguesViewController.swift
//  GameClub
//
//  Created by Basma on 9/19/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SideMenu

class MyLeaguesViewController: ParentViewController {
    var classicLeagueCount = 0
    var viewModel = MyLeaguesViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    @IBAction func menuAction(_ sender: Any) {
        openMenu()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initView ()
        initViewModel ()
    }
    
    func initViewModel (){
        viewModel.updateState = {[weak self] () in
            DispatchQueue.main.async {
                switch self?.viewModel.state {
                case .error:
                    //                   self?.indicator.stopAnimating()
                    //                   self?.collectionView.alpha = 0.0
                    self?.showAlert(title: "", message: "Your Leagues are not available right now, try again later.".localized, shouldpop: false)
                case .loading:
                    //                   self?.indicator.startAnimating()
                    //                   self?.indicator.alpha = 1.0
                    //                   self?.collectionView.alpha = 0.0
                    //                   self?.noPhotosLbl.alpha = 0.0
                    break
                case .loaded:
                    //                   self?.indicator.stopAnimating()
                    //                   self?.collectionView.alpha = 1.0
                    break
                case .empty:
                    //                   self?.indicator.stopAnimating()
                    //                   self?.collectionView.alpha = 0.0
                    //                   self?.indicator.alpha = 0.0
                    //                   self?.noPhotosLbl.alpha = 1.0
                    break
                    
                case .none: break
                    
                }
            }
        }
        viewModel.reloadTableView = { [weak self]() in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getMyLeagues()
    }
    
    func initView (){
        roundViewCorners(view: containerView)
        tableView.register(MyLeaguesHeaderCell.self, forCellReuseIdentifier: "MyLeaguesHeaderCell")
        tableView.register(MyLeaguesCell.self, forCellReuseIdentifier: "MyLeaguesCell")
        tableView.register(UINib(nibName: "MyLeaguesCell", bundle: nil), forCellReuseIdentifier: "MyLeaguesCell")
        tableView.register(UINib(nibName: "MyLeaguesHeaderCell", bundle: nil), forCellReuseIdentifier: "MyLeaguesHeaderCell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    func leaveLeagueByLink (link: String, leagueType : String){
        let url = Urls().leaveLeague(link: link, type : leagueType)
        
        ServiceManager.callAPI(url: url, method: .put, parameters: nil, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let data = response!["data"].boolValue
                if data {
                    self.viewModel.getMyLeagues()
                }
            }else{
                //failure
            }
        }
    }
}
extension MyLeaguesViewController : UITableViewDelegate, UITableViewDataSource, OpenLeagueSettingsDelegate, openSettingsDelegate{
    func openStandings(link : String, league : String, leagueType: String) {
        let leagueStandingsViewController = LeagueStandingsViewController(nibName: "LeagueStandingsViewController", bundle: nil)
        leagueStandingsViewController.link = link
        leagueStandingsViewController.league = league
        leagueStandingsViewController.StandingsType = leagueType
        navigationController?.pushViewController(leagueStandingsViewController, animated: false)
    }
    
    func leaveLeague(link: String, leagueType : String) {
        leaveLeagueByLink (link: link, leagueType: leagueType)
    }
    
    func openSettings(link : String, leagueType : String) {
        let leaguesSettingsViewController = LeaguesSettingsViewController(nibName: "LeaguesSettingsViewController", bundle: nil)
        leaguesSettingsViewController.link = link
        leaguesSettingsViewController.leagueType = leagueType
        navigationController?.pushViewController(leaguesSettingsViewController, animated: false)
    }
    
    func openLeagueSettings(link : String, league : String, id: Int, leagueType : String) {
        let myLeaguePopUp = MyLeaguePopUp(nibName: "MyLeaguePopUp", bundle: nil)
        myLeaguePopUp.delegate = self
        myLeaguePopUp.link = link
        myLeaguePopUp.league = league
        myLeaguePopUp.id = id
        myLeaguePopUp.leagueType = leagueType
        present(myLeaguePopUp, animated: true, completion: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.numberOfClassicCells + 1
        }else {
            return viewModel.numberOfHeadCells + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 70
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "MyLeaguesHeaderCell") as! MyLeaguesHeaderCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyLeaguesCell") as! MyLeaguesCell
        if indexPath.section == 0 {
            headerCell.titleLbl.text = "Classic".localized
        }else {
            headerCell.titleLbl.text = "Head to Head".localized
        }
        if indexPath.row == 0 {
            return headerCell
        }else {
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            if indexPath.section == 0 {
                let cellViewModel = viewModel.getCellVM( index: indexPath.row )
                cell.leagueCellViewModel = cellViewModel
                cell.leagueType = "classic"
            }else {
                let cellViewModel = viewModel.getCellVM( index: indexPath.row + viewModel.numberOfClassicCells)
                cell.leagueCellViewModel = cellViewModel
                cell.leagueType = "head"
            }
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}

protocol OpenLeagueSettingsDelegate {
    func openLeagueSettings (link : String, league : String, id: Int, leagueType : String)
}

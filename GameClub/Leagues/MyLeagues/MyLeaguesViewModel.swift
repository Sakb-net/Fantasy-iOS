//
//  MyLeaguesViewModel.swift
//  GameClub
//
//  Created by Basma on 9/20/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import Foundation
class MyLeaguesViewModel {
    var classicLeagueCount = 0
    var myLeagues = [MyLeague]()
    var reloadTableView: (()->())?
    var updateState: (()->())?
    
    var cellsViewModels : [MyLeagueCellViewModel] = [MyLeagueCellViewModel](){
        didSet {
            self.reloadTableView?()
        }
    }
    
    var state : State = .empty {
        didSet {
            self.updateState?()
        }
    }
    
    var numberOfClassicCells : Int {
        return classicLeagueCount
    }
    
    var numberOfHeadCells : Int {
        return cellsViewModels.count - classicLeagueCount
    }
    
    func createCellViewModel (myLeague : MyLeague) -> MyLeagueCellViewModel {
        return MyLeagueCellViewModel(leagueName: " " + (myLeague.name ?? "League Name") , leagueRank: myLeague.current_sort ?? "??", link: myLeague.link ?? "", id: myLeague.user_id ?? 0)
    }
    
    func getCellVM(index: Int) -> MyLeagueCellViewModel {
        return cellsViewModels[index - 1]
    }

    private func createCellsVMs(myLeagues: [MyLeague]) {
        self.myLeagues = myLeagues
        var myLeagueCellsViewModels = [MyLeagueCellViewModel]()
        for league in myLeagues {
            myLeagueCellsViewModels.append(createCellViewModel(myLeague: league))
        }
        self.cellsViewModels = myLeagueCellsViewModels
    }
    
    func getMyLeagues()
    {
        state = .loading
        let url = Urls().getMyLeagues(type: "classic")
        
        ServiceManager.callAPI(url: url, method: .get, parameters: nil, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                
                if let data = response!["data"]["group_eldwry"].array {
                    
                    var myLeagues = [MyLeague]()
                    for item in data {
                        myLeagues.append(MyLeague(parametersJson: item.dictionaryValue))
                    }
                    self.classicLeagueCount = myLeagues.count
                    ServiceManager.callAPI(url: Urls().getMyLeagues(type: "head"), method: .get, parameters: nil, custumHeaders: nil) { (error, response) in
                        
                        if response != nil
                        {
                            let statusCode = response!["StatusCode"].intValue
                            
                            if let data = response!["data"]["group_eldwry"].array {
                                
                                for item in data {
                                    myLeagues.append(MyLeague(parametersJson: item.dictionaryValue))
                                }
                                let isLeagues = (myLeagues.count == 0) ? State.empty : State.loaded
                                self.state = isLeagues
                                self.createCellsVMs(myLeagues: myLeagues)

                            }else {
                                
                            }
                        }else{
                            self.state = State.error
                        }
                        
                    }

                }else {
                    
                }
            }else{
                self.state = State.error                
            }
            
        }
    }
    
    func selectLeague(index : Int) -> MyLeague{
        return myLeagues[index]
    }
    func leaveLeague (link: String, leagueType : String){
        let url = Urls().leaveLeague(link: link, type: leagueType)
        
        ServiceManager.callAPI(url: url, method: .put, parameters: nil, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let data = response!["data"].boolValue
                if data {
                    self.getMyLeagues()
                }
            }else{
                //failure
            }
        }
    }
}





import Foundation

class FavTeamPresenter {
    func getTeams(onSuccess: @escaping ([FavTeam]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getTeam()
        
        ServiceManager.callAPI(url: url, method: .get, parameters: nil, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    if let data = response!["data"].array{
                    var teams = [FavTeam]()
                    for team in data {
                        teams.append(FavTeam(parametersJson: team.dictionaryValue))
                    }
                    onSuccess(teams)
                    }
                    
                }else{
                    let message = response!["Message"].stringValue
                    onFailure(message)
                }
            }
            else
            {
                onFailure(error!.localizedDescription)
                print(error!.localizedDescription)
            }
        }
    }
}

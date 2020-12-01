



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
                onFailure("Something went wrong try again later!".localized)
            }
        }
    }
    
    func addFollowingTeam(teamsArrayString: String, onSuccess: @escaping (Bool) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let parameters = [
            "teamFollow" : teamsArrayString
        ]
        let url = Urls().addFollowingTeam()
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    let data = response!["data"].boolValue
                    onSuccess(data)
                    
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

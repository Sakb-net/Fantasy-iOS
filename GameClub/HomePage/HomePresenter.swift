




import UIKit

class HomePresenter: NSObject {
    
    func getHomeDetails(team_link: String, onSuccess: @escaping ([Fixtures]) -> Void, onFailure: @escaping (String?, Int) -> Void ) -> Void
    {
        let url = Urls().getFixtures(link: team_link)
//        let parameters = [
//            "team_link" : team_link
//        ]
        
        ServiceManager.callAPI(url: url, method: .get, parameters: nil, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    if let data = response!["data"].array {
//                        var news = [News]() 
//                        var videos = [Videos]()
                        var fixtures = [Fixtures]()
                        if data.count > 0 {
                        for fixtureItem in data[0]["match_group"].arrayValue{
                            fixtures.append(Fixtures(parametersJson: fixtureItem.dictionaryValue))
                        }
                        
//                        for newsItem in data["news"]?.arrayValue ?? [] {
//                            news.append(News(parametersJson: newsItem.dictionaryValue))
//                        }
//
//                        for video in data["videos"]?.arrayValue ?? [] {
//                            videos.append(Videos(parametersJson: video.dictionaryValue))
//                        }
                        
                        onSuccess(fixtures)
                        }else{
                            onFailure("No Matches Available", -2)
                        }
                    }else{
                        onFailure("Oops, Error occured", statusCode)
                    }
                }else{
                    let message = response!["Message"].stringValue
                    onFailure(message, 1000)
                }
            }
            else
            {
                onFailure("Something went wrong try again later!".localized, 1000)
            }
        }
    }
}

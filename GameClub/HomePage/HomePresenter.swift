




import UIKit

class HomePresenter: NSObject {
    
    func getHomeDetails(onSuccess: @escaping ([News], [Videos], [Fixtures]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getHomeURL()
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage()
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    if let data = response!["data"].dictionary {
                        var news = [News]()
                        var videos = [Videos]()
                        var fixtures = [Fixtures]()
                        
                        for fixtureItem in data["fixtures"]?.arrayValue ?? [] {
                            fixtures.append(Fixtures(parametersJson: fixtureItem.dictionaryValue))
                        }
                        
                        for newsItem in data["news"]?.arrayValue ?? [] {
                            news.append(News(parametersJson: newsItem.dictionaryValue))
                        }
                        
                        for video in data["videos"]?.arrayValue ?? [] {
                            videos.append(Videos(parametersJson: video.dictionaryValue))
                        }
                        
                        onSuccess(news, videos, fixtures)
                    }else{
                        onFailure("Oops, Error occured")
                    }
                }else{
                    let message = response!["Message"].stringValue
                    onFailure(message)
                }
            }
            else
            {
                onFailure(error?.localizedDescription)
            }
        }
    }
}

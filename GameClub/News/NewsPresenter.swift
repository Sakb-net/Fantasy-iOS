


import Foundation
class NewsPresenter: NSObject {
    
    func getNews(numPage:Int, onSuccess: @escaping ([News]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getNewsURL()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage(),
            "num_page": numPage
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    if let data = response!["data"].array {
                        var newsList = [News]()
                        for news in data {
                            newsList.append(News(parametersJson: news.dictionaryValue))
                        }
                        onSuccess(newsList)
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
                onFailure("Something went wrong try again later!".localized)
            }
        }
    }
    
    func getNewsDetails(newsLink:String, onSuccess: @escaping (News) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getNewsDetailsURL()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage(),
            "news_link": newsLink
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    let data = response!["data"].dictionaryValue
                    let news = News(parametersJson: data)
                    onSuccess(news)
                    
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

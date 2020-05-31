


import Foundation

class ProfilePresenter {
    func updateProfile(updatedParameters: [String], onSuccess: @escaping (String) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        
        let url = Urls().updateProfile()
        
        let parameters:[String:Any] = [
            "display_name": updatedParameters[0],
            "email": updatedParameters[1],
            "best_team": updatedParameters[2],
            "image": updatedParameters[3]
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    let message = response!["Message"].stringValue
                    let data = response!["data"]
                    let user = User(parametersJson: data.dictionaryValue)
                    user.saveUser()
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
    
    func uploadImage(imageBase64: String, onSuccess: @escaping (String) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        
        let url = Urls().uploadImage()
        
        let parameters:[String:Any] = [
            "image": imageBase64
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    let message = response!["Message"].stringValue
                    let data = response!["data"].stringValue
                    
                    onSuccess(data)
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
}

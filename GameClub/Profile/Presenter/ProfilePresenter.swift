


import Foundation

class ProfilePresenter {
    func updateProfile(updatedParameters: [String], onSuccess: @escaping (String) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        
        let url = Urls().updateProfile()
        
        let parameters:[String:Any] = [
            "display_name": updatedParameters[0],
            "phone": updatedParameters[1],
            "email": updatedParameters[2],
            "city": updatedParameters[3],
            "state": updatedParameters[4]
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 1 {
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
}

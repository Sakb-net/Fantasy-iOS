




import UIKit
import Alamofire
import SwiftyJSON

class ServiceManager: NSObject {
    
    typealias ApiResponse = (Error?, JSON?) -> Void
    
    class func callAPI(url: String, method: HTTPMethod, parameters: [String: Any]?, custumHeaders: [String: String]?, onCompletion: @escaping ApiResponse) -> Void
    {
        var headers: HTTPHeaders!
        headers = [:]
        
        if let head = custumHeaders
        {
            headers = head
        }
        else
        {
            print(Urls.apiAccessKeyValue)
            let langString = "lang".localized
            headers[Urls.apiAccessKey] = User.shared().access_token
            headers[Urls.apiTypeDev] = "ios"
            headers[Urls.apiValDev] = "I$&h6#565iOs5ioS#(*I$&h6#565iOs5ioS#"
            headers[Urls.apiLang] = langString
//            if let userAuthToken = User.shared().userAuthToken
//            {
//                headers["x-uqu-user-token"] = userAuthToken
//            }
        }
        
        print("===============================================")
        print("url = \(url)")
        print("headers = \(headers ?? [:])")
        print("parameters = \(parameters ?? [:])")
        print("===============================================")
        
        Alamofire.request(URL(string: url)!, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
            
            print(response)
            if let result = response.result.value
            {
                onCompletion(nil, JSON(result));
            }
            else
            {
                onCompletion(response.result.error, nil);
            }
        }
    }
    
    class func callAPIWithXMLResponse(url: String, method: HTTPMethod, parameters: [String: Any]?, custumHeaders: [String: String]?, onCompletion: @escaping (Error?, String?) -> Void) -> Void {
        
        var headers: HTTPHeaders!
        
        if let head = custumHeaders {
            headers = head
        }else {
            headers = [:]
        }
        
        headers[Urls.apiAccessKey] = Urls.apiAccessKeyValue
        
//        if let userAuthToken = User.shared().userAuthToken {
//            headers["x-uqu-user-token"] = userAuthToken
//        }
        
        print("===============================================")
        print("url = \(url)")
        print("headers = \(headers ?? [:])")
        print("parameters = \(parameters ?? [:])")
        print("===============================================")
        
        Alamofire.request(URL(string: url)!, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseString {response in
            
            print(response)
            
            if let result = response.result.value {
                
                onCompletion(nil, result);
            }else{
                onCompletion(response.result.error, nil);
            }
        }
    }
    
    class func callAPIWithImages(url: String, method: HTTPMethod, parameters: [String: Any]?, custumHeaders: [String: String]?, onCompletion: @escaping ApiResponse) -> Void {
        
        var headers: HTTPHeaders!
        
        if let head = custumHeaders {
            headers = head
        }else {
            headers = [:]
        }
        
        headers[Urls.apiAccessKey] = Urls.apiAccessKeyValue
        
//        if let userAuthToken = User.shared().userAuthToken {
//            headers["x-uqu-user-token"] = userAuthToken
//        }
        
        print("===============================================")
        print("url = \(url)")
        print("headers = \(headers ?? [:])")
        print("parameters = \(parameters ?? [:])")
        print("===============================================")
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for key in parameters!.keys {
                
                if let image = parameters![key] as? UIImage {
                    
                    if let imageData = image.jpegData(compressionQuality: 0.50) {
                        multipartFormData.append(imageData, withName: key, fileName: "image.png", mimeType: "image/png")
                    }
                    
                }else if let val = parameters![key] as? Int {
                    
                    multipartFormData.append((String(val) as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }else {
                    multipartFormData.append((parameters![key] as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }
        }, usingThreshold: 6000, to: URL(string: url)!, method: .post, headers: headers) { (result) in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    
                    if let JSon = response.result.value {
                        print(JSon)
                        onCompletion(nil, JSON(JSon));
                    }else {
                        onCompletion(response.result.error!, nil);
                    }
                }
            case .failure(let encodingError):
                onCompletion(encodingError, nil);
            }
        }
    }
    
    class func callAPIArrayOfDict(url: String, method: HTTPMethod, parameters: [[String: Any]]?, custumHeaders: [String: String]?, onCompletion: @escaping ApiResponse) -> Void {
        
        var headers: HTTPHeaders!
        headers = [:]
        
        if let head = custumHeaders {
            headers = head
        }else {
            headers[Urls.apiAccessKey] = Urls.apiAccessKeyValue
//            if let userAuthToken = User.shared().userAuthToken {
//                headers["x-uqu-user-token"] = userAuthToken
//            }
        }
        
        print("===============================================")
        print("url = \(url)")
        print("headers = \(headers ?? [:])")
        print("parameters = \(parameters ?? [[:]])")
        print("===============================================")
        
        Alamofire.request(URL(string: url)!, method: method, encoding: JSONArrayEncoding(array: parameters!), headers: headers).responseJSON {response in
            
            print(response)
            if let result = response.result.value
            {
                onCompletion(nil, JSON(result));
            }
            else
            {
                onCompletion(response.result.error, nil);
            }
        }
    }
}

struct JSONArrayEncoding: ParameterEncoding {
    private let array: [Parameters]
    
    init(array: [Parameters]) {
        self.array = array
    }

    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        let data = try JSONSerialization.data(withJSONObject: array, options: [])
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        urlRequest.httpBody = data
        
        return urlRequest
    }
}


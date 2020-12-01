//
//  VideosPresenter.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/10/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit

class VideosPresenter: NSObject {
    
    func getVideos(numPage:Int, onSuccess: @escaping ([Videos]) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getVideosURL()
        
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
                        var videos = [Videos]()
                        for video in data {
                            videos.append(Videos(parametersJson: video.dictionaryValue))
                        }
                        onSuccess(videos)
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
    
    func getVideoDetails(videosLink:String, onSuccess: @escaping (Videos) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getVedioDetailsURL()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage(),
            "videos_link": videosLink
        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    let data = response!["data"].dictionaryValue
                    let video = Videos(parametersJson: data)
                    onSuccess(video)
                    
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

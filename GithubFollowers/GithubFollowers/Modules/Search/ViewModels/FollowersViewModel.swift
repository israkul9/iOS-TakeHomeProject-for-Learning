//
//  FollowersViewModel.swift
//  GithubFollowers
//
//  Created by Tusher on 1/22/24.
//

import Foundation
import Combine
import Alamofire

class FollowersViewModel {
    
    var hasMoreFollowers = true
    var page = 1
    var subscription = Set<AnyCancellable>()
    
    var followersDataSource : [Followers] = []
    
    var followersDataSourceSubject = PassthroughSubject<[Followers] ,Never>()
    
    init(){
        
    }
    
    
    func getFollowersList(baseURL : String , endPoint : String , method : HTTPMethod , param : [String:String]){
        NetworkManager.shared.requestArray(baseUrl: baseURL,
                                           path: endPoint,
                                           method: method,
                                           parameters: param,
                                           modelType: [Followers].self)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print("Network request failed with error: \(error)")
            }
        }, receiveValue: {[weak self] models in
            
            if models.count < 100 {
                self?.hasMoreFollowers = false
            }
            
            self?.followersDataSourceSubject.send(models)
            
            // Handle the success case here with the array of decoded models
//            self.followersDataSource = models
//            for itemS in models {
//                print(itemS.login!)
//            }
        })
        .store(in: &subscription)
    }
}

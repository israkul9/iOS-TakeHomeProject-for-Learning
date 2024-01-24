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
   
    var followersCountEachTime:Int = 100
    var followersEndPoint = "/followers?per_page=100&page="
    // here per page = 100 means , we are getting 100 followers per request
    var gitHubUserName = ""
    var hasMoreFollowers : Bool = true
    var page : Int = 1
    var subscription = Set<AnyCancellable>()
    var followersDataSource = [Followers]() // data source for followers list 
    var followersDataSourceSubject = PassthroughSubject<[Followers] ,Never>()
    
    var isSearching = false
    var searchedtext = PassthroughSubject<String ,Never>()
    
    var filteredFollowersList : [Followers] = []
    
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
            guard let self = self else { return }
            if models.count < self.followersCountEachTime {
                self.hasMoreFollowers = false
            }
            self.followersDataSourceSubject.send(models)
        })
        .store(in: &subscription)
    }
}

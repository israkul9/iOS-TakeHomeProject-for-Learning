//
//  SearchViewModel.swift
//  GithubFollowers
//
//  Created by Israkul Tushaer-81 on 22/1/24.
//

import Foundation
import Combine
class SearchViewModel {
    var searchedUserName  : String = ""

    
    init(){
        
    }
    
    var isUserNameValid : Bool {
        return !searchedUserName.isEmpty
    }
}

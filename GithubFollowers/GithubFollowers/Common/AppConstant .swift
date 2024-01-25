//
//  AppConstant .swift
//  GithubFollowers
//
//  Created by Israkul Tushaer-81 on 21/1/24.
//

import Foundation

let logoImageIconName = "gh-logo"

struct ApiConstant {
    static let movieListURL = "https://api.themoviedb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803&query=marvel"
    static let posterImageBaseURL = "https://image.tmdb.org/t/p/w500"
    enum APIRequestType: String {
        case get
        case post
        case put
        case delete
        // Add more cases as needed

        var method: String {
            return self.rawValue.uppercased()
        }
    }
}



//
//extension UITextField {
//    var textPublisher: AnyPublisher<String, Never> {
//        NotificationCenter.default
//            .publisher(for: UITextField.textDidChangeNotification, object: self)
//            .map { ($0.object as? UITextField)?.text  ?? "" }
//            .eraseToAnyPublisher()
//    }
//}

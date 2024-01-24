//
//  FollowersListViewController.swift
//  GithubFollowers
//
//  Created by Israkul Tushaer-81 on 22/1/24.
//

import UIKit
import Combine
import Alamofire
import SDWebImage

class FollowersListViewController: UIViewController {
     
    // MARK: Searchbar Properties
    var searchBar: UISearchBar!
    
    
    // SAllen0400
    var url = ""
    var userName = ""
    var baseURl = "https://api.github.com/users/"
    //israkul9/followers?per_page=100&page="
  
    
    // MARK: ViewModel
    var followersListViewModel : FollowersViewModel = FollowersViewModel()
    
    // MARK: Subscription
    var subscription = Set<AnyCancellable>()
    
    // MARK: CollectionView
    private lazy var followersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 100, right: 10)
        return collectionView
    }()
    
    
    // MARK: Life Cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.searchBar = UISearchBar()
        followersListViewModel = FollowersViewModel()
        setupSearchBar()
        setupFollowesListCollectionView()
        setupNavBar()
        bindData()
        setupSearchBarBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        followersListViewModel.gitHubUserName = self.userName
        setupNavBar()
        self.url = "\(baseURl)\(followersListViewModel.gitHubUserName)\(followersListViewModel.followersEndPoint)\(followersListViewModel.page)"
        //"\(baseURl)\(followersListViewModel.page)"
        self.followersListViewModel.getFollowersList(baseURL: url, endPoint: "", method: .get, param: ["":""])
    }
    
    deinit {
        // Cancel Combine subscriptions when the view controller is deallocated
        subscription.forEach { $0.cancel() }
    }
   
    private func setupNavBar() {
        navigationItem.title = self.userName
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor.white
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesBackButton = true
    }
    
    private func setupFollowesListCollectionView(){
        followersCollectionView.frame = view.bounds
        view.addSubview(followersCollectionView)
        followersCollectionView.register(UINib(nibName: "FollowersCell", bundle: nil), forCellWithReuseIdentifier: "FollowersCell")
    }
    
    
    // MARK: Data binding
    private func bindData(){
        // Followers list data binding
        self.followersListViewModel.followersDataSourceSubject.sink {[weak self] followers in
            // append a new array after getting new 100 followers data array
            self?.followersListViewModel.followersDataSource.append(contentsOf:  followers)
            DispatchQueue.main.async {[weak self] in
                self?.followersCollectionView.reloadData()
            }
        }.store(in: &subscription)
        

        // searched data  binding
        self.followersListViewModel.searchedtext.sink { completion in
            switch completion {
            case .finished :
                print("finished \(completion)")
            case.failure(let error):
                print(error.localizedDescription)
            }
        } receiveValue: {[weak self]  searchedText in
            self?.handleSearch(text: searchedText)
        }
        .store(in: &subscription)
    }

}

extension FollowersListViewController : UISearchBarDelegate {
    func setupSearchBar(){
        // Customize the search bar if needed
        self.searchBar.placeholder = "Search followers"
        navigationItem.titleView = searchBar
    }
    
    private func setupSearchBarBinding() {
        // Set up Combine publisher to observe text changes
        NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: self.searchBar.searchTextField)
            .map { _ in self.searchBar.text ?? "" }
            .debounce(for: .seconds(0.2), scheduler: RunLoop.main) // Optional debounce for less frequent updates
            .sink { [weak self] searchText in
                self?.followersListViewModel.isSearching = true
                self?.followersListViewModel.searchedtext.send(searchText)
            }
            .store(in: &subscription)
    }
    
    private func handleSearch(text: String) {
        if text.isEmpty {
            self.followersListViewModel.filteredFollowersList =  self.followersListViewModel.followersDataSource
            self.followersListViewModel.isSearching = false
            searchBar.resignFirstResponder() // Hide the keyboard
        }
        else {
            self.followersListViewModel.isSearching = true
            var totalFollowersList : [Followers] = []
            totalFollowersList = followersListViewModel.followersDataSource
            self.followersListViewModel.filteredFollowersList = totalFollowersList.filter { (followers : Followers) -> Bool in
                let loginText = followers.login?.lowercased().contains(text.lowercased()) ?? false
                return loginText
            }
        }
        DispatchQueue.main.async {[weak self] in
            self?.followersCollectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Handle search button click if needed
        self.followersListViewModel.isSearching = true
        searchBar.resignFirstResponder()
    }
}


// MARK: UICollectionViewDelegate , UICollectionViewDataSource
extension FollowersListViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return followersListViewModel.isSearching ? followersListViewModel.filteredFollowersList.count : followersListViewModel.followersDataSource.count
        //  return self.followersListViewModel.followersDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollowersCell", for: indexPath) as? FollowersCell else { return UICollectionViewCell() }
        
        if followersListViewModel.isSearching {
            let item :  Followers = self.followersListViewModel.filteredFollowersList[indexPath.item]
            cell.configure(item: item)
            return cell
        }
        
        let item :  Followers = self.followersListViewModel.followersDataSource[indexPath.item]
        cell.configure(item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let squareGrid = (collectionView.frame.width / 3) - 15.0
        return CGSize(width: squareGrid, height: squareGrid*1.15)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let item :  Followers = self.followersListViewModel.followersDataSource[indexPath.item]
    }
}


// MARK: Pagination logics and codes

extension FollowersListViewController : UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if offsetY > contentHeight - height {
            guard followersListViewModel.hasMoreFollowers else { return }
            followersListViewModel.page += 1
            
            // new api call with new page
            self.url = "\(baseURl)\(followersListViewModel.gitHubUserName)\(followersListViewModel.followersEndPoint)\(followersListViewModel.page)"
            print("Next Page URl : ",self.url)
            self.followersListViewModel.getFollowersList(baseURL: self.url, endPoint: "", method: .get, param: ["":""])
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

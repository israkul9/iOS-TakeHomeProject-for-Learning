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
    
    // MARK: Properties
    
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
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 130, right: 10)
        return collectionView
    }()
    
    
    // MARK: Life Cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupFollowesListCollectionView()
        setupNavBar()
        followersListViewModel = FollowersViewModel()
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        followersListViewModel.gitHubUserName = self.userName
        setupNavBar()
        self.url = "\(baseURl)\(followersListViewModel.gitHubUserName)\(followersListViewModel.followersEndPoint)\(followersListViewModel.page)"
        //"\(baseURl)\(followersListViewModel.page)"
        self.followersListViewModel.getFollowersList(baseURL: url, endPoint: "", method: .get, param: ["":""])
    }
    
   
    private func setupNavBar() {
        navigationItem.title = self.userName
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor.white
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupFollowesListCollectionView(){
        followersCollectionView.frame = view.bounds
        view.addSubview(followersCollectionView)
        followersCollectionView.register(UINib(nibName: "FollowersCell", bundle: nil), forCellWithReuseIdentifier: "FollowersCell")
    }
    // MARK: Data binding
    private func bindData(){
        self.followersListViewModel.followersDataSourceSubject.sink {[weak self] followers in
            // append a new array after getting new 100 followers data array
            self?.followersListViewModel.followersDataSource.append(contentsOf:  followers)
            DispatchQueue.main.async {[weak self] in
                self?.followersCollectionView.reloadData()
            }
        }.store(in: &subscription)
    }

}


// MARK: UICollectionViewDelegate , UICollectionViewDataSource
extension FollowersListViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.followersListViewModel.followersDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollowersCell", for: indexPath) as? FollowersCell else { return UICollectionViewCell() }
      
         let item :  Followers = self.followersListViewModel.followersDataSource[indexPath.item]
            cell.configure(item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let squareGrid = (collectionView.frame.width / 3) - 15.0
        return CGSize(width: squareGrid, height: squareGrid*1.15)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item :  Followers = self.followersListViewModel.followersDataSource[indexPath.item]
        
      //  print(item.login)
      //  print(item.avatar_url)
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

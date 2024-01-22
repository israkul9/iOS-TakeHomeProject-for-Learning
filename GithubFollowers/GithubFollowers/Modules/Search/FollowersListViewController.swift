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
    var url = ""
    var baseURl = "https://api.github.com/users/SAllen0400/followers?per_page=100&page="
    var followersListViewModel : FollowersViewModel = FollowersViewModel()
    
    var subscription = Set<AnyCancellable>()
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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupFollowesListCollectionView()
        setupNavBar()
        followersListViewModel = FollowersViewModel()
        
        bindData()
      
        self.url = "\(baseURl)\(followersListViewModel.page)"
        self.followersListViewModel.getFollowersList(baseURL: url, endPoint: "", method: .get, param: ["":""])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
   
    private func setupNavBar() {
        navigationItem.title = "israkul9"
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
    
    private func bindData(){
        self.followersListViewModel.followersDataSourceSubject.sink { followers in
            
            // append a new array after getting new 100 followers data
            self.followersListViewModel.followersDataSource.append(contentsOf:  followers)
            DispatchQueue.main.async {
                self.followersCollectionView.reloadData()
            }
            
        }.store(in: &subscription)
    }

}

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
        
        print(item.login)
        print(item.avatar_url)
    }
}

extension FollowersListViewController : UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard followersListViewModel.hasMoreFollowers else { return }
            followersListViewModel.page += 1
            
            // new api call with new page
            self.url = "\(baseURl)\(followersListViewModel.page)"
            print("Next Page URl : ",self.url)
            self.followersListViewModel.getFollowersList(baseURL: self.url, endPoint: "", method: .get, param: ["":""])
        }
        
    }
}

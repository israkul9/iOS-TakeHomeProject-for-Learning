//
//  FollowersListViewController.swift
//  GithubFollowers
//
//  Created by Israkul Tushaer-81 on 22/1/24.
//

import UIKit

class FollowersListViewController: UIViewController {
    private lazy var followersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupFollowesListCollectionView()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // setupNavBar()
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
}

extension FollowersListViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollowersCell", for: indexPath) as? FollowersCell else { return UICollectionViewCell() }
      //  cell.backgroundColor = .systemPink
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let squareGrid = (collectionView.frame.width / 3) - 15.0
        return CGSize(width: squareGrid, height: squareGrid*1.15)
    }
    
}

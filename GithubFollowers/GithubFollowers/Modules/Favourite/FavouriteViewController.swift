//
//  FavouriteViewController.swift
//  GithubFollowers
//
//  Created by Israkul Tushaer-81 on 21/1/24.
//

import UIKit

class FavouriteViewController: UIViewController {
    
    let data = ["mflksnfjwejfjew", "mfoewnfljnwejfnjewnfjfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnlfnewlfnlewfnlewnfl" , "foewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewn" , "mflkewk" ,"foewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewn","foewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewn" ,"foewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnfoewnfljnwejfnjewnfjwnfjkwfjkewnjfknewjlfnljwnfjenwjfnewjfnjewnfjwenjflnewjlfnlewnflewnHELLO"]
    
    var favouriteListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.backgroundColor = .white
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
    }

    
    private func setupTableView(){
        self.favouriteListTableView = UITableView(frame: self.view.bounds, style: .grouped)
        self.favouriteListTableView.delegate = self
        self.favouriteListTableView.dataSource = self
        self.favouriteListTableView.register(UINib(nibName: "FavCell", bundle: nil), forCellReuseIdentifier: "FavCell")
       self.favouriteListTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        self.view.addSubview(self.favouriteListTableView)
        self.favouriteListTableView.backgroundColor = .clear
    }

}

extension FavouriteViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favCell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath) as? FavCell
        else {
            return UITableViewCell()
        }
        favCell.descriptionLabel.text = self.data[indexPath.row]
        return favCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

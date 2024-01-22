//
//  ViewController.swift
//  GithubFollowers
//
//  Created by Israkul Tushaer-81 on 18/1/24.
//

import UIKit
import Combine
class SearchViewController: UIViewController {
    
    
    // MARK: ViewModel
    
    var searchViewModel : SearchViewModel = SearchViewModel()
    
    
    // MARK: - UI Components
    
    let logoImageView = UIImageView()
    let userNameTextField = GFTextField()
    let getFollowersButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    
    // MARK: - Subscription in combine
    
    var subscription = Set<AnyCancellable>()
    
    
    // MARK: - Life cycle method
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchViewModel = SearchViewModel()
        self.setupUI()
        self.bindText()
        self.createDismissKeyboardOnTabGesture()
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationItem.title = ""
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - UI setup
    
    private func setupUI(){
        self.view.backgroundColor = .white
        
        // logo imageView
        
        self.logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.logoImageView.image = UIImage(named: logoImageIconName)
        self.view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor) ,
            logoImageView.heightAnchor.constraint(equalToConstant: 200.0),
            logoImageView.widthAnchor.constraint(equalToConstant: 200.0)
        ])
        
        
        // userNameTextField
        
        self.view.addSubview(self.userNameTextField)
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor , constant: 20),
            userNameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50.0),
            userNameTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 50)
        ])
        
        
        // getFollowers button
        
        self.view.addSubview(getFollowersButton)
        
        NSLayoutConstraint.activate([
            getFollowersButton.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor , constant: 25) ,
            getFollowersButton.leadingAnchor.constraint(equalTo: userNameTextField.leadingAnchor, constant: 50) ,
            getFollowersButton.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor, constant: -50),
            getFollowersButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        self.getFollowersButton.addTarget(self, action: #selector(didTappedOnGetFollowers), for: .touchUpInside)
        
    }
    
    
    // MARK: Binding on username text field
    
    func bindText(){
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self.userNameTextField)
            .compactMap({ ($0.object as? UITextField)?.text  })
            .sink(receiveValue: {[weak self] text in
                guard let self = self else { return }
                self.searchViewModel.searchedUserName = text
                print(self.searchViewModel.searchedUserName)
            })
            .store(in: &subscription)
    }
    
    // MARK: Keyboard Dismiss
    
    func createDismissKeyboardOnTabGesture(){
        // Set up a tap gesture recognizer to dismiss the keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        // Resign the first responder status of the text field
        self.userNameTextField.resignFirstResponder()
    }
    
    @objc func didTappedOnGetFollowers() {
        let vc = FollowersListViewController()
        guard  searchViewModel.isUserNameValid else {
            showAlertVC()
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    func showAlertVC(){
        DispatchQueue.main.async {[self] in
            let customAlert = CustomAlertViewController(message: "Please enter a valid username which is not empty.")
            customAlert.modalPresentationStyle = .overFullScreen
            customAlert.modalTransitionStyle = .crossDissolve
            present(customAlert, animated: true, completion: nil)
        }
    }
}


//
//  CustomAlertVC.swift
//  GithubFollowers
//
//  Created by Israkul Tushaer-81 on 22/1/24.
//

import UIKit

import UIKit

class CustomAlertViewController: UIViewController {

    // MARK: - Properties

    private let message: String

    // MARK: - UI Components

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    private let okButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("OK", for: .normal)
      
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.tintColor = .white
        return button
    }()

    // MARK: - Initialization

    init(message: String) {
        self.message = message
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }

    // MARK: - UI Configuration

    private func configureUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
  
        view.addSubview(containerView)
       // containerView.layer.borderColor = UIColor.red.cgColor
       // containerView.layer.borderWidth = 2.5
        containerView.addSubview(messageLabel)
        containerView.addSubview(okButton)
       // okButton.layer.borderWidth = 2.5
      //  okButton.layer.borderColor = UIColor.systemGreen.cgColor
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            
            messageLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            okButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            okButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            okButton.widthAnchor.constraint(equalToConstant: 200),
            okButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
            
        ])

        messageLabel.text = message
    }

    // MARK: - Actions

    @objc private func okButtonTapped() {
        self.dismiss(animated: true)
    }
}


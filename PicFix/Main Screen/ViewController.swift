//
//  ViewController.swift
//  PicFix
//
//  Created by Joe Cirillo on 11/16/23.
//

import UIKit

class ViewController: UIViewController {
    let mainScreenView = MainScreenView()
    let childProgressView = ProgressSpinnerViewController()

    override func loadView(){
        view = mainScreenView
        
        mainScreenView.logInButton.addTarget(self, action: #selector(onLogInButtonTapped), for: .touchUpInside)
        mainScreenView.signUpButton.addTarget(self, action: #selector(onSignUpButtonTapped), for: .touchUpInside)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "PicFix"
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait // You can choose the orientation(s) you want to support
    }
}


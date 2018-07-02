//
//  LoginViewController.swift
//  Movies
//
//  Created by Duje Medak on 13/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // constraints for horizontal movement animations
    @IBOutlet weak var usernameTextFieldConstraintX: NSLayoutConstraint!
    @IBOutlet weak var passwordTextFieldConstraintX: NSLayoutConstraint!
    @IBOutlet weak var loginButtonConstraintX: NSLayoutConstraint!
    
    // constraints for vertical movement animations
    var usernameTextFieldVerticalSpacing2, passwordTextFieldVerticalSpacing2, loginButtonVerticalSpacing2: NSLayoutConstraint?
    
    @IBOutlet weak var appTitleLabel: UILabel!
    @IBOutlet weak var appTitleVerticalSpacing: NSLayoutConstraint!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameTextFieldVerticalSpacing: NSLayoutConstraint!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordTextFieldVerticalSpacing: NSLayoutConstraint!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginButtonVerticalSpacing: NSLayoutConstraint!
    
    var offsetX = CGFloat(200)
    var offsetY = CGFloat(200)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        offsetX = view.bounds.width
        setInitialStatesOfViews()
    }
    
    func setInitialStatesOfViews(){
        // remove views from screen (for entry animation)
        usernameTextFieldConstraintX.constant -= offsetX
        passwordTextFieldConstraintX.constant -= offsetX
        loginButtonConstraintX.constant -= offsetX
        usernameTextField.alpha = 0
        usernameTextField.layer.borderColor = UIColor.black.withAlphaComponent(0).cgColor
        passwordTextField.alpha = 0
        passwordTextField.layer.borderColor = UIColor.black.withAlphaComponent(0).cgColor
        loginButton.alpha = 0
        loginButton.layer.borderColor = UIColor.black.withAlphaComponent(0).cgColor
        self.appTitleLabel.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateEntry()
    }
    
    func animateEntry(){
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveEaseOut, animations: {
            self.appTitleLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: CGFloat(0.6),
                       initialSpringVelocity: CGFloat(0.15), options: .curveEaseOut, animations: {
            self.usernameTextFieldConstraintX.constant += self.offsetX
            self.usernameTextField.alpha = 1
            self.usernameTextField.layer.borderColor = UIColor.black.withAlphaComponent(1).cgColor
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.75, delay: 0.15, usingSpringWithDamping: CGFloat(0.6),
                       initialSpringVelocity: CGFloat(0.15), options: .curveEaseOut, animations: {
            self.passwordTextFieldConstraintX.constant += self.offsetX
            self.passwordTextField.alpha = 1
            self.passwordTextField.layer.borderColor = UIColor.black.withAlphaComponent(1).cgColor
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.75, delay: 0.3, usingSpringWithDamping: CGFloat(0.6),
                       initialSpringVelocity: CGFloat(0.15), options: .curveEaseOut, animations: {
            self.loginButtonConstraintX.constant += self.offsetX
            self.loginButton.alpha = 1
            self.loginButton.layer.borderColor = UIColor.black.withAlphaComponent(1).cgColor
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    func animateExit(){
        usernameTextFieldVerticalSpacing2 = usernameTextField.topAnchor.constraint(equalTo: self.view.topAnchor)
        usernameTextFieldVerticalSpacing2?.constant = usernameTextField.frame.minY - view.safeAreaInsets.top
        
        passwordTextFieldVerticalSpacing2 = passwordTextField.topAnchor.constraint(equalTo: self.view.topAnchor)
        passwordTextFieldVerticalSpacing2?.constant = passwordTextField.frame.minY - view.safeAreaInsets.top
        
        loginButtonVerticalSpacing2 = loginButton.topAnchor.constraint(equalTo: self.view.topAnchor)
        loginButtonVerticalSpacing2?.constant = loginButton.frame.minY - view.safeAreaInsets.top
        
        self.usernameTextFieldVerticalSpacing.isActive = false
        self.usernameTextFieldVerticalSpacing2?.isActive = true
        self.passwordTextFieldVerticalSpacing.isActive = false
        self.passwordTextFieldVerticalSpacing2?.isActive = true
        self.loginButtonVerticalSpacing.isActive = false
        self.loginButtonVerticalSpacing2?.isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.appTitleVerticalSpacing.constant -= self.view.bounds.height
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        
        UIView.animate(withDuration: 0.5, delay: 0.05, options: .curveEaseOut, animations: {
            self.usernameTextFieldVerticalSpacing2?.constant -= self.view.bounds.height
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
            self.passwordTextFieldVerticalSpacing2?.constant -= self.view.bounds.height
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.15, options: .curveEaseOut, animations: {
            self.loginButtonVerticalSpacing2?.constant -= self.view.bounds.height
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            let vc = TabBarViewController()
            self.present(vc, animated: true, completion: nil)
        })
    }
    
    @IBAction func onLoginButtonTap(_ sender: Any) {
        animateExit()
    }
}

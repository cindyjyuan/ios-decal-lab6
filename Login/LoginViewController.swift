//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
    }

    // TODO: instantiate the views needed for your project
    
    var titleUI: UILabel!
    var usernameText: UITextField!
    var passwordText: UITextField!
    var loginButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        titleUI = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width * 0.75, height: 100))
        titleUI.text = "Login View Controller"
        titleUI.font = UIFont(name: "HelveticaNeue-Light", size: 36.0)
        titleUI.textColor = UIColor.white
        
        let view1 = UIView()
        view1.backgroundColor = UIColor.white
        view1.layer.cornerRadius = 8;
        
        usernameText = UITextField()
        usernameText.placeholder = "youremail@berkeley.edu"
        passwordText = UITextField()
        passwordText.placeholder = "password"
        
        loginButton = UIButton()
        loginButton.backgroundColor = UIColor(red: 40/255, green: 175/255, blue: 240/255, alpha: 1)
        loginButton.tintColor = UIColor.white
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        loginButton.contentEdgeInsets = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        loginButton.layer.cornerRadius = 5
        
        view1.addSubview(usernameText)
        view1.addSubview(passwordText)
        view1.addSubview(loginButton)
        view.addSubview(titleUI)
        view.addSubview(view1)
        
        // TODO: layout your views using frames or AutoLayout
        
        view1.translatesAutoresizingMaskIntoConstraints = false
        titleUI.translatesAutoresizingMaskIntoConstraints = false
        usernameText.translatesAutoresizingMaskIntoConstraints = false
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        let titleUIConstraints = [
            titleUI.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleUI.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ]
        
        NSLayoutConstraint.activate(titleUIConstraints)
        
        let viewConstraints = [
            view1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view1.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            view1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            view1.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)
        ]
        
        NSLayoutConstraint.activate(viewConstraints)
        
        let usernameTextConstraints = [
            usernameText.topAnchor.constraint(equalTo: view1.topAnchor, constant: 6),
            usernameText.leftAnchor.constraint(equalTo: view1.leftAnchor, constant: 6),
            usernameText.rightAnchor.constraint(equalTo: view1.rightAnchor, constant: -6),
            usernameText.centerXAnchor.constraint(equalTo: view1.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(usernameTextConstraints)
        
        let passwordTextConstraints = [
            passwordText.heightAnchor.constraint(equalTo: usernameText.heightAnchor),
            passwordText.leftAnchor.constraint(equalTo: view1.leftAnchor, constant: 6),
            passwordText.rightAnchor.constraint(equalTo: view1.rightAnchor, constant: -6),
            passwordText.centerXAnchor.constraint(equalTo: view1.centerXAnchor),
            passwordText.centerYAnchor.constraint(equalTo: view1.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(passwordTextConstraints)
        
        let loginButtonConstraints = [
            loginButton.bottomAnchor.constraint(equalTo: view1.bottomAnchor, constant: -10),
            loginButton.heightAnchor.constraint(equalTo: usernameText.heightAnchor),
            loginButton.leftAnchor.constraint(equalTo: view1.leftAnchor, constant: 60),
            loginButton.rightAnchor.constraint(equalTo: view1.rightAnchor, constant: -60),
            loginButton.centerXAnchor.constraint(equalTo: view1.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(loginButtonConstraints)
        
        
    }
    
    // TODO: create an IBAction for your login button
    func login(sender: UIButton) {
        let username = usernameText.text
        let password = passwordText.text
        authenticateUser(username: username, password: password)
    }
    
    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}

//
//  ViewController.swift
//  EVIOS1
//
//  Created by Student04 on 30/06/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var appBackground: UIImageView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var newsletterSwitch: UISwitch!
    @IBOutlet weak var visibilityButton: UIImageView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        appBackground.image = UIImage(named: "background")
        appBackground.contentMode = .scaleToFill
        
        profilePic.layer.borderWidth = 2
        profilePic.layer.borderColor = UIColor.black.cgColor
        profilePic.clipsToBounds = true
        profilePic.layer.cornerRadius = profilePic.bounds.width/2
        profilePic.image = UIImage(named: "profilepic")
        profilePic.contentMode = .scaleAspectFit
        
        visibilityButton.image = UIImage(named: "visibilityon")
        let visiTap = UITapGestureRecognizer(target: self, action: #selector(onImageTap))
        visibilityButton.isUserInteractionEnabled = true
        visibilityButton.addGestureRecognizer(visiTap)
        
        newsletterSwitch.isOn = true
        
        login.keyboardType = .default
        login.textContentType = .username
        
        password.keyboardType = .default
        password.isSecureTextEntry = true
        password.textContentType = .password
        
        let keyboardOut = UITapGestureRecognizer(target: view, action:
        #selector(UIView.endEditing))
        view.addGestureRecognizer(keyboardOut)
        
    }
    
    @objc func onImageTap() {
        if(password.isSecureTextEntry){
            password.isSecureTextEntry = false
            visibilityButton.image = UIImage(named: "visibilityoff")
        }else{
            password.isSecureTextEntry = true
            visibilityButton.image = UIImage(named: "visibilityon")
        }
            
    }
}


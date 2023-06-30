//
//  ViewController.swift
//  EVIOS1
//
//  Created by Student04 on 30/06/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var appView: UIView!
    @IBOutlet weak var appBackground: UIImageView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var newsletterSwitch: UISwitch!
    @IBOutlet weak var visibilityButton: UIImageView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loader: UIView!
    @IBOutlet weak var animateLoader: UIActivityIndicatorView!
    
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
        
        login.keyboardType = .emailAddress
        login.textContentType = .emailAddress
        
        password.keyboardType = .default
        password.isSecureTextEntry = true
        password.textContentType = .password
        
        let keyboardOut = UITapGestureRecognizer(target: view, action:
        #selector(UIView.endEditing))
        view.addGestureRecognizer(keyboardOut)
        
        loader.isHidden = true
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
    
    @IBAction func loginTapped(_ sender: Any) {
        
        if let log = login.text{
            if(log == ""){
                alertGenerator("ERROR", "Login vide", "OK")
            }else{
                if let pass = password.text{
                    if(pass == ""){
                        alertGenerator("ERROR", "password vide", "OK")
                    }else{
                        if (log.contains("@")){
                            if(pass.count >= 4){
                                loader.isHidden = false
                                appView.bringSubviewToFront(loader)
                                
                                animateLoader.startAnimating()
                                
                                LoginService.logingIn {
                                    DispatchQueue.main.async {
                                        self.animateLoader.stopAnimating()
                                        self.loader.isHidden = true
                                        
                                        if(self.newsletterSwitch.isOn){
                                            self.alertGenerator("Bienvenue \(log) !", "vous vous êtes inscrit à la newsletter", "Merci!")
                                        }else{
                                            self.alertGenerator("Bienvenue \(log) !", "vous ne vous êtes pas inscrit à la newsletter", "Merci!")
                                        }
                                    }
                                }
                            }else{
                                alertGenerator("ERROR", "Mot de passe trop court! (4 caractères)", "OK")
                            }
                        }else {
                            alertGenerator("ERROR", "Login invalide (pas d'@)", "OK")
                        }
                    }
                }
            }
        }
    }
    
    func alertGenerator(_ titleA :String, _ mess :String, _ button :String){
        let alert = UIAlertController(title: titleA, message: mess, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: button, style: .cancel))
        present(alert, animated: true, completion: nil)
    }
    
    class LoginService {
        static func logingIn(completion: @escaping() -> Void) {
            DispatchQueue.global(qos: .background).async {
                sleep(3)
                completion()
            }
        }
    }
}


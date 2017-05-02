//
//  ViewController.swift
//  login
//
//  Created by mac on 30/03/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class ViewController: connection {
    
    var activityIndicator01: UIActivityIndicatorView = UIActivityIndicatorView()
    var createLogin :VerifyData = VerifyData()
    // On va créer un observer sur un activity indicator
    // Quand l'activity indicator aura fini de tourner
    // Alors on rappel la méthode de verification et on récupère la sortie
    
    
    @IBAction func ActionInStartView(_ sender: UIButton) {
        var login : String = ""
        var Password : String = ""
        if Reachability.isConnectedToNetwork() == true
        {
            //On a la connexion internet
            //On vérifie si l'utilisateur s'est déjà connecte
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            if   (appDelegate.connected == nil || !appDelegate.connected! ) {
                // On vérifie si on a les identifiants de l'utilisateur dans le Keychain
                //Si on n'a pas d'identifiant dans le Keychain  on redirige vers la page de connexion
                if (KeychainService.loadLogin() == nil || KeychainService.loadPassword() == nil)
                {
                    self.performSegue(withIdentifier: "GoToConnect", sender: self)
                }
                else {
                    activityIndicator01.center=self.view.center
                    activityIndicator01.hidesWhenStopped=true
                    activityIndicator01.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
                    view.addSubview(activityIndicator01)
                    activityIndicator01.startAnimating()
                    UIApplication.shared.beginIgnoringInteractionEvents()
                    
                    if (KeychainService.loadLogin() != nil)
                    {
                        login = KeychainService.loadLogin()! as String
                        
                    }
                    if (KeychainService.loadPassword() != nil)
                    {
                        
                        Password = KeychainService.loadPassword()! as String
                    }
                    //Vérifier que la connection marche avec les données du Keychain
                    
                    createLogin = VerifyData()
                    let  user : UserModel = UserModel(login: login, password: Password, nom: "", prenom: "", dateNaissance: Date(), codePostal: "")
                    
                    createLogin.VerifyDBCount(controller:self,User: user)
                }
            }
        }
        else
        {
            let controller = UIAlertController(title: "Aucune connection internet détectez", message: "Cette application a besoin de connection", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            controller.addAction(ok)
            controller.addAction(cancel)
            present(controller, animated: true, completion: nil)
        }
        
        
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //activityIndicator01.observeValue(forKeyPath: "isAnimating", of: <#T##Any?#>, change: <#T##[NSKeyValueChangeKey : Any]?#>, context: <#T##UnsafeMutableRawPointer?#>)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    override func stopActivityIndicator(){
        activityIndicator01.stopAnimating()
        activityIndicator01.hidesWhenStopped = true;
        UIApplication.shared.endIgnoringInteractionEvents()
        getResultDBCheck()
        
    }
    override func getResultDBCheck(){
        //let result =  createLogin.VerifyDBCount(controller:self)
        if connection.information == "" {
            self.performSegue(withIdentifier: "GoToConnect", sender: self)
        }
        else {
            if (connection.information.range(of: "OK") != nil || connection.information.range(of: "Bienvenue") != nil)
            {
                print("bienvenue vous vous êtes connecté")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.connected = true
                
            }
            else
            {
                print("compte introuvable")
                //Supprimer les données du keychain et envoyé l'utilisateur vers la page de connection
                KeychainService.deleteLogin(token: "")
                KeychainService.deletePasswod(token: "")
                self.performSegue(withIdentifier: "GoToConnect", sender: self)
                
            }
        }
    }
    
    
    
    
}



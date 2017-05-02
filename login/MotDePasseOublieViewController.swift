//
//  MotDePasseOublieViewController.swift
//  login
//
//  Created by mac on 25/04/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class MotDePasseOublieViewController: connection {

    @IBOutlet weak var Email: UITextField!
    var activityIndicator03: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBAction func ValidateChangePWD(_ sender: UIButton) {
 
        //Verifier que l'adresse email est valide
        let createLogin :VerifyData = VerifyData()
        let valide = createLogin.isValidEmail(testStr: Email.text!)
        if valide {
            // Lancer le activity indicator
            activityIndicator03.center=self.view.center
            activityIndicator03.hidesWhenStopped=true
            activityIndicator03.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(activityIndicator03)
            activityIndicator03.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            // verifier que l'adresse email fournit existe dans la BDD
            createLogin.VerifyEmailDBB(controller: self, email: Email.text!)
        
        }else {
            let alert = UIAlertController(title: "Attention", message: "Adresse mail non valide", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }
    
    override func stopActivityIndicator(){
        activityIndicator03.stopAnimating()
        activityIndicator03.hidesWhenStopped = true
        UIApplication.shared.endIgnoringInteractionEvents()
        getResultDBCheck()
        
    }
    
    override func getResultDBCheck(){
        //print (connection.information)
        
        if connection.information.range(of: "existe") != nil
        {
            //Renvoie vers lapage pour créer un nouveau mot de passe
            let alert = UIAlertController(title: "Information", message: "Un email vous ai envoyé Veuillez le vérifier!", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
                self.performSegue(withIdentifier: "ReturnConnection", sender: self)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            // Mettre cette action après avoir cliquer sur le OK de l'Alert View
        }
        else {
            let alert = UIAlertController(title: "Information", message: "Aucun compte ne correspond à cet email!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}

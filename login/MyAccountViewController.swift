//
//  MyAccountViewController.swift
//  login
//
//  Created by mac on 27/04/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit


class MyAccountViewController: connection {

    @IBOutlet weak var Nom: UITextField!
    @IBOutlet weak var Prenom: UITextField!
    @IBOutlet weak var DateNaissance: UITextField!
    @IBOutlet weak var CodePostal: UITextField!
    @IBOutlet weak var Email: UITextField!
    
    @IBOutlet weak var Validate: UIButton!
    @IBAction func ChangeValue(_ sender: UITextField) {
        Validate.isEnabled = true
        
    }
    var activityIndicator04: UIActivityIndicatorView = UIActivityIndicatorView()
    var user : UserModel = UserModel()
   
    
    @IBAction func ValidateModification(_ sender: UIButton) {
        
        //Verifier si on a des modifications 
        //Comparaison des champs et véifier si on a varaiment des modifications
        //Construction de l'objet modifié 
        //Convertir l'entréer date de naissance vers type Date
        let inputFormatter01 = DateFormatter()
        inputFormatter01.dateFormat = "dd-MM-yyyy"
        let myDate = inputFormatter01.date(from: String(DateNaissance.text!))
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let dateNaissanceString  = inputFormatter.string(from: myDate!)
        let BearthDate: Date = inputFormatter.date(from: dateNaissanceString)!
        //Lancement du activity indicator 
        activityIndicator04.center=self.view.center
        activityIndicator04.hidesWhenStopped=true
        activityIndicator04.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator04)
        activityIndicator04.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        let user01: UserModel = UserModel(login: Email.text!, password: "", nom: Nom.text!, prenom: Prenom.text!, dateNaissance: BearthDate as Date, codePostal: CodePostal.text!)
        //if (user.getcodePostal() != CodePostal.text! || user.getPrenom() != Prenom.text! || user.getNom() != Nom.text! || user.getdateNaissance().description != DateNaissance.text! ){
        if (user01 == user){
            let alert = UIAlertController(title: "Information", message: "Aucune modification n'a été détécté", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        }
        else {
            CreateLogin.updateuser(User:user01)
        }
    }

    override func viewDidLoad() {
        //Verifier si l'utilisateur est connecter sinon on le renvoie vers la page de connexion 
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        activityIndicator04.center=self.view.center
        activityIndicator04.hidesWhenStopped=true
        activityIndicator04.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator04)
        activityIndicator04.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        Email.isUserInteractionEnabled = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // Si l'utilisateur n'est pas connecté on le renvoie par la page de connection
        if   (appDelegate.connected == nil || !appDelegate.connected! ) {
         self.performSegue(withIdentifier: "GoToConnectProfil", sender: self)
        }
        else {
        ///Charger les données de l'utilisateur dans le cas ou il est connecte
            
            let getUser: UserModel = UserModel(login: KeychainService.loadLogin() as! String , password: KeychainService.loadPassword() as! String , nom: "", prenom: "", dateNaissance: Date(), codePostal: "")
            let createLogin: VerifyData = VerifyData()
            createLogin.getUser(controller: self, User: getUser)
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func stopActivityIndicator(){
        activityIndicator04.stopAnimating()
        activityIndicator04.hidesWhenStopped = true
        UIApplication.shared.endIgnoringInteractionEvents()
        //remplir les champs de l'utilisateur
        feelInformation( user : self.user)
    }
    
    func feelInformation( user : UserModel){
        Nom.text = user.getNom()
        Prenom.text = user.getPrenom()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        //print("Dateobj: \(dateFormatter.stringFromDate(dateObj!))")
        DateNaissance.text = dateFormatter.string(from: user.getdateNaissance())
        CodePostal.text = user.getcodePostal()
        Email.text = user.getlogin()
    
    }
    //Get users data
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}

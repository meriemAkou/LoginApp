//
//  RenetialisePWDViewController.swift
//  login
//
//  Created by AKOU Meriem on 01/05/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class RenetialisePWDViewController: UIViewController {

    @IBOutlet weak var LastPWD: UITextField!
    @IBOutlet weak var NewPWD: UITextField!
    @IBOutlet weak var ConfirmNewPWD: UITextField!
    var user : UserModel = UserModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ValidatePWDChange(_ sender: UIButton) {
        // Varifer que le mot de passe est bon 
        if(LastPWD != user.getPWD() ){
            print ( "le mot de passe est différebt Veuillez entrer votre mot de passe ")
        }else {
        
            if  (NewPWD.text != ConfirmNewPWD.text ){
                print ( "les mots de passe sont différents ")
            }else {
                    if ( NewPWD == user.getPWD()){
                        print( "Veuillez choisir un mot de passe différent ")
                    }else {
                        print ( " votre demande a été prise en compte ")
                    }
                }
            }
        //Verifier que le confirm PWD est équal à  PWD
        //Si tout OK on envoie la demande au Model
        
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

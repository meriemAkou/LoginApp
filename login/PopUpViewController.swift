//
//  PopUpViewController.swift
//  login
//
//  Created by mac on 06/04/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var labelText: UILabel!
    var label: String=""
    
    @IBAction func OKButton(_ sender: UIButton) {
        if ((labelText.text?.range(of: "Bienvenue")) != nil){
                self.performSegue(withIdentifier: "showSondage", sender: self)
        } 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.layer.cornerRadius=10
        popUpView.layer.masksToBounds=true
        labelText.text=label
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showSondage"){
            print("c'est moi")
        }
    }
    


}

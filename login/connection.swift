

import UIKit
import FBSDKLoginKit
import TwitterKit

class connection: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var login: UITextField!
    static var information: String = ""
    @IBOutlet weak var scrollView: UIScrollView!
    
   // @IBOutlet weak var FBConnection: FBSDKLoginButton!
    //Variable globale
    var message: String=""
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBAction func TWConnection(_ sender: UIButton) {
        Twitter.sharedInstance().logIn {
            (session, error) -> Void in
            if (error != nil) {
                print("Une erreur s'est produite lors de la connection",error ?? "");
            } else {
                print("Une connection qui a réussi");
            }
        }
    }
    
    @IBAction func FBConnection(_ sender: UIButton) {
        FBSDKLoginManager().logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, error) in
            if ( error != nil ){
                print("PB with connexion with custom button")
                return
            }
            //récupérer les données envoyé par FB
            if ((FBSDKAccessToken.current()) != nil)
            {
                let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email, first_name, last_name"])
                graphRequest.start(completionHandler: { (connection, result, error) -> Void in
                    /*FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"]).start {
                     (connection,result, err) in*/
                    if error != nil {
                        print ("on a eu une erreur", error!)
                        return
                    }
                    print("le resultat:", result!)
                    //print ( result.valueForKey("email") as String)
                    //Il faut enregistré le email de l'utilisateur dans la BDD // avec les informations qu'on a pu récupérer 
                    let dic = result as! [String: Any]
                    var createLogin :VerifyData = VerifyData()
                    createLogin = VerifyData(mail: String(describing: dic["email"]!), password: "FB", confirmPassword: "", nom: String(describing: dic["first_name"]!), prenom: String(describing: dic["last_name"]!), dateNaissance: "", codePostal: "0")
                    createLogin.insertinDB()
                    
                    //let userEmail : NSString = result. valueForKey("email") as! NSString
                    //print("User Email is: \(userEmail)")
                })
            }
        }
    }
    
    public func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!){
        print( "L'utilisateur s'est déconnecté!!!")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        
//        if keyPath == "text" {
//            let newValue=(change?[.newKey] as AnyObject).debugDescription
//            message = newValue!
//            DispatchQueue.main.async {
//                self.performSegue(withIdentifier: "Label", sender: nil)
//            }
//            if newValue?.range(of: "ok") != nil{
//                KeychainService.saveLogin(token: login.text! as NSString)
//                KeychainService.savePassword(token: Password.text! as NSString)
//                
//            }
//        }
//    }
//    
    
    @IBAction func sendConnection(_ sender: UIButton) {
        
        //il faut verifier la bonne syntaxe de l'email sinon on affiche un message d'erreur
        var createLogin :VerifyData = VerifyData()
        let valide = createLogin.isValidEmail(testStr: login.text!)
        activityIndicator.center=self.view.center
        activityIndicator.hidesWhenStopped=true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        if (valide && Password.text != "")
        {
            createLogin = VerifyData(mail: login.text!, password: Password.text!, confirmPassword:"" , nom: "", prenom: "", dateNaissance: "", codePostal: "")
            createLogin.VerifyDBCount(controller: self)
            
        }else {
            message = "Email ou mot de passe invalide"
            if ( self.message != "" ){
                OperationQueue.main.addOperation {
                    self.performSegue(withIdentifier: "Label", sender: self)
                    self.stopActivityIndicator()
                }
                
            }
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let point01 = CGPoint(x: 0,y :0)
        scrollView.setContentOffset(point01, animated: true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let point = CGPoint(x: 0,y :200)
        switch textField.tag {
        case 0:
            print ("Je ne fais rien")
        default:
            scrollView.setContentOffset(point, animated: true)
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            Password.becomeFirstResponder()
        default:
            break
        }
        return true
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // Envoie du message a afficher le pop up personnalisé
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "Label" && self.message != "") {
            let nextScene = segue.destination as? PopUpViewController
            nextScene!.label = self.message
        }
        
    }
    
    func stopActivityIndicator(){
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
        UIApplication.shared.endIgnoringInteractionEvents()
        getResultDBCheck()
        
    }
    func getResultDBCheck(){
        print (connection.information)

            if connection.information.range(of: "Bienvenue") != nil 
            {
                //Sauvegarder les éléments de connexion dans le Keychain
                KeychainService.saveLogin(token: login.text! as NSString)
                KeychainService.savePassword(token: Password.text! as NSString)
                print("bienvenue vous vous êtes connecté")
                
            }
            else
            {
                print("compte introuvable")
                
            }
        }

    
}

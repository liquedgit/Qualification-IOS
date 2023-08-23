//
//  LoginViewController.swift
//  QualificationML
//
//  Created by prk on 23/08/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    var context : NSManagedObjectContext!
    
    @IBAction func SigninOnClick(_ sender: Any) {
        let username = UsernameTxt.text!
        let password = PasswordTxt.text!
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.predicate = NSPredicate(format: "username == %@ AND password = %@", username, password)
        
        do{
            let result = try context.fetch(request) as! [NSManagedObject]
            
            if(result.count == 0){
                let alert = UIAlertController(title: "Error", message: "Invalid Credentials", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                present(alert,animated: true, completion: nil)
                return
            }
            
            let nextView = storyboard?.instantiateViewController(withIdentifier: "HomeViewControllers") as? HomeViewController
            var name : String = ""
            
            for data in result{
                let firstname = data.value(forKey: "firstname") as! String
                let lastname = data.value(forKey: "lastname") as! String
                
                name.append(firstname)
                name.append(" ")
                name.append(lastname)
            }
            
            if nextView != nil{
                nextView?.modalTransitionStyle = .flipHorizontal
                nextView?.name = name
                navigationController?.setViewControllers([nextView!], animated: true)
            }
        }catch{
            let alert = UIAlertController(title: "Error", message: "Invalid Credentials", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert,animated: true, completion: nil)
        }
        
        
    }
    
    @IBOutlet weak var PasswordTxt: UITextField!
    
    @IBOutlet weak var UsernameTxt: UITextField!
    
    
    
    
    @IBAction func SignUpRedirectButtonOnClick(_ sender: Any) {
        
        
        if let nextView = storyboard?.instantiateViewController(withIdentifier: "registerBoard"){
            navigationController?.pushViewController(nextView, animated: true)
        }
            
        
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

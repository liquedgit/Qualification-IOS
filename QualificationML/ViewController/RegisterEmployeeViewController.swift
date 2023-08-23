//
//  RegisterEmployeeViewController.swift
//  QualificationML
//
//  Created by prk on 23/08/23.
//

import UIKit
import CoreData

extension String {
    var isNumber: Bool {
        return self.range(
            of: "^[0-9]*$", // 1
            options: .regularExpression) != nil
    }
}


class RegisterEmployeeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
        
    }
    var context : NSManagedObjectContext!
    
    var name : String?
    @IBOutlet weak var NameTxt: UITextField!
    

    @IBOutlet weak var WageTxt: UITextField!
    @IBOutlet weak var DivisionTxt: UITextField!
    
    @IBAction func RegisterEmployeeOnClick(_ sender: Any) {
            let newName = NameTxt.text
            let newWage = WageTxt.text
            let newDivision = DivisionTxt.text
            
            if(newName == "" || newWage == "" || newDivision == ""){
                let alert = UIAlertController(title: "Error", message: "All fields must be fields", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                present(alert,animated: true, completion: nil)
                return
            }
            
            if(newWage?.isNumber == false){
                let alert = UIAlertController(title: "Error", message: "Wage must be numeric", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                present(alert,animated: true, completion: nil)
                return
            }
            
            let entity = NSEntityDescription.entity(forEntityName: "Employee", in: context)
            
            let newEmployee = NSManagedObject(entity: entity!, insertInto: context)
            
            newEmployee.setValue(newName, forKey: "name")
            newEmployee.setValue(newDivision, forKey: "division")
            newEmployee.setValue((newWage! as NSString).intValue, forKey: "wage")
            
            do{
                try context.save()
                let nextView = storyboard?.instantiateViewController(withIdentifier: "HomeViewControllers") as! HomeViewController
                
                nextView.name = name!
                    UIView.transition(with: view.window!, duration: 1, options: .curveLinear, animations: {self.navigationController?.setViewControllers([nextView], animated: true)} )
                
            }catch{
                let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                present(alert,animated: true, completion: nil)
                return
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

//
//  CreatePetsVC.swift
//  pettypets
//
//  Created by tarek bahie on 12/24/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit
import CoreData

class CreatePetsVC: UIViewController, UICollectionViewDelegate {
    @IBOutlet weak var nameTxtLbl: UITextField!
    @IBOutlet weak var ageTxtLbl: UITextField!
    @IBOutlet weak var typeTxtLbl: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreatePetsVC.handleTap))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(CreatePetsVC.handleTap))
        view.addGestureRecognizer(tap)
        view.addGestureRecognizer(pan)
        
    }
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    @IBAction func createBtnWasPressed(_ sender: Any) {
        if nameTxtLbl.text != "" && ageTxtLbl.text != "" && typeTxtLbl.text != ""{
            self.save { (complete) in
                if complete{
                    dismiss(animated: true, completion: nil)
                }
            }
        }
        
    }
    
    func save(completion : (_ finished: Bool)->()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        let pet = Pet(context: managedContext)
        let friend = Friend(context: managedContext)
        pet.name = nameTxtLbl.text
        pet.age = ageTxtLbl.text
        pet.type = typeTxtLbl.text
        do {
            try managedContext.save()
            completion(true)
        } catch {
            completion(false)
            debugPrint("Couldn't save : \(error.localizedDescription)")
        }
        
    }

}

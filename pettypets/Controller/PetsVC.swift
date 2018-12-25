//
//  PetsVC.swift
//  pettypets
//
//  Created by tarek bahie on 12/24/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit
import CoreData


class PetsVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var undoBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    public static var friendName : Friend?
    var pets :[Pet] = []
    var i: IndexPath?
    public static var nameOfFriendReceived = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoreDataObjects()
        collectionView.reloadData()
        collectionView.delegate = self
        collectionView.dataSource = self
        undoBtn.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        self.collectionView.reloadData()
        if pets.count >= 1{
            let endIndex = IndexPath(row: pets.count - 1, section: 0)
            collectionView.scrollToItem(at: endIndex, at: .bottom, animated: true)
            
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   static func setFriendName(friend : Friend){
    PetsVC.friendName = friend
    PetsVC.nameOfFriendReceived = friend.name!
    print(PetsVC.nameOfFriendReceived)
    }
    
    
    
    
    
    @IBAction func undoBtnWasPressed(_ sender: Any) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        managedContext.delete(pets[(i?.row)!])
        fetchCoreDataObjects()
        collectionView.reloadData()
        undoBtn.isHidden = true
    }
    
    @IBAction func addPetsWasPressed(_ sender: Any) {
        performSegue(withIdentifier: "toCreatePets", sender: self)
    }
    
    func fetchCoreDataObjects(){
        self.fetch { (complete) in
            if complete{
                if pets.count >=  1{
                collectionView.isHidden = false
                }else{
                    collectionView.isHidden = true
                }
        }
    }
        
    }
    

}
extension PetsVC : UICollectionViewDelegate,UICollectionViewDataSource{

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pets.count
}


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PC", for: indexPath) as? PetCell else{
            return UICollectionViewCell()
        }
        let pet = pets[indexPath.row]
        cell.configureCell(pet: pet)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        undoBtn.setTitle("DELETE PET", for: .normal)
        undoBtn.isHidden = false
        self.i = indexPath
        
    }

}
extension PetsVC {
    
    
    func fetch(completion : (_ complete : Bool)->()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        do{
        let fetchRequest = NSFetchRequest<Pet>(entityName: "Pet")
        fetchRequest.predicate = NSPredicate(format: "friendName = %@", PetsVC.nameOfFriendReceived)
         pets = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            completion(false)
            debugPrint("Couldn't fetch : \(error.localizedDescription)")
        }
        
    }

    func deletePet(atIndexPath indexPath : IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        managedContext.delete(pets[indexPath.row])
        undoBtn.isHidden = true
        do {
            try managedContext.save()
        } catch {
            debugPrint("Couldn't delete : \(error.localizedDescription)")
        }
    }
   
}

/*
import Foundation
import CoreData
class dataService{
    static let instance = dataService()
    var pets :[Pet] = []
    var friends :[Friend] = []

    func fetch(completion : (_ complete : Bool)->()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        let fetchRequest = NSFetchRequest<Pet>(entityName: "Pet")
        do{
            pets = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            completion(false)
            debugPrint("Couldn't fetch : \(error.localizedDescription)")
        }
        
    }
    
    
    
    func  getPets()->[Pet]{
        return
    }
    func getFriends() -> [Friend] {
        return
    }

    func getPetsForFriend(friendName name : String)->[Pet]{
        return
    }

}

 
 
 
 
 
 */

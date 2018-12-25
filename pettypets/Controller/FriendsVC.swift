import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class FriendsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var undoBtn: UIButton!
    
    var friends : [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        undoBtn.isHidden = true
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        self.tableView.reloadData()
        if friends.count >= 1{
            let endIndex = IndexPath(row: friends.count - 1, section: 0)
            tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
        }
    }
    @IBAction func addFriendsButtonWasPressed(_ sender: Any) {
        performSegue(withIdentifier: "toCreateFriends", sender: self)
    }
    
    @IBAction func undoBtnWasPressed(_ sender: Any) {
        let managedContext = appDelegate?.persistentContainer.viewContext
        managedContext?.undoManager?.undo()
        fetchCoreDataObjects()
        tableView.reloadData()
        undoBtn.isHidden = true
    }
    
    func fetchCoreDataObjects(){
        self.fetch { (complete) in
            if complete{
                if friends.count >= 1 {
                    tableView.isHidden = false
                }else {
                    tableView.isHidden = true
                }
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FC") as? FriendCell  else{
            return UITableViewCell()
    }
        let friend = friends[indexPath.row]
        cell.configureCell(friend: friend)
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction , indexPath) in
            self.removeFriend(atIndexPat: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friendspassed = friends[indexPath.row]
        PetsVC.setFriendName(friend: friendspassed)
        performSegue(withIdentifier: "toAddPets", sender: self)
    }
   

    
}
extension FriendsVC {

    func fetch(completion : (_ complete : Bool)->()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        let fetchRequest = NSFetchRequest<Friend>(entityName: "Friend")
        do{
            friends = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch{
            debugPrint("Couldn't fetch\(error.localizedDescription)")
            completion(false)
        }
}

    func removeFriend(atIndexPat indexPath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        managedContext.undoManager = UndoManager()
        managedContext.delete(friends[indexPath.row])
        undoBtn.isHidden = false
        do {
            try managedContext.save()
        } catch{
            debugPrint("Couldn't remove\(error.localizedDescription)")
        }
        
    }
    
    
    
}

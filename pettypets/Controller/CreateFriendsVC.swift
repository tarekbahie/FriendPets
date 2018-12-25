import UIKit
import CoreData

class CreateFriendsVC: UIViewController, UITableViewDelegate {

    @IBOutlet weak var nameLbl: UITextField!
    @IBOutlet weak var ageLbl: UITextField!
    @IBOutlet weak var genderLbl: UITextField!
    @IBOutlet weak var createBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        createBtn.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateFriendsVC.handleTap))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(CreateFriendsVC.handleTap))
        view.addGestureRecognizer(tap)
        view.addGestureRecognizer(pan)
        
    }
    @objc func handleTap(){
        view.endEditing(true)
    }

    @IBAction func createBtnPressed(_ sender: Any) {
        if nameLbl.text != "" && ageLbl.text != "" && genderLbl.text != "" {
            self.save { (complete) in
                if complete{
                    dismiss(animated: true, completion: nil)
                    
                }
            }
        }

        dismiss(animated: true, completion: nil)
    }

    func save(completion : (_ finished : Bool)->()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        let friend = Friend(context: managedContext)
        friend.age = ageLbl.text!
        friend.gender = genderLbl.text!
        friend.name = nameLbl.text!
        do{
            try managedContext.save()
            completion(true)
            print("Save success")
            print(friend.age!)
        } catch{
            debugPrint("Couldn't Save: \(error.localizedDescription)")
            completion(false)
        }
    }

}

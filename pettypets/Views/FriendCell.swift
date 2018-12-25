import UIKit

class FriendCell: UITableViewCell {
    @IBOutlet weak var nameTxtLbl: UILabel!
    @IBOutlet weak var ageTxtLbl: UILabel!
    @IBOutlet weak var genderTxtLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(friend : Friend){
        self.nameTxtLbl.text = friend.name
        self.ageTxtLbl.text = friend.age
        self.genderTxtLbl.text = friend.gender
        
    }

}

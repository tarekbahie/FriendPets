//
//  PetCell.swift
//  pettypets
//
//  Created by tarek bahie on 12/24/18.
//  Copyright © 2018 tarek bahie. All rights reserved.
//

import UIKit

class PetCell: UICollectionViewCell {
    @IBOutlet weak var nameTxtLbl: UILabel!
    @IBOutlet weak var ageTxtLbl: UILabel!
    @IBOutlet weak var typeTxtLbl: UILabel!
    
    
    
    func configureCell(pet : Pet){
        self.nameTxtLbl.text = pet.name
        self.ageTxtLbl.text = pet.age
        self.typeTxtLbl.text = pet.type
    }
    
}

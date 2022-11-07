//
//  tagCVCell.swift
//  NoteList
//
//  Created by Admin on 06/11/22.
//

import UIKit

class tagCVCell: UICollectionViewCell {
    @IBOutlet weak var tagLbl: UILabel!
    @IBOutlet weak var tagView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tagView.layer.cornerRadius = 15.0
        self.tagView.layer.borderColor = UIColor.darkGray.cgColor
        self.tagView.layer.borderWidth = 1.0
        
        // Initialization code
    }

}

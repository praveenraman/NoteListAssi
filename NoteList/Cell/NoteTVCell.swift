//
//  NoteTVCell.swift
//  NoteList
//
//  Created by Admin on 06/11/22.
//

import UIKit

class NoteTVCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var headlineLbl: UILabel!
    @IBOutlet weak var starLbl: UILabel!
    @IBOutlet weak var addLbl: UILabel!
    @IBOutlet weak var clickMore: UIButton!
    @IBOutlet weak var commentCLbl: UILabel!
    @IBOutlet weak var LikeStatusLbl: UILabel!
    @IBOutlet weak var FavouriteStatusLbl: UILabel!
    @IBOutlet weak var shareLbl: UILabel!
    @IBOutlet weak var shareImg: UIImageView!
    @IBOutlet weak var faveImg: UIImageView!
    @IBOutlet weak var coverImg: UIImageView!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.cornerRadius = 6.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func loadCellData(nData: NoteData){
        self.headlineLbl.text = nData.headLine
        self.starLbl.text = "\(nData.avgRating) Rating"
        self.addLbl.text = nData.description
        let cellWidth = Int(self.contentView.frame.width - 100)
        if self.addLbl.text!.count > cellWidth{
        let readmoreFont = UIFont(name: "Helvetica-Oblique", size: 10.0)
        let readmoreFontColor = UIColor.blue
        DispatchQueue.main.async {
            self.addLbl.addTrailing(with: "... ", moreText: "Click more", moreTextFont: readmoreFont!, moreTextColor: readmoreFontColor)
         }
        }
        self.LikeStatusLbl.text = "\(nData.count)"
        self.commentCLbl.text = "\(nData.commentsCount)"
        self.FavouriteStatusLbl.text = "\(nData.commentsCount)"
        self.faveImg.image = UIImage.init(named: nData.favoriteStatus ? "fave":"icons8-heart-100")
        if nData.coverPic != nil{
            let url = URL(string: nData.coverPic.url)
            DispatchQueue.global().async{
                let data = try? Data(contentsOf: url!)
                if data != nil{
                DispatchQueue.main.async {
                    self.coverImg.image = UIImage(data: data!)
                }
              }
            }
        }
    }
}


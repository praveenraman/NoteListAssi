//
//  ProfileViewController.swift
//  NoteList
//
//  Created by Admin on 06/11/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var navBarHt: NSLayoutConstraint!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var gLbl: UILabel!
    @IBOutlet weak var mLbl: UILabel!
    @IBOutlet weak var eLbl: UILabel!
    @IBOutlet weak var addLbl: UILabel!
    @IBOutlet weak var abLbl: UILabel!
    @IBOutlet weak var uImg: UIImageView!
    
    var results: NoteData!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpDtl()
        if results != nil{
            self.loadUserInfo(noteResult: results)
        }
    }
    func setUpDtl(){
        self.navBarHt.constant = deviceHeights()
    }
    func loadUserInfo(noteResult: NoteData){
        if results.userDetails != nil{
            self.nameLbl.text = results.userDetails.name
            self.gLbl.text = results.userDetails.gender
            if results.userDetails.mobile == 0{
                self.mLbl.text = "-"
            }else{
                self.mLbl.text = "\(results.userDetails.mobile)"
            }
            self.eLbl.text = results.userDetails.email
            self.addLbl.text = results.userDetails.location
            self.abLbl.text = results.userDetails.aboutUs
        }
    }
    @IBAction func goToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


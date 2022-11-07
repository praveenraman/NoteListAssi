//
//  ViewController.swift
//  NoteList
//
//  Created by Praveen Kumar on 05/11/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var noteData = [NoteData]()
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var navBarHt: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.estimatedRowHeight = 88.0
        self.tblView.rowHeight = UITableView.automaticDimension
        self.setUpDtl()
    }
    func setUpDtl(){
        self.navBarHt.constant = deviceHeights()
        for nib in NoteConstants.fechListCells {
            self.tblView.register(UINib(nibName: nib, bundle: nil), forCellReuseIdentifier: nib)
        }
        self.noteListingData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func noteListingData(){
        let sessionConfig = URLSessionConfiguration.default
        let sessionUrl = URLSession(configuration: sessionConfig)
        let url = URL(string: "https://gosee.s3.amazonaws.com/notelist.json")!
        let request: URLRequest = URLRequest(url:url)
        let task = sessionUrl.dataTask(with: request){
            (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else{
                do {
                    if let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [Any] {
                        /*for item in json {
                            if let object = item as? [String: Any]{
                             print(object)
                            }
                        }*/
                        if let result  = json as? NSArray {
                            for dict in result {
                                if let respDict = dict as? Dictionary<String, AnyObject>{
                                    self.noteData.append(NoteData.init(responseDict: respDict))
                                }
                            }
                        }
                        // Reload data of TableView/CollectionView
                        DispatchQueue.main.async {
                         self.tblView.reloadData()
                        }
                    }
                }catch {
                    print("error in JSONSerialization")
                }
            }}
        task.resume()
    }
   }

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.noteData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "NoteTVCell", for: indexPath) as! NoteTVCell
        cell.loadCellData(nData: noteData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushToLocation(noteResult: noteData[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
      }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
      }
    
    func pushToLocation(noteResult: NoteData){
        let newCon = self.storyboard?.instantiateViewController(withIdentifier: "NoteListDetailsVC") as! NoteListDetailsVC
        newCon.results = noteResult
        self.navigationController?.pushViewController(newCon, animated: true)
    }
}

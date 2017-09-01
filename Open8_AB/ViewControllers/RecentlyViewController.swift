//
//  RecentlyViewController.swift
//  Open8_AB
//
//  Created by 양희준 on 2017. 8. 25..
//  Copyright © 2017년 양희준. All rights reserved.
//

import UIKit

class RecentlyTableViewCell: UITableViewCell {
    @IBOutlet fileprivate weak var hintImageView: UIImageView!
    @IBOutlet fileprivate weak var hintNameLabel: UILabel!
    @IBOutlet fileprivate weak var hintGPSLabel: UILabel!
    @IBOutlet fileprivate weak var hintDistanceLabel: UILabel!
    @IBOutlet fileprivate weak var hintGoodLabel: UILabel!
    @IBOutlet fileprivate weak var hintRecommendationLabel: UILabel!
    
}

class RecentlyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet fileprivate weak var hintTableView: UITableView!
    
    var Company = realm.objects(clBusinness.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hintTableView.allowsSelection = true
        hintTableView.delegate = self
        hintTableView.dataSource = self
        
        print("Count = \(Company.count)")
        
        print(Company)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetch_data(){
        Company = realm.objects(clBusinness.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Company.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentlyCell", for: indexPath) as! RecentlyTableViewCell
        
        cell.hintNameLabel.text = Company[indexPath.row].name
        
        let fullUrl = "http://open8.vps.phps.kr/open8_re/shopImg/" + Company[indexPath.row].id + "/shopImg0.png"
        let url = NSURL(string: fullUrl)
        
        cell.hintImageView.af_setImage(withURL: url! as URL, placeholderImage: UIImage(named:"loader"), filter: nil, imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true, completion: nil)
        
        cell.hintGPSLabel.text = Company[indexPath.row].areaD
        cell.hintGoodLabel.text = Company[indexPath.row].like
        cell.hintRecommendationLabel.text = Company[indexPath.row].favorite
        let tvlat = Double(Company[indexPath.row].lat)
        let tvlng = Double(Company[indexPath.row].lng)
        cell.hintDistanceLabel.text = "\(distance(lat1: glat, lng1: glng, lat2: tvlat!, lng2: tvlng!))km"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier : "Infomation") as! InfomationViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        viewController.indexNumber = indexPath.row
        viewController.type = DEFINE_ALL
        
        // select businness item DB add
        addBusinness(businness: businness[indexPath.row])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetch_data()
        hintTableView.reloadData()
    }
    
       /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

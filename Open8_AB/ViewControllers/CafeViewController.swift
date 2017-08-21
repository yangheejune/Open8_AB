//
//  ContentViewController.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko
//  Copyright © 2016 Yalantis Mobile. All rights reserved.
//

import UIKit
import AlamofireImage

private func yal_isPhone6() -> Bool {
    let size = UIScreen.main.bounds.size
    let minSide = min(size.height, size.width)
    let maxSide = max(size.height, size.width)
    return (fabs(minSide - 375.0) < 0.01) && (fabs(maxSide - 667.0) < 0.01)
}

class CafeTableViewCell: UITableViewCell {
    //@IBOutlet fileprivate weak var hintLabel: UILabel!
    @IBOutlet fileprivate weak var hintImageView: UIImageView!
    @IBOutlet fileprivate weak var hintNameLabel: UILabel!
    @IBOutlet fileprivate weak var hintGPSLabel: UILabel!
    @IBOutlet fileprivate weak var hintDistanceLabel: UILabel!
    @IBOutlet fileprivate weak var hintGoodLabel: UILabel!
    @IBOutlet fileprivate weak var hintRecommendationLabel: UILabel!
    
}

class CafeViewController: UIViewController {
    
    //@IBOutlet fileprivate weak var cardNameLabel: UILabel!
    @IBOutlet fileprivate weak var hintTableView: UITableView!
    //@IBOutlet fileprivate weak var bottomCardConstraint: NSLayoutConstraint!
    //@IBOutlet fileprivate weak var heightConstraint: NSLayoutConstraint!
    
    var disaster: Disaster?
    fileprivate var hintLabel: [String]?
    fileprivate var hintImage: UIImage?
    fileprivate var hintNameLabel: String?
    fileprivate var hintGPSLabel: String?
    fileprivate var hintDistanceLabel: String?
    fileprivate var hintGoodLabel: String?
    fileprivate var hintRecommendationLabel: String?
    
    class func create() -> UIViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: self)) as! CafeViewController
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension CafeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return hints?.count ?? 0
        print("Cafe count = \(Cafe.count)")
        print("section = \(section)")
        return Cafe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CafeTableViewCell

        cell.hintNameLabel.text = Cafe[indexPath.row].name
        
        let fullUrl = "http://open8.vps.phps.kr/open8_re/shopImg/" + Cafe[indexPath.row].id + "/shopImg0.png"
        let url = NSURL(string: fullUrl)
        
        cell.hintImageView.af_setImage(withURL: url! as URL, placeholderImage: UIImage(named:"loader"), filter: nil, imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true, completion: nil)
        
        cell.hintGPSLabel.text = Cafe[indexPath.row].areaD
        cell.hintGoodLabel.text = Cafe[indexPath.row].like
        cell.hintRecommendationLabel.text = Cafe[indexPath.row].favorite
        let tvlat = Double(Cafe[indexPath.row].lat)
        let tvlng = Double(Cafe[indexPath.row].lng)
        cell.hintDistanceLabel.text = "\(distance(lat1: glat, lng1: glng, lat2: tvlat!, lng2: tvlng!))km"
        
        return cell
    }
    
}

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

class HairNailTableViewCell: UITableViewCell {
    //@IBOutlet fileprivate weak var hintLabel: UILabel!
    @IBOutlet fileprivate weak var hintImageView: UIImageView!
    @IBOutlet fileprivate weak var hintNameLabel: UILabel!
    @IBOutlet fileprivate weak var hintGPSLabel: UILabel!
    @IBOutlet fileprivate weak var hintDistanceLabel: UILabel!
    @IBOutlet fileprivate weak var hintGoodLabel: UILabel!
    @IBOutlet fileprivate weak var hintRecommendationLabel: UILabel!
    
}

class HairNailViewController: UIViewController {
    
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
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: self)) as! HairNailViewController
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension HairNailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return hints?.count ?? 0
        print("HairNail count = \(HairNail.count)")
        print("section = \(section)")
        return HairNail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HairNailTableViewCell
        
        cell.hintNameLabel.text = HairNail[indexPath.row].name
        
        let fullUrl = "http://open8.vps.phps.kr/open8_re/shopImg/" + HairNail[indexPath.row].id + "/shopImg0.png"
        let url = NSURL(string: fullUrl)
        
        cell.hintImageView.af_setImage(withURL: url! as URL, placeholderImage: UIImage(named:"loader"), filter: nil, imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true, completion: nil)
        
        cell.hintGPSLabel.text = HairNail[indexPath.row].areaD
        cell.hintGoodLabel.text = HairNail[indexPath.row].like
        cell.hintRecommendationLabel.text = HairNail[indexPath.row].favorite
        let tvlat = Double(HairNail[indexPath.row].lat)
        let tvlng = Double(HairNail[indexPath.row].lng)
        cell.hintDistanceLabel.text = "\(distance(lat1: glat, lng1: glng, lat2: tvlat!, lng2: tvlng!))km"

        return cell
    }
    
}

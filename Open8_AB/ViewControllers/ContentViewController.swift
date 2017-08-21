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

class ExampleTableViewCell: UITableViewCell {
    //@IBOutlet fileprivate weak var hintLabel: UILabel!
    @IBOutlet fileprivate weak var hintImageView: UIImageView!
    @IBOutlet fileprivate weak var hintNameLabel: UILabel!
    @IBOutlet fileprivate weak var hintGPSLabel: UILabel!
    @IBOutlet fileprivate weak var hintDistanceLabel: UILabel!
    @IBOutlet fileprivate weak var hintGoodLabel: UILabel!
    @IBOutlet fileprivate weak var hintRecommendationLabel: UILabel!
    
}

class ContentViewController: UIViewController {
    
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
    
    class func create() -> ContentViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: self)) as! ContentViewController
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //hintTableView.rowHeight = UITableViewAutomaticDimension
        //hintTableView.estimatedRowHeight = 100
        
//        if yal_isPhone6() {
//            bottomCardConstraint.priority = 900
//            heightConstraint.priority = 1000
//            heightConstraint.constant = 430
//        } else {
//            bottomCardConstraint.priority = 1000
//            heightConstraint.priority = 900
//        }
        
        if let disaster = disaster {
            //cardNameLabel.text = disaster.cardName
            //hintLabel = disaster.hintLabel
            hintNameLabel = disaster.hintNameLabel
            hintGPSLabel = disaster.hintGPSLabel
            hintDistanceLabel = disaster.hintDistanceLabel
            hintGoodLabel = disaster.hintGoodLabel
            hintRecommendationLabel = disaster.hintRecommendationLabel
        }
    }
    
}

extension ContentViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return hints?.count ?? 0
        print("businness count = \(businness.count)")
        print("section = \(section)")
        return businness.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ExampleTableViewCell
        
        // 여기서 먼저 인덱스를 확인하여 홈인지 카페인지 음식점인지를 확인
        // 1
        //cell.hintLabel?.text = hints?[indexPath.row]
        cell.hintNameLabel.text = businness[indexPath.row].name
        
        let fullUrl = "http://open8.vps.phps.kr/open8_re/shopImg/" + businness[indexPath.row].id + "/shopImg0.png"
        let url = NSURL(string: fullUrl)
        
        cell.hintImageView.af_setImage(withURL: url! as URL, placeholderImage: UIImage(named:"loader"), filter: nil, imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true, completion: nil)
        
        cell.hintGPSLabel.text = businness[indexPath.row].areaD
        cell.hintGoodLabel.text = businness[indexPath.row].like
        cell.hintRecommendationLabel.text = businness[indexPath.row].favorite
        let tvlat = Double(businness[indexPath.row].lat)
        let tvlng = Double(businness[indexPath.row].lng)
        cell.hintDistanceLabel.text = "\(distance(lat1: glat, lng1: glng, lat2: tvlat!, lng2: tvlng!))km"
        
        //print("indexpath = \(indexPath.row)")
        //cell.hintNameLabel.text = "가게이름"
        //cell.hintImageView.image = UIImage(named: "")
        //cell.hintGPSLabel.text = "경로"
        //cell.hintDistanceLabel.text = "거리"
        //cell.hintGoodLabel.text = "좋아요"
        //cell.hintRecommendationLabel.text = "추천"
        
        //cell.hintImageView.Image = UIImage(named: "mane")
        return cell
    }
    
}

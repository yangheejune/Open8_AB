import UIKit
import AlamofireImage

class HairNailTableViewCell: UITableViewCell {
    @IBOutlet fileprivate weak var hintImageView: UIImageView!
    @IBOutlet fileprivate weak var hintNameLabel: UILabel!
    @IBOutlet fileprivate weak var hintGPSLabel: UILabel!
    @IBOutlet fileprivate weak var hintDistanceLabel: UILabel!
    @IBOutlet fileprivate weak var hintGoodLabel: UILabel!
    @IBOutlet fileprivate weak var hintRecommendationLabel: UILabel!
    
}

class HairNailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet fileprivate weak var hintTableView: UITableView!
    
    class func create() -> UIViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: self)) as! HairNailViewController
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hintTableView.allowsSelection = true
        hintTableView.delegate = self
        hintTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier : "Infomation") as! InfomationViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        viewController.indexNumber = indexPath.row
        viewController.type = DEFINE_HAIRNAIL
        
        // select businness item DB add
        addBusinness(businness: HairNail[indexPath.row])
        print("businness item DB ADD")
    }

}


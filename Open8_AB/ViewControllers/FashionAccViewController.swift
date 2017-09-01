import UIKit
import AlamofireImage

class FashionAccTableViewCell: UITableViewCell {
    @IBOutlet fileprivate weak var hintImageView: UIImageView!
    @IBOutlet fileprivate weak var hintNameLabel: UILabel!
    @IBOutlet fileprivate weak var hintGPSLabel: UILabel!
    @IBOutlet fileprivate weak var hintDistanceLabel: UILabel!
    @IBOutlet fileprivate weak var hintGoodLabel: UILabel!
    @IBOutlet fileprivate weak var hintRecommendationLabel: UILabel!
    
}

class FashionAccViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet fileprivate weak var hintTableView: UITableView!

    class func create() -> UIViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: self)) as! FashionAccViewController
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hintTableView.allowsSelection = true
        hintTableView.delegate = self
        hintTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FashionAcc.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FashionAccTableViewCell
        
        cell.hintNameLabel.text = FashionAcc[indexPath.row].name
        
        let fullUrl = "http://open8.vps.phps.kr/open8_re/shopImg/" + FashionAcc[indexPath.row].id + "/shopImg0.png"
        let url = NSURL(string: fullUrl)
        
        cell.hintImageView.af_setImage(withURL: url! as URL, placeholderImage: UIImage(named:"loader"), filter: nil, imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true, completion: nil)
        
        cell.hintGPSLabel.text = FashionAcc[indexPath.row].areaD
        cell.hintGoodLabel.text = FashionAcc[indexPath.row].like
        cell.hintRecommendationLabel.text = FashionAcc[indexPath.row].favorite
        let tvlat = Double(FashionAcc[indexPath.row].lat)
        let tvlng = Double(FashionAcc[indexPath.row].lng)
        cell.hintDistanceLabel.text = "\(distance(lat1: glat, lng1: glng, lat2: tvlat!, lng2: tvlng!))km"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier : "Infomation") as! InfomationViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        viewController.indexNumber = indexPath.row
        viewController.type = DEFINE_FASHIONACC
        
        // select businness item DB add
        addBusinness(businness: FashionAcc[indexPath.row])
        print("businness item DB ADD")
    }

}

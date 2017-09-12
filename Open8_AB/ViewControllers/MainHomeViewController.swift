import UIKit
import AlamofireImage

class MainHomeTableViewCell: UITableViewCell {
    @IBOutlet fileprivate weak var hintImageView: UIImageView!
    @IBOutlet fileprivate weak var hintNameLabel: UILabel!
    @IBOutlet fileprivate weak var hintGPSLabel: UILabel!
    @IBOutlet fileprivate weak var hintDistanceLabel: UILabel!
    @IBOutlet fileprivate weak var hintGoodLabel: UILabel!
    @IBOutlet fileprivate weak var hintRecommendationLabel: UILabel!
    
}

class MainHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet fileprivate weak var hintTableView: UITableView!
    
    class func create() -> UIViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: self)) as! MainHomeViewController
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Restaurant = self.setRestaurant(businnessInfo: businness)
        Cafe       = self.setCafe(businnessInfo: businness)
        Bar        = self.setBar(businnessInfo: businness)
        HairNail   = self.setHairNail(businnessInfo: businness)
        BodyHealth = self.setBodyHealth(businnessInfo: businness)
        FashionAcc = self.setFashionAcc(businnessInfo: businness)

        
        hintTableView.allowsSelection = true
        hintTableView.delegate = self
        hintTableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businness.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainHomeTableViewCell
        
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier : "Infomation") as! InfomationViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        viewController.indexNumber = indexPath.row
        viewController.type = DEFINE_ALL
        
        // select businness item DB add
        addBusinness(businness: businness[indexPath.row])
        print("businness item DB ADD")
    }
    
    // 음식점 획득
    func setRestaurant(businnessInfo:Array<BusinnessItem>) -> Array<BusinnessItem>
    {
        var Restaurant = [BusinnessItem]()
        for index in 0...businnessInfo.count - 1
        {
            if DEFINE_RESTAURANT == Int(businnessInfo[index].type)
            {
                Restaurant.append(businnessInfo[index])
            }
        }
        print("Restaurant Count = \(Restaurant.count)")
        return Restaurant
    }
    
    // 카페 획득
    func setCafe(businnessInfo:Array<BusinnessItem>) -> Array<BusinnessItem>
    {
        var Cafe = [BusinnessItem]()
        for index in 0...businnessInfo.count - 1
        {
            if DEFINE_CAFE == Int(businnessInfo[index].type)
            {
                Cafe.append(businnessInfo[index])
            }
        }
        print("Cafe Count = \(Cafe.count)")
        return Cafe
    }
    
    // 술집 획득
    func setBar(businnessInfo:Array<BusinnessItem>) -> Array<BusinnessItem>
    {
        var Bar = [BusinnessItem]()
        for index in 0...businnessInfo.count - 1
        {
            if DEFINE_BAR == Int(businnessInfo[index].type)
            {
                Bar.append(businnessInfo[index])
            }
        }
        print("Bar Count = \(Bar.count)")
        return Bar
    }
    
    // 헤어네일 획득
    func setHairNail(businnessInfo:Array<BusinnessItem>) -> Array<BusinnessItem>
    {
        var HairNail = [BusinnessItem]()
        for index in 0...businnessInfo.count - 1
        {
            if DEFINE_HAIRNAIL == Int(businnessInfo[index].type)
            {
                HairNail.append(businnessInfo[index])
            }
        }
        print("HairNail Count = \(HairNail.count)")
        return HairNail
    }
    
    
    // 패션악세사리 획득
    func setFashionAcc(businnessInfo:Array<BusinnessItem>) -> Array<BusinnessItem>
    {
        var FashionAcc = [BusinnessItem]()
        for index in 0...businnessInfo.count - 1
        {
            if DEFINE_FASHIONACC == Int(businnessInfo[index].type)
            {
                FashionAcc.append(businnessInfo[index])
            }
        }
        print("FashionAcc Count = \(FashionAcc.count)")
        return FashionAcc
    }
    
    // 바디헬스 획득
    func setBodyHealth(businnessInfo:Array<BusinnessItem>) -> Array<BusinnessItem>
    {
        var BodyHealth = [BusinnessItem]()
        for index in 0...businnessInfo.count - 1
        {
            if DEFINE_BODYHEALTH == Int(businnessInfo[index].type)
            {
                BodyHealth.append(businnessInfo[index])
            }
        }
        print("BodyHealth Count = \(BodyHealth.count)")
        return BodyHealth
    }


}

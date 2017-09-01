//
//  InfomationViewController.swift
//  
//
//  Created by 양희준 on 2017. 8. 14..
//
//

import UIKit
import MapKit
import AlamofireImage

class InfomationViewController: UIViewController {
    var indexNumber: Int = 0
    var type: Int = 0
    var Business_Type = [BusinnessItem]()


    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoScrollView: UIScrollView!
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var infoBusinessLabel: UILabel!
    @IBOutlet weak var infoText: UITextView!
    @IBOutlet weak var infoBusinessMap: MKMapView!
    @IBOutlet weak var LableKm: UILabel!
    @IBOutlet weak var LableLoveCount: UILabel!
    @IBOutlet weak var LableBookMake: UILabel!
    @IBOutlet weak var openTime: UILabel!
    @IBOutlet weak var closeTime: UILabel!
    
        override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("IndexNumber = \(indexNumber) type = \(type)")
        
        infoScrollView.contentSize = infoView.frame.size
        infoScrollView.addSubview(infoView)
        
        switch type {
            case DEFINE_RESTAURANT:
                Business_Type = Restaurant
            case DEFINE_CAFE:
                Business_Type = Cafe
            case DEFINE_BAR:
                Business_Type = Bar
            case DEFINE_HAIRNAIL:
                Business_Type = HairNail
            case DEFINE_BODYHEALTH:
                Business_Type = BodyHealth
            case DEFINE_FASHIONACC:
                Business_Type = FashionAcc
        default:
            Business_Type = businness
        }
        
        setInfo(Business_Type: Business_Type)
        DetailView(Business_Type: Business_Type)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goLocation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue : CLLocationDegrees, delta span :Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpanMake(0.005, 0.005)
        let pRegion = MKCoordinateRegionMake(pLocation, spanValue)
        infoBusinessMap.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    func setAnnotation(latitude latitudeValue : CLLocationDegrees, longitude longitudeValue : CLLocationDegrees, delta span :Double, title strTitle : String, subtitle strSubtitle : String) {
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitude: latitudeValue, longitude: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        infoBusinessMap.addAnnotation(annotation)
    }
    
    func setInfo(Business_Type: [BusinnessItem]){
        infoBusinessLabel.text = Business_Type[indexNumber].name
        
        openTime.text = "Open : " + Business_Type[indexNumber].open
        closeTime.text = "Close : " + Business_Type[indexNumber].close
        //telNumber.text = businness[indexNumber].tel
        
        setAnnotation(latitude: Double(Business_Type[indexNumber].lat)!, longitude: Double(Business_Type[indexNumber].lng)!, delta: 1, title: Business_Type[indexNumber].name, subtitle: Business_Type[indexNumber].areaD)
    }
    
    func DetailView(Business_Type: [BusinnessItem]){
        
        infoBusinessLabel.text = Business_Type[indexNumber].name
        let tvlat = Double(Business_Type[indexNumber].lat)
        let tvlng = Double(Business_Type[indexNumber].lng)
        LableKm.text = "\(distance(lat1: glat, lng1: glng, lat2: tvlat!, lng2: tvlng!))km"
        LableLoveCount.text = Business_Type[indexNumber].like
        LableBookMake.text = Business_Type[indexNumber].favorite
        
        let fullUrl = "http://open8.vps.phps.kr/open8_re/shopImg/" + Business_Type[indexNumber].id + "/shopImg0.png"
        let url = NSURL(string: fullUrl)
        infoImageView.af_setImage(withURL: url! as URL, placeholderImage: UIImage(named:"loader"), filter: nil, imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true, completion: nil)
        
        setAnnotation(latitude: Double(Business_Type[indexNumber].lat)!, longitude: Double(Business_Type[indexNumber].lng)!, delta: 1, title: Business_Type[indexNumber].name, subtitle: Business_Type[indexNumber].areaD)
    }
    
    @IBAction func telCall(_ sender: Any) {
        let PhoneNumbel = Business_Type[indexNumber].tel
        
        let url = NSURL(string: PhoneNumbel)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url as URL)
        } else {
            UIApplication.shared.openURL(url as URL)
        }
        
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

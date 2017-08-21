//
//  InfomationViewController.swift
//  
//
//  Created by 양희준 on 2017. 8. 14..
//
//

import UIKit
import MapKit

class InfomationViewController: UIViewController {
    var indexNumber: Int = 0
    var type: Int = 0

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoScrollView: UIScrollView!
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var infoBusinessLabel: UILabel!
    @IBOutlet weak var infoText: UITextView!
    @IBOutlet weak var infoBusinessMap: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("IndexNumber = \(indexNumber) type = \(type)")
        
        infoScrollView.contentSize = infoView.frame.size
        infoScrollView.addSubview(infoView)
        
        setInfo()
        DetailView()
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
    
    func setInfo(){
        infoBusinessLabel.text = businness[indexNumber].name
        
        //openTime.text = businness[indexNumber].open
        //closeTime.text = businness[indexNumber].close
        //telNumber.text = businness[indexNumber].tel
        
        setAnnotation(latitude: Double(businness[indexNumber].lat)!, longitude: Double(businness[indexNumber].lng)!, delta: 1, title: businness[indexNumber].name, subtitle: businness[indexNumber].areaD)
        
    }
    
    func DetailView(){
        infoBusinessLabel.text = Restaurant[indexNumber].name
        let tvlat = Double(Restaurant[indexNumber].lat)
        let tvlng = Double(Restaurant[indexNumber].lng)
        LableKm.text = "\(distance(lat1: glat, lng1: glng, lat2: tvlat!, lng2: tvlng!))km"
        LableLoveCount.text = Restaurant[indexNumber].like
        LableBookMake.text = Restaurant[indexNumber].favorite
        
        let fullUrl = "http://open8.vps.phps.kr/open8_re/shopImg/" + Restaurant[indexNumber].id + "/shopImg0.png"
        let url = NSURL(string: fullUrl)
        let data = NSData(contentsOf: url! as URL) as Data?
        if data != nil
        {
            UIView.image = UIImage(data:data!)
        }
        
        setAnnotation(latitude: Double(businness[indexNumber].lat)!, longitude: Double(businness[indexNumber].lng)!, delta: 1, title: businness[indexNumber].name, subtitle: businness[indexNumber].areaD)

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

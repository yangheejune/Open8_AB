//
//  EmbedContainerViewController.swift
//  Open8_AB
//
//  Created by 양희준 on 2017. 7. 18..
//  Copyright © 2017년 양희준. All rights reserved.
//

import UIKit
import Segmentio
import Alamofire
import MapKit

private let animateDuration: TimeInterval = 0.6

class EmbedContainerViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()

    var style = SegmentioStyle.onlyLabel
    
    fileprivate var currentViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 위치 정보 받아와서 출력
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        DispatchQueue.global().async {
        self.GetBusinness()
        }
        
        wait( { return businness.isEmpty } ) {
            print("완료")
        }
        
        sleep(5)
        
        Restaurant = self.setRestaurant(businnessInfo: businness)
        Cafe       = self.setCafe(businnessInfo: businness)
        Bar        = self.setBar(businnessInfo: businness)
        HairNail   = self.setHairNail(businnessInfo: businness)
        BodyHealth = self.setBodyHealth(businnessInfo: businness)
        FashionAcc = self.setFashionAcc(businnessInfo: businness)
        

        
        //dismiss(animated: false, completion: nil)

        
        presentController(controller(style))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func presentController(_ controller: UIViewController) {
        if let _ = currentViewController {
            removeCurrentViewController()
        }
        
        addChildViewController(controller)
        view.addSubview(controller.view)
        currentViewController = controller
        controller.didMove(toParentViewController: self)
    }

    fileprivate func controller(_ style: SegmentioStyle) -> ExampleViewController {
        let controller = ExampleViewController.create()
        controller.segmentioStyle = style
        controller.view.frame = view.bounds
        return controller
    }
    
    fileprivate func removeCurrentViewController() {
        currentViewController?.willMove(toParentViewController: nil)
        currentViewController?.view.removeFromSuperview()
        currentViewController?.removeFromParentViewController()
    }
    
    fileprivate func swapCurrentController(_ controller: UIViewController) {
        currentViewController?.willMove(toParentViewController: nil)
        addChildViewController(controller)
        view.addSubview(controller.view)
        
        UIView.animate(
            withDuration: animateDuration,
            animations: {
                controller.view.alpha = 1
                self.currentViewController?.view.alpha = 0
        },
            completion: { _ in
                self.currentViewController?.view.removeFromSuperview()
                self.currentViewController?.removeFromParentViewController()
                self.currentViewController = controller
                self.currentViewController?.didMove(toParentViewController: self)
        }
        )
    }
    
    // MARK: - Public functions
    
    func wait(_ waitContinuation: @escaping (()->Bool), compleation: @escaping (()->Void)) {
        var wait = waitContinuation()
        // 0.1초를 주기로 대기조건을 만족할 때 까지 대기함
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global().async {
            while wait {
                semaphore.signal()
                Thread.sleep(forTimeInterval: 0.1)
                semaphore.wait()
                DispatchQueue.main.async {
                    wait = waitContinuation()
                }
            }
            
            // 대기조건을 만족하면 처리함
            DispatchQueue.main.async {
                compleation()
            }
        }
    }
    
    func goLocation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue : CLLocationDegrees, delta span :Double)-> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        return pLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        let annotation = MKPointAnnotation()
        glat = Double(pLocation!.coordinate.latitude)
        glng = Double(pLocation!.coordinate.longitude)
        annotation.coordinate = goLocation(latitude: (pLocation?.coordinate.latitude)!, longitude: (pLocation?.coordinate.longitude)!, delta: 0.01)
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            let pm = placemarks!.first
            let country = pm!.country
            var address:String = country!
            if pm!.locality != nil {
                address += " "
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil {
                address += " "
                address += pm!.thoroughfare!
            }
            //self.lblLocationInfo.text = address
        })
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager : CLLocationManager, didFailWithError error : Error) {
        print("error : \(error.localizedDescription)")
    }

    
    func swapViewControllers(_ style: SegmentioStyle) {
        swapCurrentController(controller(style))
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
        
        return BodyHealth
    }

    
    func GetBusinness()
    {
        
        
        //activityIndicatorView.startAnimating()
        //activityIndicatorView.isHidden = false
        
        let requestURL = URL(string: "http://open8.vps.phps.kr/open8_re/bList_on.php")
        let request = URLRequest(url: requestURL!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let results = json?["result"] as? [[String: AnyObject]]
                {
                    for index in 0...results.count-1
                    {
                        let ID = results[index]["id"] as? String
                        let Name = results[index]["bName"] as? String
                        let AreaL = results[index]["areaL"] as? String
                        let AreaM = results[index]["areaM"] as? String
                        let AreaS = results[index]["areaS"] as? String
                        let AreaD = results[index]["aD"] as? String
                        let AreaD_D = results[index]["aD_d"] as? String
                        let Lat = results[index]["lat"] as? String
                        let Lng = results[index]["lng"] as? String
                        let Tel = results[index]["tel"] as? String
                        let Type = results[index]["bType"] as? String
                        let TypeA = results[index]["bTypeA"] as? String
                        let TypeB = results[index]["bTypeB"] as? String
                        let ImgCnt = results[index]["imgCnt"] as? String
                        let Open = results[index]["Open"] as? String
                        let Close = results[index]["Close"] as? String
                        let Day = results[index]["bDay"] as? String
                        let State = results[index]["state"] as? String
                        let Like = results[index]["Like"] as? String
                        let Favorite = results[index]["Favorite"] as? String
                        let C1 = results[index]["c1"] as? String
                        let C2 = results[index]["c2"] as? String
                        let T1 = results[index]["t1"] as? String
                        let Score = results[index]["fScore"] as? String
                        
                        let businnesstemp = BusinnessItem(id: ID!, name: Name!, areaL: AreaL!, areaM: AreaM!, areaS: AreaS!, areaD: AreaD!, areaD_D: AreaD_D!, lat: Lat!, lng: Lng!, tel: Tel!, type: Type!, typeA: TypeA!, typeB: TypeB!, imgCnt: ImgCnt!, open: Open!, close: Close!, day: Day!, state: State!, like: Like!, favorite: Favorite!, c1: C1!, c2: C2!, t1: T1!, score: Score!)
                        businness.append(businnesstemp)
                        print(results[index])
                    }
                }
                if json != nil
                {
                }
            }
            catch
            {
                print(error)
            }
        }
        task.resume()
    }
}


     


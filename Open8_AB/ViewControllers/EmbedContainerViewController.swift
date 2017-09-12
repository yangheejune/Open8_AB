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
    
    let semaphore = DispatchSemaphore(value: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 위치 정보 받아와서 출력
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
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
    
}


     


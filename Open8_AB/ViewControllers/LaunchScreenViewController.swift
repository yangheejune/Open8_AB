//
//  LaunchScreenViewController.swift
//  Open8_AB
//
//  Created by 양희준 on 2017. 9. 5..
//  Copyright © 2017년 양희준. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //activityStart()
        
        customActivityIndicatory(self.view, startAnimate: true)
        
        self.GetBusinness()
        
        
        perform(#selector(LaunchScreenViewController.ShowNavController), with: nil, afterDelay: 10)
        
        //activityStop()
        customActivityIndicatory(self.view, startAnimate: false)

//        var img1: NSData! = nil
//        DispatchQueue.global().sync {
//            img1 = NSData(contentsOf: URL(string: "http://open8.vps.phps.kr/open8_re/shopImg/tshop34@naver.com/shopImg2.png")!)
//        }
//        // 데이터를 다 받을 때까지 대기함
//        wait( { return img1 == nil } ) {
//            print("완료")
//            //UIImage(data: img1 as Data)
//        }
        
        //self.GetBusinness()
        
        //        wait( { return !businness.isEmpty == true} ) {
        //            print("완료")
        //            Restaurant = self.setRestaurant(businnessInfo: businness)
        //            Cafe       = self.setCafe(businnessInfo: businness)
        //            Bar        = self.setBar(businnessInfo: businness)
        //            HairNail   = self.setHairNail(businnessInfo: businness)
        //            BodyHealth = self.setBodyHealth(businnessInfo: businness)
        //            FashionAcc = self.setFashionAcc(businnessInfo: businness)
        //        }
        

    }

    func ShowNavController() {
        self.performSegue(withIdentifier: "LaunchScreenView", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

//    func wait(_ waitContinuation: @escaping (()->Bool), compleation: @escaping (()->Void)) {
//        print("AAA")
//        var wait = waitContinuation()
//        // 0.1초를 주기로 대기조건을 만족할 때 까지 대기함
//        let semaphore = DispatchSemaphore(value: 0)
//        DispatchQueue.global().sync {
//            while wait {
//                semaphore.signal()
//                Thread.sleep(forTimeInterval: 0.1)
//                semaphore.wait()
//                DispatchQueue.main.sync {
//                    print("BBB")
//                    wait = waitContinuation()
//                }
//            }
//            
//            // 대기조건을 만족하면 처리함
//            DispatchQueue.main.sync {
//                print("CCC")
//                compleation()
//            }
//        }
//    }
    
    func GetBusinness()
    {
        DispatchQueue.main.async {
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
    
    func activityStart() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }

    func activityStop() {
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func customActivityIndicatory(_ viewContainer: UIView, startAnimate:Bool? = true) -> UIActivityIndicatorView {
        let mainContainer: UIView = UIView(frame: viewContainer.frame)
        mainContainer.center = viewContainer.center
        mainContainer.backgroundColor = UIColor.init(hex32: 0xFFFFFF)
        mainContainer.alpha = 0.5
        mainContainer.tag = 789456123
        mainContainer.isUserInteractionEnabled = false
        
        let viewBackgroundLoading: UIView = UIView(frame: CGRect(x:0,y: 0,width: 80,height: 80))
        viewBackgroundLoading.center = viewContainer.center
        viewBackgroundLoading.backgroundColor = UIColor.init(hex32: 0x444444)
        viewBackgroundLoading.alpha = 0.5
        viewBackgroundLoading.clipsToBounds = true
        viewBackgroundLoading.layer.cornerRadius = 15
        
        let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.frame = CGRect(x:0.0,y: 0.0,width: 40.0, height: 40.0)
        activityIndicatorView.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        activityIndicatorView.center = CGPoint(x: viewBackgroundLoading.frame.size.width / 2, y: viewBackgroundLoading.frame.size.height / 2)
        if startAnimate!{
            viewBackgroundLoading.addSubview(activityIndicatorView)
            mainContainer.addSubview(viewBackgroundLoading)
            viewContainer.addSubview(mainContainer)
            activityIndicatorView.startAnimating()
        }else{
            for subview in viewContainer.subviews{
                if subview.tag == 789456123{
                    subview.removeFromSuperview()
                }
            }
        }
        return activityIndicatorView
    }
}

extension UIColor {
    convenience init (hex32: UInt32) {
        let alpha = CGFloat((hex32 >> 24) & 0xff) / 0xff
        let red = CGFloat((hex32 >> 16) & 0xff) / 0xff
        let green = CGFloat((hex32 >> 8) & 0xff) / 0xff
        let blue = CGFloat(hex32 & 0xff) / 0xff
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

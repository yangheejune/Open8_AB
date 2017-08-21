//
//  ExampleViewController.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko
//  Copyright © 2016 Yalantis Mobile. All rights reserved.
//

import UIKit
import Segmentio

class ExampleViewController: UIViewController {
    
    var segmentioStyle = SegmentioStyle.imageOverLabel
    
    @IBOutlet fileprivate weak var segmentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var segmentioView: Segmentio!
    @IBOutlet fileprivate weak var containerView: UIView!
    @IBOutlet fileprivate weak var scrollView: UIScrollView!
    
    fileprivate lazy var viewControllers: [UIViewController] = {
        return self.preparedViewControllers()
    }()
    
    // MARK: - Init
    
    class func create() -> ExampleViewController {
        let board = UIStoryboard(name: "Main", bundle: nil)
        return board.instantiateViewController(withIdentifier: String(describing: self)) as! ExampleViewController
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch segmentioStyle {
        case .onlyLabel, .imageBeforeLabel, .imageAfterLabel:
            segmentViewHeightConstraint.constant = 50
        case .onlyImage:
            segmentViewHeightConstraint.constant = 100
        default:
            break
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupScrollView()
        
        SegmentioBuilder.buildSegmentioView(
            segmentioView: segmentioView,
            segmentioStyle: segmentioStyle
        )
        //SegmentioBuilder.setupBadgeCountForIndex(segmentioView, index: )
        
        segmentioView.selectedSegmentioIndex = selectedSegmentioIndex()
        
        segmentioView.valueDidChange = { [weak self] _, segmentIndex in
            if let scrollViewWidth = self?.scrollView.frame.width {
                let contentOffsetX = scrollViewWidth * CGFloat(segmentIndex)
                self?.scrollView.setContentOffset(
                    CGPoint(x: contentOffsetX, y: 0),
                    animated: true
                )
            }
        }
    }
    
    // Example viewControllers
    
    fileprivate func preparedViewControllers() -> [UIViewController] {
        let HomeController = MainHomeViewController.create()
//        HomeController.disaster = Disaster(
//            cardName: "Home",
//            //hintLabel: Hints.home,
//            hintImage: UIImage(named: "home"),
//            hintNameLabel: "가게 이름",
//            hintGPSLabel: "주소를 적어주면 됨",
//            hintDistanceLabel: "거리를 적어주면됨",
//            hintGoodLabel: "취양수를 적어주면 된다",
//            hintRecommendationLabel: "추천수를 적어주면 된다."
//        )
        
        let
        RestaurantController = RestaurantViewController.create()
//        RestaurantController.disaster = Disaster(
//            cardName: "음식점",
//            //hintLabel: Hints.restaurant,
//            hintImage: UIImage(named: "restaurant"),
//            hintNameLabel: "가게 이름",
//            hintGPSLabel: "주소를 적어주면 됨",
//            hintDistanceLabel: "거리를 적어주면됨",
//            hintGoodLabel: "취양수를 적어주면 된다",
//            hintRecommendationLabel: "추천수를 적어주면 된다."
//        )
        
        let CafeController = CafeViewController.create()
//        CafeController.disaster = Disaster(
//            cardName: "카페",
//            //hintLabel: Hints.cafe,
//            hintImage: UIImage(named: "cafe"),
//            hintNameLabel: "가게 이름",
//            hintGPSLabel: "주소를 적어주면 됨",
//            hintDistanceLabel: "거리를 적어주면됨",
//            hintGoodLabel: "취양수를 적어주면 된다",
//            hintRecommendationLabel: "추천수를 적어주면 된다."
//        )
        
        let BarController = BarViewController.create()
//        BarController.disaster = Disaster(
//            cardName: "술집",
//            //hintLabel: Hints.bar,
//            hintImage: UIImage(named: "bar"),
//            hintNameLabel: "가게 이름",
//            hintGPSLabel: "주소를 적어주면 됨",
//            hintDistanceLabel: "거리를 적어주면됨",
//            hintGoodLabel: "취양수를 적어주면 된다",
//            hintRecommendationLabel: "추천수를 적어주면 된다."
//        )
        
        let HairNailController = HairNailViewController.create()
//        HairNailController.disaster = Disaster(
//            cardName: "헤어네일",
//            //hintLabel: Hints.hairnail,
//            hintImage: UIImage(named: "hairnail"),
//            hintNameLabel: "가게 이름",
//            hintGPSLabel: "주소를 적어주면 됨",
//            hintDistanceLabel: "거리를 적어주면됨",
//            hintGoodLabel: "취양수를 적어주면 된다",
//            hintRecommendationLabel: "추천수를 적어주면 된다."
//        )
        
        let BodyHealthController = BodyHealthViewController.create()
//        BodyHealthController.disaster = Disaster(
//            cardName: "바디헬스",
//            //hintLabel: Hints.bodyhealth,
//            hintImage: UIImage(named: "bodyhealth"),
//            hintNameLabel: "가게 이름",
//            hintGPSLabel: "주소를 적어주면 됨",
//            hintDistanceLabel: "거리를 적어주면됨",
//            hintGoodLabel: "취양수를 적어주면 된다",
//            hintRecommendationLabel: "추천수를 적어주면 된다."
//        )
        
        let FashionACCController = FashionAccViewController.create()
//        FashionACCController.disaster = Disaster(
//            cardName: "패션잡화",
//            //hintLabel: Hints.fashionacc,
//            hintImage: UIImage(named: "fashionacc"),
//            hintNameLabel: "가게 이름",
//            hintGPSLabel: "주소를 적어주면 됨",
//            hintDistanceLabel: "거리를 적어주면됨",
//            hintGoodLabel: "취양수를 적어주면 된다",
//            hintRecommendationLabel: "추천수를 적어주면 된다."
//        )
        
        return [
            HomeController,
            RestaurantController,
            CafeController,
            BarController,
            HairNailController,
            BodyHealthController,
            FashionACCController
        ]
    }
    
    fileprivate func selectedSegmentioIndex() -> Int {
        return 0
    }
    
    // MARK: - Setup container view
    
    fileprivate func setupScrollView() {
        scrollView.contentSize = CGSize(
            width: UIScreen.main.bounds.width * CGFloat(viewControllers.count),
            height: containerView.frame.height
        )
        
        for (index, viewController) in viewControllers.enumerated() {
            viewController.view.frame = CGRect(
                x: UIScreen.main.bounds.width * CGFloat(index),
                y: 0,
                width: scrollView.frame.width,
                height: scrollView.frame.height
            )
            addChildViewController(viewController)
            scrollView.addSubview(viewController.view, options: .useAutoresize) // module's extension
            viewController.didMove(toParentViewController: self)
        }
    }
    
    // MARK: - Actions
    
    fileprivate func goToControllerAtIndex(_ index: Int) {
        segmentioView.selectedSegmentioIndex = index
    }

}

extension ExampleViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = floor(scrollView.contentOffset.x / scrollView.frame.width)
        print("currentPage = \(currentPage)")
        ViewIndex = Int(currentPage)
        segmentioView.selectedSegmentioIndex = Int(currentPage)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 0)
    }
    
}

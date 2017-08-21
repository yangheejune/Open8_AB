//
//  SegmentioBuilder.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko on 11/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Segmentio
import UIKit

struct SegmentioBuilder {
    
    static func setupBadgeCountForIndex(_ segmentioView: Segmentio, index: Int) {
        segmentioView.addBadge(
            at: index,
            count: 10,
            color: ColorPalette.coral
        )
    }
    
    static func buildSegmentioView(segmentioView: Segmentio, segmentioStyle: SegmentioStyle) {
        segmentioView.setup(
            content: segmentioContent(),
            style: segmentioStyle,
            options: segmentioOptions(segmentioStyle: segmentioStyle)
        )
    }
    
    private static func segmentioContent() -> [SegmentioItem] {
        return [
            SegmentioItem(title: "Home", image: UIImage(named: "home")),
            SegmentioItem(title: "음식점", image: UIImage(named: "restaurant")),
            SegmentioItem(title: "카페", image: UIImage(named: "cafe")),
            SegmentioItem(title: "술집", image: UIImage(named: "bar")),
            SegmentioItem(title: "헤어네일", image: UIImage(named: "hairnail")),
            SegmentioItem(title: "바디헬스", image: UIImage(named: "bodyhealth")),
            SegmentioItem(title: "패션잡화", image: UIImage(named: "fashionacc"))
        ]
    }
    
    private static func segmentioOptions(segmentioStyle: SegmentioStyle) -> SegmentioOptions {
        var imageContentMode = UIViewContentMode.center
        switch segmentioStyle {
        case .imageBeforeLabel, .imageAfterLabel:
            imageContentMode = .scaleAspectFit
        default:
            break
        }
        
        return SegmentioOptions(
            backgroundColor: ColorPalette.white,
            maxVisibleItems: 3,
            scrollEnabled: true,
            indicatorOptions: segmentioIndicatorOptions(),
            horizontalSeparatorOptions: segmentioHorizontalSeparatorOptions(),
            verticalSeparatorOptions: segmentioVerticalSeparatorOptions(),
            imageContentMode: imageContentMode,
            labelTextAlignment: .center,
            labelTextNumberOfLines: 1,
            segmentStates: segmentioStates(),
            animationDuration: 0.3
        )
    }
    
    private static func segmentioStates() -> SegmentioStates {
        let font = UIFont.exampleAvenirMedium(ofSize: 13)
        return SegmentioStates(
            defaultState: segmentioState(
                backgroundColor: .clear,
                titleFont: font,
                titleTextColor: ColorPalette.grayChateau
            ),
            selectedState: segmentioState(
                backgroundColor: .cyan,
                titleFont: font,
                titleTextColor: ColorPalette.black
            ),
            highlightedState: segmentioState(
                backgroundColor: ColorPalette.whiteSmoke,
                titleFont: font,
                titleTextColor: ColorPalette.grayChateau
            )
        )
    }
    
    private static func segmentioState(backgroundColor: UIColor, titleFont: UIFont, titleTextColor: UIColor) -> SegmentioState {
        return SegmentioState(
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            titleTextColor: titleTextColor
        )
    }
    
    private static func segmentioIndicatorOptions() -> SegmentioIndicatorOptions {
        return SegmentioIndicatorOptions(
            type: .bottom,
            ratio: 1,
            height: 5,
            color: ColorPalette.coral
        )
    }
    
    private static func segmentioHorizontalSeparatorOptions() -> SegmentioHorizontalSeparatorOptions {
        return SegmentioHorizontalSeparatorOptions(
            type: .topAndBottom,
            height: 1,
            color: ColorPalette.whiteSmoke
        )
    }
    
    private static func segmentioVerticalSeparatorOptions() -> SegmentioVerticalSeparatorOptions {
        return SegmentioVerticalSeparatorOptions(
            ratio: 1,
            color: ColorPalette.whiteSmoke
        )
    }
    
}

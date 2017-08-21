//
//  Disaster.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko
//  Copyright © 2016 Yalantis Mobile. All rights reserved.
//
import UIKit

struct Disaster {
    
    var cardName: String?
    //var hintLabel: [String]?
    var hintImage: UIImage?
    var hintNameLabel: String?
    var hintGPSLabel: String?
    var hintDistanceLabel: String?
    var hintGoodLabel: String?
    var hintRecommendationLabel: String?
    
    
    init(cardName: String?, hintImage: UIImage?,hintNameLabel: String?, hintGPSLabel: String?, hintDistanceLabel: String?, hintGoodLabel: String?, hintRecommendationLabel: String? ) {
        self.cardName = cardName
        //self.hintLabel = hintLabel
        self.hintImage = hintImage
        self.hintNameLabel = hintNameLabel
        self.hintGPSLabel = hintGPSLabel
        self.hintDistanceLabel = hintDistanceLabel
        self.hintGoodLabel = hintGoodLabel
        self.hintRecommendationLabel = hintRecommendationLabel
    }
    
}

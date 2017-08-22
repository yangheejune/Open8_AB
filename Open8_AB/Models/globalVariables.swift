//
//  globalVariables.swift
//  Open8
//
//  Created by 양희준 on 2017. 5. 24..
//  Copyright © 2017년 양희준. All rights reserved.
//

import Foundation

var ViewIndex = Int()
var businness = [BusinnessItem]()       // 전체 업체
var Restaurant = [BusinnessItem]()      // 음식 업체
var HairNail = [BusinnessItem]()        // 헤어네일 업체
var Cafe = [BusinnessItem]()            // 카페 업체
var Bar = [BusinnessItem]()             // 술집 업체
var FashionAcc = [BusinnessItem]()      // 패션악세사리 업체
var BodyHealth = [BusinnessItem]()      // 바디헬스 업체

var glat = Double()                      // 앱의 좌표값
var glng = Double()                      // 앱의 좌표값

let DEFINE_RESTAURANT   = 0
let DEFINE_CAFE         = 1
let DEFINE_BAR          = 2
let DEFINE_HAIRNAIL     = 3
let DEFINE_FASHIONACC   = 4
let DEFINE_BODYHEALTH   = 5
let DEFINE_ALL          = 6


class BusinnessItem {
    var id = String()       // ex) aaa@aaa.co.kr
    var name = String()     // ex) 미즈김 에스테틱 & 스파
    var areaL = String()    // ex) 서울특별시
    var areaM = String()    // ex) 은평구
    var areaS = String()    // ex) 대조동
    var areaD = String()    // ex) 서울특별시 은평구 통일로 739
    var areaD_D = String()  // ex) 오산상가 302호
    var lat = String()      // ex) 좌표
    var lng = String()      // ex) 좌표
    var tel = String()      // ex) 전화번호
    var type = String()
    var typeA = String()
    var typeB = String()
    var imgCnt = String()
    var open = String()     // ex) 문여는 시간(09:00)
    var close = String()    // ex) 문닫는 시간(19:00)
    var day = String()      // ex) 일하는 날짜(월화수목금)
    var state = String()
    var like = String()
    var favorite = String()
    var c1 = String()
    var c2 = String()
    var t1 = String()
    var score = String()

    init(id: String, name: String, areaL: String, areaM: String, areaS: String, areaD: String, areaD_D: String, lat: String, lng: String, tel: String, type: String, typeA: String, typeB: String, imgCnt: String, open: String, close: String, day: String, state: String, like: String, favorite: String, c1: String, c2: String, t1: String, score: String) {
        self.id = id
        self.name = name
        self.areaL = areaL
        self.areaM = areaM
        self.areaS = areaS
        self.areaD = areaD
        self.areaD_D = areaD_D
        self.lat = lat
        self.lng = lng
        self.tel = tel
        self.type = type
        self.typeA = typeA
        self.typeB = typeB
        self.imgCnt = imgCnt
        self.open = open
        self.close = close
        self.day = day
        self.state = state
        self.like = like
        self.favorite = favorite
        self.c1 = c1
        self.c2 = c2
        self.t1 = t1
        self.score = score
    }
}

// 구 삼각법을 기준으로 대원거리(m단위) 요청
func distance(lat1: Double, lng1: Double, lat2: Double, lng2: Double) -> Double {
    
    // 위도,경도를 라디안으로 변환
    let rlat1 = lat1 * M_PI / 180
    let rlng1 = lng1 * M_PI / 180
    let rlat2 = lat2 * M_PI / 180
    let rlng2 = lng2 * M_PI / 180
    
    // 2점의 중심각(라디안) 요청
    let a =
        sin(rlat1) * sin(rlat2) +
            cos(rlat1) * cos(rlat2) *
            cos(rlng1 - rlng2)
    let rr = acos(a)
    
    // 지구 적도 반경(m단위)
    let earth_radius = 6378140.0
    
    // 두 점 사이의 거리 (m단위)
    var distance = earth_radius * rr
    distance = distance / 1000
    
    return distance.roundToPlaces(places: 2)
}

extension Double { /// Rounds the double to decimal places value
    mutating func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
}







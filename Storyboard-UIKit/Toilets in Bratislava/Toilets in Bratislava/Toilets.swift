//
//  Toilets.swift
//  Toilets in Bratislava
//
//  Created by Simon Slamka on 02.07.2021.
//

import Foundation
import GoogleMaps
import SwiftUI
import UIKit

struct Toilet {
    var title: String
    var isAvailable: Bool
    var fee: Float
    var coords: CLLocationCoordinate2D
}

extension Toilet {
    static var toilets = [
        Toilet(title: "Eugen Suchon Square", isAvailable: true, fee: 0.0, coords: CLLocationCoordinate2D(latitude: 48.141, longitude: 17.109)),
        Toilet(title: "Eurovea Shopping Center", isAvailable: true, fee: 0.0, coords: CLLocationCoordinate2D(latitude: 48.140, longitude: 17.121))
    ]
}

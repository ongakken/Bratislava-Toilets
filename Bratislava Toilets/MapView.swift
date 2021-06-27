//
//  MapView.swift
//  Bratislava Toilets
//
//  Created by Simon Slamka on 27.06.2021.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
	@State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.728, longitude: -74), latitudinalMeters: 34, longitudinalMeters: -116
	)
    var body: some View {
		Map(coordinateRegion: $region)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

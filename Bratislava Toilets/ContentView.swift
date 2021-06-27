//
//  ContentView.swift
//  Bratislava Toilets
//
//  Created by Simon Slamka on 26.06.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		VStack(alignment: .leading) {
			Text("Bratislava Toilets").font(.title).fontWeight(.heavy).foregroundColor(Color.blue).multilineTextAlignment(.center).padding()
			HStack {
				Text("Ludovit Stur Square")
					.font(.subheadline)
					.fontWeight(.medium)
			}
		}
		Button("Launch Maps", action: {MapView()})
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			ContentView()
		}
    }
}

//struct MapView: View
//{
//	var body: some View
//	{
//	let camera = GMSCameraPosition.camera(withLatitude: -33, longitude: 130, zoom: 8.0)
//		let mapView = GMSMapView.map(withFrame: MapView.frame, camera: camera)
//		self.view.addSubview(mapView)
//	}
//}

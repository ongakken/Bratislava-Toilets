//
//  ViewController.swift
//  Toilets in Bratislava
//
//  Created by Simon Slamka on 27.06.2021.
//

import UIKit
import SwiftUI
import GoogleMaps
import GoogleMobileAds

class ViewController: UIViewController, GMSMapViewDelegate, GADBannerViewDelegate {
	
	var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        let camera = GMSCameraPosition.camera(withLatitude: 48.141, longitude: 17.109, zoom: 13.5)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.delegate = self
        self.view = mapView
		bannerView.adUnitID = "ca-app-pub-9086446979210331/7085643056"
		bannerView.rootViewController = self
		bannerView.delegate = self
		bannerView.load(GADRequest())
		addBannerViewToView(bannerView)
        //self.view.addSubview(mapView)
        
        // verejne WC namestie Eugena Suchona
        let marker_suchon = GMSMarker()
        marker_suchon.position = CLLocationCoordinate2D(latitude: 48.141, longitude: 17.109)
        marker_suchon.title = "Eugen Suchon Square"
        marker_suchon.snippet = "The Old Town"
        marker_suchon.icon = GMSMarker.markerImage(with: .cyan)
        marker_suchon.map = mapView
        
        // verejne WC Eurovea
        let marker_eurovea = GMSMarker()
        marker_eurovea.position = CLLocationCoordinate2D(latitude: 48.140, longitude: 17.121)
        marker_eurovea.title = "Eurovea Shopping Center"
        marker_eurovea.snippet = "The Old Town"
        marker_eurovea.icon = GMSMarker.markerImage(with: .cyan)
        marker_eurovea.map = mapView
    }
    
    // MARK: GMSMapViewDelegate
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
//        UIApplication.shared.open(URL(string: "https://www.google.com/maps/dir/?api=1&origin=&destination=\(marker.position.latitude),\(marker.position.longitude)&travelmode=walking")!)
		present(euroveaView(), animated: false, completion: nil)
    }
	
	func addBannerViewToView(_ bannerView: GADBannerView) {
		bannerView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(bannerView)
		view.addConstraints([NSLayoutConstraint(item: bannerView,
												attribute: .bottom,
												relatedBy: .equal,
												toItem: view.safeAreaLayoutGuide,
												attribute: .top,
												multiplier: 3.3,
												constant: 0),
							 NSLayoutConstraint(item: bannerView,
												attribute: .centerX,
												relatedBy: .equal,
												toItem: view,
												attribute: .centerX,
												multiplier: 1,
												constant: 0)
		])
	}
}

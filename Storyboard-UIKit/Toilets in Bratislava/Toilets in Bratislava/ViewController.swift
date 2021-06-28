//
//  ViewController.swift
//  Toilets in Bratislava
//
//  Created by Simon Slamka on 27.06.2021.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, GMSMapViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: 48.141, longitude: 17.109, zoom: 13.5)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.delegate = self
        mapView.settings.myLocationButton = true
        self.view = mapView
        //self.view.addSubview(mapView)
        
        // verejne hajzle namestie Eugena Suchona
        let marker_suchon = GMSMarker()
        marker_suchon.position = CLLocationCoordinate2D(latitude: 48.141, longitude: 17.109)
        marker_suchon.title = "Eugen Suchon Square"
        marker_suchon.snippet = "The Old Town"
        marker_suchon.map = mapView
        
        // verejne hajzle Eurovea
        let marker_eurovea = GMSMarker()
        marker_eurovea.position = CLLocationCoordinate2D(latitude: 48.140, longitude: 17.121)
        marker_eurovea.title = "Eurovea Shopping Center"
        marker_eurovea.snippet = "The Old Town"
        marker_eurovea.icon = GMSMarker.markerImage(with: .blue)
        marker_eurovea.map = mapView
    }
    
    // MARK: GMSMapViewDelegate
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        UIApplication.shared.open(URL(string: "https://www.google.com/maps/dir/\(marker.position.latitude),\(marker.position.longitude),16z")!)
    }
}

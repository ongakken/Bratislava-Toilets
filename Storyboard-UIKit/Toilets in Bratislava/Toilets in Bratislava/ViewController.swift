//
//  ViewController.swift
//  Toilets in Bratislava
//
//  Created by Simon Slamka on 27.06.2021.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: 48.141, longitude: 17.109, zoom: 13.5)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)
        
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
        marker_eurovea.map = mapView
    }


}


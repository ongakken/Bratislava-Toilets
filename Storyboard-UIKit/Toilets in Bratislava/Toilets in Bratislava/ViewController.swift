//
//  ViewController.swift
//  Toilets in Bratislava
//
//  Created by Simon Slamka on 27.06.2021.
//

import UIKit
import SwiftUI
import GoogleMaps
import CoreLocation
import GoogleMobileAds

public class toilet: NSObject {
	let name: String
	let coords: CLLocationCoordinate2D
	let usageFee: Float
	let availability: Bool

	init(name: String, coords: CLLocationCoordinate2D, usageFee: Float, availability: Bool) {
		self.name = name
		self.coords = coords
		self.usageFee = usageFee
		self.availability = availability
	}
}

public let toilets = [toilet(name: "Eugen Suchon Square", coords: CLLocationCoordinate2D(latitude: 48.141, longitude: 17.109), usageFee: 0.0, availability: true),
					  toilet(name: "Eurovea Shopping Center", coords: CLLocationCoordinate2D(latitude: 48.140, longitude: 17.121), usageFee: 0.0, availability: true),
					  toilet(name: "Ursulinska Street", coords: CLLocationCoordinate2D(latitude: 48.144, longitude: 17.109), usageFee: 0.3, availability: true),
					  toilet(name: "Most SNP", coords: CLLocationCoordinate2D(latitude: 48.140, longitude: 17.103), usageFee: 0.5, availability: true),
					  toilet(name: "Presidential palace", coords: CLLocationCoordinate2D(latitude: 48.151, longitude: 17.109), usageFee: 0.0, availability: true),
					  toilet(name: "Central Bus Station", coords: CLLocationCoordinate2D(latitude: 48.144, longitude: 17.128), usageFee: 0.0, availability: true),
					  toilet(name: "Trnavske Myto underpass", coords: CLLocationCoordinate2D(latitude: 48.157, longitude: 17.128), usageFee: 0.5, availability: true),
					  toilet(name: "Central Train Station", coords: CLLocationCoordinate2D(latitude: 48.158, longitude: 17.106), usageFee: 0.0, availability: true)]

class ViewController: UIViewController, GMSMapViewDelegate, GADBannerViewDelegate, CLLocationManagerDelegate {
	
	var bannerView: GADBannerView!
	
	let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
		locationManager.delegate = self
		//locationManager.desiredAccuracy = CLLocationAccuracy.
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
		bannerView = GADBannerView(adSize: kGADAdSizeBanner)

		bannerView.adUnitID = "ca-app-pub-9086446979210331/7085643056"
		bannerView.rootViewController = self
		bannerView.delegate = self
		bannerView.load(GADRequest())
    }
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.first else {
			return
		}
		let coordinate = location.coordinate
		let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 15)
		let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
		mapView.delegate = self
		self.view = mapView
		addBannerViewToView(bannerView)
		
		// our current location
		let marker_currentLocation = GMSMarker()
		marker_currentLocation.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
		marker_currentLocation.title = "Your current location"
		marker_currentLocation.icon = GMSMarker.markerImage(with: .systemRed)
		marker_currentLocation.map = mapView
		
		// verejne WC namestie Eugena Suchona
		let marker_suchon = GMSMarker()
		marker_suchon.position = toilets[0].coords
		marker_suchon.title = toilets[0].name
		marker_suchon.snippet = "The Old Town"
		marker_suchon.icon = UIImage(named: "markerImg")
		marker_suchon.map = mapView
		
		// verejne WC Eurovea
		let marker_eurovea = GMSMarker()
		marker_eurovea.position = toilets[1].coords
		marker_eurovea.title = toilets[1].name
		marker_eurovea.snippet = "The Old Town"
		marker_eurovea.icon = UIImage(named: "markerImg")
		marker_eurovea.map = mapView
		
		// verejne WC Ursulinska
		let marker_ursulinska = GMSMarker()
		marker_ursulinska.position = toilets[2].coords
		marker_ursulinska.title = toilets[2].name
		marker_ursulinska.snippet = "The Old Town"
		marker_ursulinska.icon = UIImage(named: "markerImg")
		marker_ursulinska.map = mapView
		
		let delay = 4.0
		DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
			self.locationManager.stopUpdatingLocation()
		}
		
	}
    
    // MARK: GMSMapViewDelegate
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
		
//		let vc = euroveaView()
//		vc.modalPresentationStyle = .automatic
//		vc.toiletName = marker.title
//		present(vc, animated: true, completion: nil)
		let storyboard = UIStoryboard(name: "toiletDetailView", bundle: nil)
		let toiletDetailViewController = storyboard.instantiateViewController(withIdentifier: "toiletDetailView") as! toiletDetailViewController
		toiletDetailViewController.modalPresentationStyle = .automatic
		toiletDetailViewController.toiletName = marker.title
		toiletDetailViewController.toiletID = 11
		toiletDetailViewController.toiletCoords = marker.position
		present(toiletDetailViewController, animated: true, completion: nil)
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

func animImg(for toiletIDNum: Int) -> [UIImage] {
	var i = 0
	var img = [UIImage]()
	
	while let image = UIImage(named: "\(toiletIDNum)\(i)") {
		img.append(image)
		i += 1
	}
	return img
}

class toiletDetailViewController: UIViewController {
	
	var toiletID: Int = 0
	var toiletName: String! = ""
	var toiletFee: Float = 0.0
	var toiletCoords: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
	var toiletIsAvailable: Bool = true
	
	@IBOutlet var toiletNameLabel: UILabel!
	
	@IBOutlet var availableInfo: UILabel!
	
	@IBOutlet var isAvailableLabel: UILabel!
	
	@IBOutlet var feeInfo: UILabel!
	
	@IBOutlet var toiletFeeLabel: UILabel!
	
	@IBOutlet var toiletImageView: UIImageView!
	
	@IBOutlet var toiletNavBtn: UIButton!
	
	@IBAction func onNavBtnTap(_ sender: UIButton) {
		
		UIApplication.shared.open(URL(string: "https://www.google.com/maps/dir/?api=1&origin=&destination=\(toiletCoords.latitude),\(toiletCoords.longitude)&travelmode=walking")!)
		
	}
	
	@IBAction func onDetailCloseBtnTap(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.isOpaque = true
		view.backgroundColor = .darkGray
		feeInfo.textColor = UIColor.white
		availableInfo.textColor = UIColor.white
		if (toiletIsAvailable) {
			isAvailableLabel.text = "Yes"
		} else {
			isAvailableLabel.text = "No"
		}
		toiletNameLabel.translatesAutoresizingMaskIntoConstraints = false
		toiletNameLabel.text = toiletName
		toiletNameLabel.font = UIFont.boldSystemFont(ofSize: 30)
		toiletNameLabel.textColor = UIColor.white
		toiletNameLabel.textAlignment = .center
		isAvailableLabel.textColor = UIColor.white
		isAvailableLabel.font = UIFont.boldSystemFont(ofSize: 20)
		toiletFeeLabel.text = String(describing: toiletFee)
		toiletFeeLabel.font = UIFont.boldSystemFont(ofSize: 20)
		toiletFeeLabel.textColor = UIColor.white
		toiletImageView.animationImages = animImg(for: toiletID)
		toiletImageView.animationDuration = 5
		toiletImageView.animationRepeatCount = 0
		toiletImageView.image = toiletImageView.animationImages?.first
		toiletImageView.layer.cornerRadius = 10.0
		toiletImageView.clipsToBounds = true
		toiletImageView.layer.borderWidth = 1.5
		toiletImageView.layer.borderColor = UIColor .black.cgColor
		toiletNavBtn.backgroundColor = .black
		toiletNavBtn.layer.cornerRadius = 5
		toiletNavBtn.layer.borderWidth = 1
		toiletNavBtn.layer.borderColor = UIColor.black.cgColor
		toiletImageView.startAnimating()
	}
}

//
//  euroveaView.swift
//  Toilets in Bratislava
//
//  Created by Simon Slamka on 28.06.2021.
//

import SwiftUI
import UIKit

class euroveaView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
		let toiletNameLabel = UILabel()
		let toiletImage = UIImage()
		toiletNameLabel.translatesAutoresizingMaskIntoConstraints = false
		toiletNameLabel.textAlignment = .center
		toiletNameLabel.text = "Testing this here"
		toiletNameLabel.font = UIFont.systemFont(ofSize: 30)
		toiletNameLabel.textAlignment = .center
		toiletImage.imageAsset
		view.addSubview(toiletNameLabel)
		
		NSLayoutConstraint.activate([toiletNameLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
									toiletNameLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor,constant: 0),
									])
    }
}

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
        Label("Hajzel 1", systemImage: /*@START_MENU_TOKEN@*/"42.circle"/*@END_MENU_TOKEN@*/)
        Text("Hajzel?").bold()
        Image("Toilet40.png")
    }
}

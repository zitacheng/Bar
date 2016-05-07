//
//  MapView.swift
//  Bar-list
//
//  Created by Zita Cheng on 07/05/2016.
//  Copyright © 2016 Zita Cheng. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapView: UIViewController {
    

    @IBOutlet var mapV: MKMapView!
    let first = FirstViewController.SharedInstance
    
    override func viewDidLoad() {
        
        let span = MKCoordinateSpanMake(0.2, 0.2)
        let location = CLLocationCoordinate2DMake(first.lag, first.long)
        let annotation = MKPointAnnotation()
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapV.setRegion(region, animated: true)
        annotation.coordinate = location
        annotation.title = first.names
        mapV.addAnnotation(annotation)

    }
}
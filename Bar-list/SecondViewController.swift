//
//  SecondViewController.swift
//  Bar-list
//
//  Created by Zita Cheng on 04/05/2016.
//  Copyright © 2016 Zita Cheng. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON
import CoreLocation

class SecondViewController: UIViewController {

    @IBOutlet var Map: MKMapView!
    
    var NumberOfRows = 0
    var idArray = [Int]()
    var NamesArray = [String]()
    var identities = [String]()
    var LatitudeArray = [Double]()
    var LongitudeArray = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
        DisplayPoint()
    }

    func parseJSON() {
        
        let path : String = NSBundle.mainBundle().pathForResource("Pense bete", ofType: "json") as String!
        let jsondata = NSData(contentsOfFile: path) as NSData!

        do {
            let json = try NSJSONSerialization.JSONObjectWithData(jsondata, options: .AllowFragments)
                if let bars = json["bars"] as? [[String: AnyObject]] {
                    for bar in bars {
                        if let name = bar["name"] as? String {
                            NamesArray.append(name)
                        }
                        if let latitude = bar["latitude"] as? Double {
                            LatitudeArray.append(latitude)
                        }
                        if let longitude = bar["longitude"] as? Double {
                            LongitudeArray.append(longitude)
                        }
                    identities.append("A")
                    NumberOfRows += 1
                    }
                }
            } catch {
                print("error serializing JSON: \(error)")
            }
        }

    func DisplayPoint() {
        var i = 0
        while (i < NumberOfRows) {
            let span = MKCoordinateSpanMake(0.2, 0.2)
            let location = CLLocationCoordinate2DMake(LatitudeArray[i], LongitudeArray[i])
            let annotation = MKPointAnnotation()
            let region = MKCoordinateRegion(center: location, span: span)
            
            Map.setRegion(region, animated: true)
            
            annotation.coordinate = location
            annotation.title = NamesArray[i]
            Map.addAnnotation(annotation)
            i += 1
        }
    }

}

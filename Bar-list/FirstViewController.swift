//
//  FirstViewController.swift
//  Bar-list
//
//  Created by Zita Cheng on 04/05/2016.
//  Copyright © 2016 Zita Cheng. All rights reserved.
//

import UIKit
import SwiftyJSON
import Foundation
import CoreLocation
import MapKit

class FirstViewController: UITableViewController {
    
    @IBOutlet var table: UITableView!

    var NumberOfRows = 0
    var idArray = [Int]()
    var NamesArray = [String]()
    var UrlArray = [String]()
    var LatitudeArray = [Double]()
    var LongitudeArray = [Double]()
    var lag: Double = 0.0
    var long: Double = 0.0
    var names: String = "BAR"
    
    static let SharedInstance = FirstViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
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
                    if let url = bar["image_url"] as? String {
                        UrlArray.append(url)
                    }
                    if let latitude = bar["latitude"] as? Double {
                        LatitudeArray.append(latitude)
                    }
                    if let longitude = bar["longitude"] as? Double {
                        LongitudeArray.append(longitude)
                    }
                    NumberOfRows += 1
                }
            }
        } catch {
            print("error serializing JSON: \(error)")
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NamesArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        if NamesArray.count != 0 {
            let url = NSURL(string: UrlArray[indexPath.row])
            let data = NSData(contentsOfURL: url!)
            cell.textLabel?.text = NamesArray[indexPath.row]
            if data != nil {
                let imageURL = UIImage(data:data!)!
                cell.imageView?.image = imageURL
           }
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("A")
        FirstViewController.SharedInstance.lag = LatitudeArray[indexPath.row.self]
        FirstViewController.SharedInstance.long = LongitudeArray[indexPath.row.self]
        FirstViewController.SharedInstance.names = NamesArray[indexPath.row.self]
        self.navigationController?.pushViewController(viewController!, animated: true)
     }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


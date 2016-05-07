//
//  firstlist.swift
//  Bar-list
//
//  Created by Zita Cheng on 05/05/2016.
//  Copyright © 2016 Zita Cheng. All rights reserved.
//

import UIKit
import SwiftyJSON
import Foundation


class TableViewController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    
    var NumberOfRows = 0
    var idArray = [Int]()
    var NamesArray = [String]()
    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        parseJSON()
    }
    
    func parseJSON() {
    
        let path : String = NSBundle.mainBundle().pathForResource("Pense bete", ofType: "json") as String!
        let jsondata = NSData(contentsOfFile: path) as NSData!
        let readableJson = JSON(data: jsondata, options: NSJSONReadingOptions.MutableContainers , error: nil)
    
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(jsondata, options: .AllowFragments)
            if let bars = json["bars"] as? [[String: AnyObject]] {
                for bar in bars {
                    if let name = bar["name"] as? String {
                        NamesArray.append(name)
                        NumberOfRows += 1
                    }
                }
            }
        } catch {
            print("error serializing JSON: \(error)")
        }
        //        print(NamesArray)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("oui")
        return NamesArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("oui2")
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        if NamesArray.count != 0 {
            cell.textLabel?.text = NamesArray[indexPath.row]
        }
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("oui3")
        let vcName =  NamesArray[indexPath.row]
        let viewController = storyboard?.instantiateViewControllerWithIdentifier(vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)
    }

}
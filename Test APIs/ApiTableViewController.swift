//
//  ApiTableViewController.swift
//  Test APIs
//
//  Created by Daniel O'Rorke on 11/16/15.
//  Copyright © 2015 Aerohive Networks. All rights reserved.
//

import UIKit
// import our Cocoa Pods
import Alamofire
import SwiftyJSON

class ApiTableViewController: UITableViewController {
    
    
    // MARK: Variables for API Use
    
    
    
    let clientSecret = "daffa2ecd066ef09da98e4527749dee2"
    let redirectURL = "https://mysite.com"
    let clientID = "19a087a8"
    // CloudVA
    let VA_baseURL = "https://cloud-va.aerohive.com/xapi/"
    let VA_OwnerID = "1265"
    let VA_authToken = "zO3NHJh65L3aWoQdfy7WgRJVcz52x6u5"
    // CloudIE
    let IE_baseURL = "https://cloud-ie.aerohive.com/xapi/"
    let IE_OwnerID = "9885"
    let IE_authToken = "gR8k9hK1fKaYoG49usEIb39AgJqNB4gq"
    
    
    

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        var params : [String:String]
        
        // Try Device Monitoring in USA
        params = [
            "AuthToken": VA_authToken,
            "ownerID": VA_OwnerID,
            "URL": VA_baseURL + "v1/monitor/clients?" + VA_OwnerID,
            "CLIENT-SECRET": clientSecret,
            "CLIENT-ID": clientID,
            "CLIENT-REDIRECT-URI": redirectURL,
            "RDC":"USA",
            "API":"Device Monitor"
        ]
        testAPI(params)
        
        // Try Device Monitoring in EMEA
        params = [
            "AuthToken": IE_authToken,
            "ownerID": IE_OwnerID,
            "URL": IE_baseURL + "v1/monitor/clients?" + IE_OwnerID,
            "CLIENT-SECRET": clientSecret,
            "CLIENT-ID": clientID,
            "CLIENT-REDIRECT-URI": redirectURL,
            "RDC":"EMEA",
            "API":"Device Monitor"
        ]
        testAPI(params)
        
        // Try Client Monitoring in USA
        params = [
            "AuthToken": VA_authToken,
            "ownerID": VA_OwnerID,
            "URL": VA_baseURL + "v1/monitoring/devices?" + VA_OwnerID,
            "CLIENT-SECRET": clientSecret,
            "CLIENT-ID": clientID,
            "CLIENT-REDIRECT-URI": redirectURL,
            "RDC":"USA",
            "API":"Client Monitor"
        ]
        testAPI(params)
        
        // Try Client Monitoring in EMEA
        params = [
            "AuthToken": IE_authToken,
            "ownerID": IE_OwnerID,
            "URL": IE_baseURL + "v1/monitoring/devices?" + IE_OwnerID,
            "CLIENT-SECRET": clientSecret,
            "CLIENT-ID": clientID,
            "CLIENT-REDIRECT-URI": redirectURL,
            "RDC":"EMEA",
            "API":"Client Monitor"
        ]
        testAPI(params)
        
        
    }
    
    func testAPI(params:[String:String]){
        let headers = [
            "Authorization": "Bearer "+params["AuthToken"]!,
            "X-AH-API-CLIENT-SECRET": params["CLIENT-SECRET"]!,
            "X-AH-API-CLIENT-ID": params["CLIENT-ID"]!,
            "X-AH-API-CLIENT-REDIRECT-URI": params["CLIENT-REDIRECT-URI"]!
        ]
        let parameters = ["ownerId": params["ownerID"] as! AnyObject]
        print("Testing "+params["URL"]!)
        Alamofire.request(.GET, params["URL"]!, headers: headers, parameters: parameters)
            .responseJSON { response in
                // Check that the error is nil
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("Error on"+params["URL"]!)
                    print(response.result.error!)
                    print("Headers: ")
                    print(headers)
                    return
                }
                // So far, we only confirmed that we can talk to a server.
                // Now we need to parse the response & make sure the API request was successful.
                if let value: AnyObject = response.result.value {
                    // handle the results as JSON, without a bunch of nested if loops
                    let result = JSON(value)
                    if (result["error"] == nil) { // If there is no error in the JSON returned, our query worked
                        dispatch_async(dispatch_get_main_queue()) { // If using the UI, this is how you get back to the main thread
                        print(params["API"]!+" - "+params["RDC"]!+" - OK!")
                        // Here is where you can add code to do something with the data
                            
                        }
                    }
                    else { // something went wrong!
                        print("Something is wrong with "+params["API"]!+" in "+params["RDC"]!)
                        print("Error "+result["error"]["status"].stringValue+": "+result["error"]["code"].stringValue+"\n")
                    }
                }
        }

    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("apiCell", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

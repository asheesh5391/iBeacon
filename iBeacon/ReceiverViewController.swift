//
//  ReceiverViewController.swift
//  iBeacon
//
//  Created by Asheesh on 14/06/18.
//  Copyright © 2018 Asheesh. All rights reserved.
//

import UIKit
import CoreLocation

class ReceiverViewController: UIViewController {
    @IBOutlet weak var lblStatus: UILabel!
    var locationManager: CLLocationManager?
    var myBeaconRegion: CLBeaconRegion?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.requestWhenInUseAuthorization()
        self.locationManager?.requestAlwaysAuthorization()
        
        //// Create a NSUUID with the same UUID as the broadcasting beacon
        let uuid = UUID(uuidString: "A77A1B68-49A7-4DBF-914C-760D07FBB87B")
        
        // Setup a new region with that UUID and same identifier as the broadcasting beacon
        self.myBeaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: "com.asheesh.iBeacon")
        
        // Tell location manager to start monitoring for the beacon region
        
        self.locationManager?.startMonitoring(for: self.myBeaconRegion!)
        //d
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - CLLocationManagerDelegate
extension ReceiverViewController: CLLocationManagerDelegate {
    
    //The code implements two methods that get triggered when the device enters a region or leaves a region. When a region is entered, we tell locationManager to start looking for beacons in the region.
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        self.locationManager?.startRangingBeacons(in: self.myBeaconRegion!)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        self.locationManager?.startRangingBeacons(in: self.myBeaconRegion!)
        
        self.lblStatus.text = "Beacon not found"
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        self.lblStatus.text = "Beacon found :)"
        
        let beacon = beacons.first
        
        // You can retrieve the beacon data from its properties
//        let uuid = beacon?.proximityUUID
//        let major = beacon?.major
//        let minor = beacon?.minor
        
    }
}


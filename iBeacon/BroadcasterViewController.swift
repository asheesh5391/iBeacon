//
//  BroadcasterViewController.swift
//  iBeacon
//
//  Created by Asheesh on 14/06/18.
//  Copyright © 2018 Asheesh. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class BroadcasterViewController: UIViewController {
    
    @IBOutlet weak var lblStatus: UILabel!
    
    var myBeaconRegion:CLBeaconRegion?
    var myBeaconData = [String: Any]()
    var periperalManager:CBPeripheralManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let uuid = UUID(uuidString: "A77A1B68-49A7-4DBF-914C-760D07FBB87B")
        self.myBeaconRegion = CLBeaconRegion(proximityUUID: uuid!, major: 1, minor: 1, identifier: "com.asheesh.iBeacon")
        
    }
    
    @IBAction func btnBroadcastAction(_ sender: UIButton) {
        // beacon region which will give us the beacon data that we will later use to broadcast
        self.myBeaconData = self.myBeaconRegion?.peripheralData(withMeasuredPower: nil) as! [String : Any]
        
        // Start the peripheral manager, and will start to monitor updates to the status of Bluetooth.
        self.periperalManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
    }
}


// MARK: - CBPeripheralManagerDelegate
extension BroadcasterViewController: CBPeripheralManagerDelegate {
    //Now we have to handle the status update method to detect when Bluetooth is on and off.
    //gets triggered whenever there is a change in the Bluetooth peripheral status
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOn:
            self.lblStatus.text = "Broadcasting..."
            
            //start broadcasting
            self.periperalManager?.startAdvertising(self.myBeaconData)
        case .poweredOff:
            self.lblStatus.text = "Stopped..."
            
            // Bluetooth isn't on. Stop broadcasting
            self.periperalManager?.stopAdvertising()
        case .resetting:
            self.lblStatus.text = "resetting..."
        case .unauthorized:
            self.lblStatus.text = "unauthorized..."
        case .unsupported:
            self.lblStatus.text = "unsupported..."
        case .unknown:
            self.lblStatus.text = "unknown..."
        }
    }
}



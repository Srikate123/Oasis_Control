//
//  QrCodeScannerViewController.swift
//  U-CITY
//
//  Created by JayJay on 2/21/19.
//  Copyright © 2019 semon12694. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase


class QrCodeScannerViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {

   let avCaptureSession = AVCaptureSession()
    
    @IBOutlet weak var videoPreview: UIView!
    
    var stringURL = String()
    
    enum error:Error {
        case noCameraAvailable
        case videoInputInitFail
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try scanQRCode()
        } catch  {
            print("Failed to scan the QrCode.")
        }

   
    }
    
    
    /////setUp Scanner QRCode
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count > 0{
            let machineReadableCode = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            if machineReadableCode.type == AVMetadataObject.ObjectType.qr {
                stringURL = machineReadableCode.stringValue!
               // print("\n\\n\n\(stringURL)\n\n\n")
                
                
                //self.checkDataQRCode(stringURL)
                
                self.performSegue(withIdentifier: "payPage", sender: nil)
                self.avCaptureSession.stopRunning()
            }
        }
    }
    
    func scanQRCode() throws {
        
        guard let avCaptureDevice
            = AVCaptureDevice.default(for: AVMediaType.video) else  {
            print("No Camera.")
            throw error.noCameraAvailable
        }
        guard let avCaptureInput = try? AVCaptureDeviceInput(device: avCaptureDevice) else {
            print("Fail Init Camera.")
            throw error.videoInputInitFail
        }
        let avCaptureMetadataOutput = AVCaptureMetadataOutput()
        avCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        avCaptureSession.addInput(avCaptureInput)
        avCaptureSession.addOutput(avCaptureMetadataOutput)
        
        avCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        let avCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: avCaptureSession)
        avCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avCaptureVideoPreviewLayer.frame = videoPreview.bounds
        self.videoPreview.layer.addSublayer(avCaptureVideoPreviewLayer)
        
        avCaptureSession.startRunning()
        
    }
    
    
    /////check Data QRCode
    
    
   // var postDataArr = [PostData]()
    
    func checkDataQRCode(_ dataQrCode:String){
        let dataValueQrCode = (dataQrCode as NSString).integerValue
        var x = 1
        x = dataValueQrCode
        print("\n\n\n\(x)\n\n\n")
        let databaseRef = Database.database().reference().child("Store").child("Store_KFC")
        databaseRef.observe(DataEventType.value, with: { (Snapshot) in
            if Snapshot.childrenCount>0{
               // self.postDataArr.removeAll()
                
                for Store in Snapshot.children.allObjects as! [DataSnapshot]{
                    let dataStoreObject = Store.value as? [String: AnyObject]
                    let friedChickenData = dataStoreObject?["fried_Chicken"] as! String
                    print("\n\n\n\(friedChickenData)\n\n\n")
//                    let friedChickenDataValue = (friedChickenData as! NSString).integerValue
//                    if(friedChickenDataValue == dataValueQrCode){
//                        self.performSegue(withIdentifier: "payPage", sender: nil)
//                        self.avCaptureSession.stopRunning()
//                    }
//                    else{
//                        print("error")
//                    }
                   
                    
                }
            }
        })
    }
    

    

}

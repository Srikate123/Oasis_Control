//
//  ARPlayGameViewController.swift
//  U-CITY
//
//  Created by JayJay on 1/31/19.
//  Copyright © 2019 semon12694. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ARPlayGameViewController: UIViewController,ARSessionDelegate,ARSCNViewDelegate{
    @IBOutlet weak var sceneView: ARSCNView!
    
    
    private lazy var worldMapStatusLabel :UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
         self.sceneView.session.delegate = self
         let scene = SCNScene()
         sceneView.scene = scene
         sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,ARSCNDebugOptions.showWorldOrigin]
         setupUI()
         restoreWorldMap()
        
    }
    private func restoreWorldMap() {
        
        let userDefaults = UserDefaults.standard
        
        if let data = userDefaults.data(forKey: "box") {
            
            if let unarchived = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [ARWorldMap.classForKeyedUnarchiver()], from: data),
                let worldMap = unarchived as? ARWorldMap {
                
                
                
                let configuration = ARWorldTrackingConfiguration()
                configuration.initialWorldMap = worldMap
                configuration.planeDetection = .horizontal
                
                sceneView.session.run(configuration)
                print("restore succeed")
                
                
            }
            
        }
     else {
    let configuration = ARWorldTrackingConfiguration()
    configuration.planeDetection = .horizontal
    sceneView.session.run(configuration)
    print("can not restore")
    }
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        
        switch frame.worldMappingStatus {
        case .notAvailable:
            self.worldMapStatusLabel.text = "NOT AVAILABLE"
        case .limited:
            self.worldMapStatusLabel.text = "LIMITED"
        case .extending:
            self.worldMapStatusLabel.text = "EXTENDING"
        case .mapped:
            self.worldMapStatusLabel.text = "MAPPED"
        }
        
    }
    private func setupUI() {
        
        self.view.addSubview(self.worldMapStatusLabel)
      
        
        //add constraints to label
        self.worldMapStatusLabel.topAnchor.constraint(equalTo: self.sceneView.topAnchor, constant: 20).isActive = true
        self.worldMapStatusLabel.rightAnchor.constraint(equalTo: self.sceneView.rightAnchor, constant: -20).isActive = true
        self.worldMapStatusLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
       
        
    }
    
    
}

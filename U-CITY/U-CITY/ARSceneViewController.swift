//
//  ARSceneViewController.swift
//  U-CITY
//
//  Created by JayJay on 1/23/19.
//  Copyright © 2019 semon12694. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
import FirebaseStorage
import AVFoundation

class ARSceneViewController: UIViewController,ARSCNViewDelegate, UICollectionViewDataSource , UICollectionViewDelegate,ARSessionDelegate  {
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var PlandDetected: UILabel!
    @IBOutlet weak var playGame: UIButton!
    @IBOutlet weak var sceneView: ARSCNView!
    let itemsArray: [String] = ["boxing", "treasure", "item3", "item4"]
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    var selectedItem: String?
    var Target:SCNNode!
    var TargetModel:SCNNode!
    var touchScene:SCNView!
    let configuration = ARWorldTrackingConfiguration()
    var audioPlayer = AVAudioPlayer()
    
    
    private lazy var worldMapStatusLabel :UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var saveWorldMapButton :UIButton = {
        
        let button = UIButton(type: .custom)
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor(red: 53/255, green: 73/255, blue: 94/255, alpha: 1)
        button.addTarget(self, action: #selector(saveWorldMap), for: .touchUpInside)
        return button
        
    }()
    
    @objc func saveWorldMap() {
        
        self.sceneView.session.getCurrentWorldMap { worldMap, error in
            
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            
            if let map = worldMap {
                
                let data = try! NSKeyedArchiver.archivedData(withRootObject: map, requiringSecureCoding: true)
                
                // save in user defaults
                let userDefaults = UserDefaults.standard
                userDefaults.set(data, forKey: "box")
                userDefaults.synchronize()
                print("save succeed")
//                self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//                self.hud.label.text = "World Map Saved!"
//                self.hud.hide(animated: true, afterDelay: 2.0)
            }
            
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
        self.view.addSubview(self.saveWorldMapButton)
        
        //add constraints to label
        self.worldMapStatusLabel.topAnchor.constraint(equalTo: self.sceneView.topAnchor, constant: 20).isActive = true
        self.worldMapStatusLabel.rightAnchor.constraint(equalTo: self.sceneView.rightAnchor, constant: -20).isActive = true
        self.worldMapStatusLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        // add constraints to save world map button
        self.saveWorldMapButton.centerXAnchor.constraint(equalTo: self.sceneView.centerXAnchor).isActive = true
        self.saveWorldMapButton.bottomAnchor.constraint(equalTo: self.sceneView.bottomAnchor, constant: -210).isActive = true
        self.saveWorldMapButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.saveWorldMapButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
    }
    private func restoreWorldMap() {
        
        let userDefaults = UserDefaults.standard
        
        if let data = userDefaults.data(forKey: "box") {
            
            if let unarchived = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [ARWorldMap.classForKeyedUnarchiver()], from: data),
                let worldMap = unarchived as? ARWorldMap {
                
                
                
             
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
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
           restoreWorldMap()
        
    }
    
    
    
    
    
    
    
    
    
    
    
  
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view's delegate
        self.sceneView.autoenablesDefaultLighting = true
        sceneView.delegate = self
      
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        // Show statistics such as fps and timing information แสดงข้อมูลเวลา
        sceneView.showsStatistics = true
        // Create a new scene
        configuration.planeDetection = .horizontal
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        // sceneView.session.run(configuration)
        self.itemsCollectionView.dataSource = self
        self.itemsCollectionView.delegate = self
        registerGestureRecognizers()
     
         self.sceneView.session.delegate = self
         setupUI()

         addSound()
         audioPlayer.play()
       
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //ทำงานทันทีเมื่อตรวจจับเจอพื้นที่
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        print("444")
        PlandDetected.isHidden = false
        
        
       
        //1
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        // 2 กำหนดขนาดโดยวัดตามพื้นผิวที่ตรวจพบบนโลกจริง
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)
        
        // 3
        plane.materials.first?.diffuse.contents = UIImage(named: "rbd-1")
        
        // 4
        let planeNode = SCNNode(geometry: plane)
        
        // 5
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x,y,z)
        planeNode.eulerAngles.x = -.pi / 2
        node.addChildNode(planeNode)
        Target = node
        /////
        let box = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)

        let material = SCNMaterial()
        material.diffuse.contents = UIColor.purple

        box.materials = [material]

        let boxNode = SCNNode(geometry: box)
        node.addChildNode(boxNode)
       
        
        
    
        
    }
    //reset sceneView
    @IBAction func reset(_ sender: Any) {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    // setting collecttionViewCell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! itemCell
        cell.itemLabel.text = self.itemsArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        self.selectedItem = itemsArray[indexPath.row]
        cell?.backgroundColor = UIColor.green
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.orange
    }
    
    func registerGestureRecognizers() {
        
        //add model
        let tapGestureRecognizer = UITapGestureRecognizer(target:self,action: #selector(tapped))
        //Zoom model
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
        //หมุน model
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(rotate))
        self.sceneView.addGestureRecognizer(longPressGestureRecognizer)
        self.sceneView.addGestureRecognizer(pinchGestureRecognizer)
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    //สิ่งที่จะทำเมื่อทัชหน้าจอ
    @objc func tapped(sender: UITapGestureRecognizer) {
        print("333")
       

//        let sceneView = sender.view as! ARSCNView
          let tapLocation = sender.location(in: sceneView)
          let hitTest = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        guard let sceneView = sender.view as? ARSCNView else {
            return
        }
        
       let touch = sender.location(in: sceneView)
       
        
        
        let hitTestResults = sceneView.hitTest(touch, types: .existingPlane)
        
        if !hitTestResults.isEmpty {
                self.addItem(hitTestResult: hitTest.first!)
            
           
            
        }
    }
    //add item
    func addItem(hitTestResult: ARHitTestResult) {
        
        if let selectedItem = self.selectedItem {
            let scene = SCNScene(named: "Models.scnassets/\(selectedItem).scn")
            let node = (scene?.rootNode.childNode(withName: selectedItem, recursively: false))!
            let transform = hitTestResult.worldTransform
            let thirdColumn = transform.columns.3
            node.position = SCNVector3(thirdColumn.x, thirdColumn.y, thirdColumn.z)
            self.sceneView.scene.rootNode.addChildNode(node)
            self.Target.removeFromParentNode()
            TargetModel = node
            let boxAnchor = ARAnchor(name: "box-anchor", transform: hitTestResult.worldTransform)
            self.sceneView.session.add(anchor: boxAnchor)

        }
    }
    @IBAction func playGame(_ sender: Any) {
        let tappedActionPlayGame = UITapGestureRecognizer(target: self, action: #selector(tappedNode))
        self.sceneView.addGestureRecognizer(tappedActionPlayGame)
        self.PlandDetected.isHidden = true
        self.itemsCollectionView.isHidden = true
        self.saveWorldMapButton.isHidden = true
        self.worldMapStatusLabel.isHidden = true
        self.resetBtn.isHidden = true
        self.playGame.isHidden = true
    }
    @objc func tappedNode(sender: UITapGestureRecognizer){
        self.TargetModel.removeFromParentNode()
        let sceneView = sender.view as! ARSCNView
        let touch = sender.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(touch, types: .existingPlaneUsingExtent)
        if !hitTestResults.isEmpty {
            self.addEffect(hitTestResult: hitTestResults.first!)
        }
    }
    func addEffect(hitTestResult: ARHitTestResult) {
        let confetti = SCNParticleSystem(named: "Models.scnassets/Reactor.scnp", inDirectory: nil)
        confetti?.loops = false
        confetti?.particleLifeSpan = 0.1
        confetti?.emitterShape = TargetModel?.geometry
        let confettiNode = SCNNode()
        confettiNode.addParticleSystem(confetti!)
        let transform = hitTestResult.worldTransform
        let thirdColumn = transform.columns.3
        confettiNode.position = SCNVector3(thirdColumn.x, thirdColumn.y, thirdColumn.z)
        self.sceneView.scene.rootNode.addChildNode(confettiNode)
        let scene = SCNScene(named: "Models.scnassets/key.scn")
        TargetModel = (scene?.rootNode.childNode(withName: "key", recursively: false))!
        TargetModel.position = confettiNode.position
        self.sceneView.scene.rootNode.addChildNode(confettiNode)
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 2) //สร้างอนิเมชั่นให้กับโหนด หมุนอัตโนมัติ
        let forever = SCNAction.repeatForever(action)
        TargetModel.runAction(forever)
        self.sceneView.scene.rootNode.addChildNode(TargetModel)
}
    
    
    //Zoom in ZOom out ItemModel
    @objc func pinch(sender: UIPinchGestureRecognizer){
        let sceneView = sender.view as! ARSCNView
        let pinchLocation = sender.location(in: sceneView)
        let hitTest = sceneView.hitTest(pinchLocation)
        if !hitTest.isEmpty{
            let results = hitTest.first!
            let node = results.node
            let pinchAction = SCNAction.scale(by: sender.scale, duration: 0)
            print(sender.scale)
            node.runAction(pinchAction)
            sender.scale = 1.0
        }
    }
    //หมุน Model
    @objc func rotate(sender: UILongPressGestureRecognizer) {
        let sceneView = sender.view as! ARSCNView
        let holdLocation = sender.location(in: sceneView)
        let hitTest = sceneView.hitTest(holdLocation)
        if !hitTest.isEmpty {
            
            let result = hitTest.first!
            if sender.state == .began {
                let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 1)
                let forever = SCNAction.repeatForever(rotation)
                result.node.runAction(forever)
            } else if sender.state == .ended {
                result.node.removeAllActions()
            }
        }
        
        
    }
    
    func addSound(){
        let sound = Bundle.main.path(forResource: "sound", ofType: "mp4")
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            audioPlayer.prepareToPlay()
            
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default,options: [AVAudioSession.CategoryOptions.mixWithOthers])
        }
        catch {
            print(error)
        }
    }
    
    
   
   
    }
    
    
    
    
    
    
    
    

extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/180}
}
extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}

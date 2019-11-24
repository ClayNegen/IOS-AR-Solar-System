//
//  ViewController.swift
//  IOS-AR-app
//
//  Created by Xcode User on 11/24/19.
//  Copyright © 2019 GVSU.CIS. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
        
    let baseNode = SCNNode()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        let sun = createPlanet(radius: 0.25, image: "sun")
        sun.position = SCNVector3(x:0,y:0,z:0)
        rotateObject(rotation: -0.3, planet: sun, duration: 1)
        
        let mercuryRing = createRing(ringSize: 0.3)
        let mercury = createPlanet(radius: 0.03, image: "mercury")
        mercury.position = SCNVector3(x: 0.3 ,y: 0, z: 0)
        rotateObject(rotation: 0.6, planet: mercury, duration: 0.4)
        rotateObject(rotation: 0.6, planet: mercuryRing, duration: 1)
        
        let venusRing = createRing(ringSize: 0.5)
        let venus = createPlanet(radius: 0.04, image: "venus")
        venus.position = SCNVector3(x:0.5 , y: 0, z: 0)
        rotateObject(rotation: 0.4, planet: venus, duration: 0.4)
        rotateObject(rotation: 0.4, planet: venusRing, duration: 1)
        
        let earthRing = createRing(ringSize: 0.7)
        let earth = createPlanet(radius: 0.05, image: "earth")
        earth.position = SCNVector3(x:0.7 , y: 0, z: 0)
        rotateObject(rotation: 0.25, planet: earth, duration: 0.4)
        rotateObject(rotation: 0.25, planet: earthRing, duration: 1)
        
        
        let marsRing = createRing(ringSize: 0.9)
        let mars = createPlanet(radius: 0.03, image: "mars")
        mars.position = SCNVector3(x:0.9 , y: 0, z: 0)
        rotateObject(rotation: 0.2, planet: mars, duration: 0.4)
        rotateObject(rotation: 0.2, planet: marsRing, duration: 1)
        
        mercuryRing.addChildNode(mercury)
        venusRing.addChildNode(venus)
        earthRing.addChildNode(earth)
        marsRing.addChildNode(mars)
        
        baseNode.addChildNode(sun)
        baseNode.addChildNode(mercuryRing)
        baseNode.addChildNode(venusRing)
        baseNode.addChildNode(earthRing)
        baseNode.addChildNode(marsRing)
        
        baseNode.position = SCNVector3(x: 0 ,y: -0.5 ,z: -1)
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        sceneView.scene.rootNode.addChildNode(baseNode)
    }
    
    func createPlanet(radius: Float, image: String) -> SCNNode{
        let planet = SCNSphere(radius: CGFloat(radius))
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "\(image).jpg")
        planet.materials = [material]
    
        let planetNode = SCNNode(geometry: planet)
        
        
        return planetNode
    }
    
    func rotateObject(rotation: Float, planet: SCNNode, duration: Float){
        let rotation = SCNAction.rotateBy(x:0,y:CGFloat(rotation),z:0, duration: TimeInterval(duration))
        planet.runAction(SCNAction.repeatForever(rotation))
    }
    
    func createRing(ringSize: Float) -> SCNNode {
        
        let ring = SCNTorus(ringRadius: CGFloat(ringSize), pipeRadius: 0.002)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.darkGray
        
        ring.materials = [material]
        
        let ringNode = SCNNode(geometry: ring)
        
        return ringNode
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

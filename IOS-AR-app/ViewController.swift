//
//  ViewController.swift
//  IOS-AR-app
//
//  Created by Xcode User on 11/24/19.
//  Copyright © 2019 GVSU.CIS. All rights reserved.
//

//TODO:
// Add Details of planets when clicked on
// Add Saturns ring when zoomed
// Add moons to full scale and zoomed versions
// Add lighting effects coming from sun
// Refactor into more modular code 

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
        
    let baseNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearScreen()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        // sceneView.showsStatistics = true
    
        let sun = createPlanet(radius: 0.25, image: "sun")
        sun.name = "sun"
        sun.position = SCNVector3(x:0, y:0, z:0)
        rotateObject(rotation: -0.3, planet: sun, duration: 1)
        
        let mercuryRing = createRing(ringSize: 0.3)
        let mercury = createPlanet(radius: 0.03, image: "mercury")
        mercury.name = "mercury"
        mercury.position = SCNVector3(x: 0.3 ,y: 0, z: 0)
        rotateObject(rotation: 0.6, planet: mercury, duration: 0.4)
        rotateObject(rotation: 0.6, planet: mercuryRing, duration: 1)
        
        let venusRing = createRing(ringSize: 0.5)
        let venus = createPlanet(radius: 0.04, image: "venus")
        venus.name = "venus"
        venus.position = SCNVector3(x:0.5 , y: 0, z: 0)
        rotateObject(rotation: 0.4, planet: venus, duration: 0.4)
        rotateObject(rotation: 0.4, planet: venusRing, duration: 1)
        
        let earthRing = createRing(ringSize: 0.7)
        let earth = createPlanet(radius: 0.05, image: "earth")
        earth.name = "earth"
        earth.position = SCNVector3(x:0.7 , y: 0, z: 0)
        rotateObject(rotation: 0.25, planet: earth, duration: 0.4)
        rotateObject(rotation: 0.25, planet: earthRing, duration: 1)
        
        let marsRing = createRing(ringSize: 0.8)
        let mars = createPlanet(radius: 0.03, image: "mars")
        mars.name = "mars"
        mars.position = SCNVector3(x:0.8 , y: 0, z: 0)
        rotateObject(rotation: 0.2, planet: mars, duration: 0.4)
        rotateObject(rotation: 0.2, planet: marsRing, duration: 1)
        
        let jupiterRing = createRing(ringSize: 1.0)
        let jupiter = createPlanet(radius: 0.03, image: "jupiter")
        jupiter.name = "jupiter"
        jupiter.position = SCNVector3(x:1.0 , y: 0, z: 0)
        rotateObject(rotation: 0.15, planet: jupiter, duration: 0.4)
        rotateObject(rotation: 0.15, planet: jupiterRing, duration: 1)
        
        let saturnRing = createRing(ringSize: 1.2)
        let saturn = createPlanet(radius: 0.03, image: "saturn")
        saturn.name = "saturn"
        saturn.position = SCNVector3(x:1.2 , y: 0, z: 0)
        rotateObject(rotation: 0.1, planet: saturn, duration: 0.4)
        rotateObject(rotation: 0.1, planet: saturnRing, duration: 1)
        
        let saturnLoop = SCNBox(width: 0.125, height: 0, length: 0.125, chamferRadius: 0)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named:"saturnring.jpg")
        saturnLoop.materials = [material]
        
        let loopNode = SCNNode(geometry: saturnLoop)
        loopNode.position = SCNVector3(x:0,y:0,z:0)
        
        let uranusRing = createRing(ringSize: 1.4)
        let uranus = createPlanet(radius: 0.03, image: "uranus")
        uranus.name = "uranus"
        uranus.position = SCNVector3(x:1.4, y: 0, z: 0)
        rotateObject(rotation: 0.05, planet: uranus, duration: 0.4)
        rotateObject(rotation: 0.05, planet: uranusRing, duration: 1)
        
        let neptuneRing = createRing(ringSize: 1.6)
        let neptune = createPlanet(radius: 0.03, image: "neptune")
        neptune.name = "neptune"
        neptune.position = SCNVector3(x:1.6 , y: 0, z: 0)
        rotateObject(rotation: 0.01, planet: neptune, duration: 0.4)
        rotateObject(rotation: 0.01, planet: neptuneRing, duration: 1)
        
        let plutoRing = createRing(ringSize: 1.7)
        let pluto = createPlanet(radius: 0.03, image: "pluto")
        pluto.name = "pluto"
        pluto.position = SCNVector3(x:1.7 , y: 0, z: 0)
        rotateObject(rotation: 0.005, planet: pluto, duration: 0.4)
        rotateObject(rotation: 0.005, planet: plutoRing, duration: 1)
        
        
        let moon = createPlanet(radius: 0.01, image: "moon")
        moon.name = "moon"
        let moonRing = SCNTorus(ringRadius: 0.08, pipeRadius: 0.00001)
        let moonRingNode = SCNNode(geometry: moonRing)
        
        moon.position = SCNVector3(x:0.08 , y: 0, z: 0)
        moonRingNode.position = SCNVector3(x:0.0 , y: 0.02, z: 0)
        
        moonRingNode.addChildNode(moon)
        mercuryRing.addChildNode(mercury)
        venusRing.addChildNode(venus)
        earthRing.addChildNode(earth)
        earth.addChildNode(moonRingNode)
        marsRing.addChildNode(mars)
        jupiterRing.addChildNode(jupiter)
        saturnRing.addChildNode(saturn)
        saturn.addChildNode(loopNode)
        uranusRing.addChildNode(uranus)
        neptuneRing.addChildNode(neptune)
        plutoRing.addChildNode(pluto)
        
        baseNode.addChildNode(sun)
        baseNode.addChildNode(mercuryRing)
        baseNode.addChildNode(venusRing)
        baseNode.addChildNode(earthRing)
        baseNode.addChildNode(marsRing)
        baseNode.addChildNode(jupiterRing)
        baseNode.addChildNode(saturnRing)
        baseNode.addChildNode(uranusRing)
        baseNode.addChildNode(neptuneRing)
        baseNode.addChildNode(plutoRing)
        
        baseNode.position = SCNVector3(x: 0 ,y: -0.5 ,z: -1)
        
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.scene.rootNode.addChildNode(baseNode)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(checkNodeHit(_:)))
        tapGesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func checkNodeHit(_ gesture: UITapGestureRecognizer){

        let currentTouchLocation = gesture.location(in: self.sceneView)

        guard let hitTestNode = self.sceneView.hitTest(currentTouchLocation, options: nil).first?.node else { return }
        
        switch hitTestNode.name {
        case "sun" :
            
            self.clearScreen()
            
            let sun = createPlanet(radius: 0.40, image: "sun")
            sun.name = "zoom"
            sun.position = SCNVector3(x:0, y:0, z:0)
            rotateObject(rotation: -0.3, planet: sun, duration: 1)
            
            self.addToScreen(node: sun)
            
        case "mercury":
            self.clearScreen()
            
            let mercury = createPlanet(radius: 0.40, image: "mercury")
            mercury.name = "zoom"
            mercury.position = SCNVector3(x: 0.0 ,y: 0, z: 0)
            rotateObject(rotation: 0.3, planet: mercury, duration: 1)
            
            self.addToScreen(node: mercury)
            
        case "venus":
            self.clearScreen()
            
            let venus = createPlanet(radius: 0.40, image: "venus")
            venus.name = "zoom"
            venus.position = SCNVector3(x: 0.0 ,y: 0, z: 0)
            rotateObject(rotation: 0.3, planet: venus, duration: 1)
            
            self.addToScreen(node: venus)
        case "earth":
            self.clearScreen()
            
            let earth = createPlanet(radius: 0.40, image: "earth")
            earth.name = "zoom"
            earth.position = SCNVector3(x: 0.0 ,y: 0, z: 0)
            rotateObject(rotation: 0.3, planet: earth, duration: 1)
            
            self.addToScreen(node: earth)
        case "mars":
            self.clearScreen()
            
            let mars = createPlanet(radius: 0.40, image: "mars")
            mars.name = "zoom"
            mars.position = SCNVector3(x: 0.0 ,y: 0, z: 0)
            rotateObject(rotation: 0.3, planet: mars, duration: 1)
            
            self.addToScreen(node: mars)
         case "jupiter":
            self.clearScreen()
            
            let jupiter = createPlanet(radius: 0.40, image: "jupiter")
            jupiter.name = "zoom"
            jupiter.position = SCNVector3(x: 0.0 ,y: 0, z: 0)
            rotateObject(rotation: 0.3, planet: jupiter, duration: 1)
            
            self.addToScreen(node: jupiter)
        case "saturn":
            self.clearScreen()
            
            let saturn = createPlanet(radius: 0.40, image: "saturn")
            saturn.name = "zoom"
            saturn.position = SCNVector3(x: 0.0 ,y: 0, z: 0)
            rotateObject(rotation: 0.3, planet: saturn, duration: 1)
            
            self.addToScreen(node: saturn)
        case "uranus":
            self.clearScreen()
            
            let uranus = createPlanet(radius: 0.40, image: "uranus")
            uranus.name = "zoom"
            uranus.position = SCNVector3(x: 0.0 ,y: 0, z: 0)
            rotateObject(rotation: 0.3, planet: uranus, duration: 1)
            
            self.addToScreen(node: uranus)
        case "neptune":
            self.clearScreen()
            
            let neptune = createPlanet(radius: 0.40, image: "neptune")
            neptune.name = "zoom"
            neptune.position = SCNVector3(x: 0.0 ,y: 0, z: 0)
            rotateObject(rotation: 0.3, planet: neptune, duration: 1)
            
            self.addToScreen(node: neptune)
        case "pluto":
            self.clearScreen()
            
            let pluto = createPlanet(radius: 0.40, image: "pluto")
            pluto.name = "zoom"
            pluto.position = SCNVector3(x: 0.0 ,y: 0, z: 0)
            rotateObject(rotation: 0.3, planet: pluto, duration: 1)
            
            self.addToScreen(node: pluto)
        case "zoom":
                self.viewDidLoad()
        default:
            print("no")
        }
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
    
    func clearScreen(){
        sceneView.scene.rootNode.enumerateChildNodes {
            (node, stop) in node.removeFromParentNode()
        }
    }
    
    func addToScreen(node: SCNNode){
        baseNode.addChildNode(node)
        
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.scene.rootNode.addChildNode(baseNode)
    }
}

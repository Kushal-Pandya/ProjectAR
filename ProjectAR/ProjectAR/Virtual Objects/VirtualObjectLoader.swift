//
//  VirtualObjectLoader.swift
//  ProjectAR
//
//  Created by MICHAEL on 2019-03-13.
//  Copyright © 2019 Kushal Pandya. All rights reserved.
//

import Foundation
import ARKit

class VirtualObjectLoader {
    private(set) var loadedObjects = [VirtualObject]()
    
    // Loads the virtual object's scene from the reference node
    func loadVirtualObject(_ object: VirtualObject) {
        loadedObjects.append(object)
        object.load()
        
        // Attaches the painted image onto the paintedImage plane
        guard let paintingNode = object.childNode(withName: "PaintedImage", recursively: true) else {
            return
        }
        paintingNode.geometry?.firstMaterial?.diffuse.contents = object.paintedImage
    }
    
    func removeVirtualObject(at index: Int) {
        guard loadedObjects.indices.contains(index) else { return }
        
        loadedObjects[index].removeFromParentNode()
        loadedObjects.remove(at: index)
    }
    
    func removeAllVirtualObject() {
        // Reverse the list of indicies to avoid skipping objects others are removed
        for index in loadedObjects.indices.reversed() {
            removeVirtualObject(at: index)
        }
    }
}

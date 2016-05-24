//
//  Cube.swift
//  iPadGame
//
//  Created by Andrew Clear on 5/24/16.
//  Copyright © 2016 Andrew Clear. All rights reserved.
//

import Foundation
import simd

class Cube:RenderableObject
{
    override init()
    {
        super.init()
        
        CreateColorData()
        CreateVertexData()
    }
    
    override func CreateColorData()
    {
        colorData =
        [
            1.0, 0.0, 0.0, 1.0,     1.0, 0.0, 0.0, 1.0,     1.0, 0.0, 0.0, 1.0,
            0.0, 1.0, 0.0, 1.0,     0.0, 1.0, 0.0, 1.0,     0.0, 1.0, 0.0, 1.0,
            
            1.0, 0.0, 1.0, 1.0,     1.0, 0.0, 1.0, 1.0,     1.0, 0.0, 1.0, 1.0,
            0.0, 1.0, 1.0, 1.0,     0.0, 1.0, 1.0, 1.0,     0.0, 1.0, 1.0, 1.0,
        ]
        
    }
    
    override func CreateVertexData()
    {
        vertices =
        [
            //Front
            -0.5, -0.5, 1.0, 1.0,   -0.5, 0.5, 1.0, 1.0,    0.5, -0.5, 1.0, 1.0,
            -0.5, 0.5, 1.0, 1.0,    0.5,  0.5, 1.0, 1.0,    0.5, -0.5, 1.0, 1.0,
            
            //Right
            0.5, -0.5, 1.0, 1.0,    0.5, 0.5, 1.0, 1.0,     0.5, -0.5, -1.0, 1.0,
            0.5, 0.5, 1.0, 1.0,     0.5, 0.5, -1.0, 1.0,    0.5, -0.5, -1.0, 1.0,
        ]
    }
    
}
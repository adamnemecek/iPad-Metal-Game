//
//  Camera.swift
//  iPadGame
//
//  Created by Andrew Clear on 5/24/16.
//  Copyright © 2016 Andrew Clear. All rights reserved.
//

import Foundation
import simd

class Camera : BaseObject
{
    var viewMatrix:float4x4
    var projectionMatrix:float4x4
    var worldMatrix:float4x4
    
    override init()
    {
        viewMatrix = float4x4.Clear()
        projectionMatrix = float4x4.Clear()
        worldMatrix = float4x4.Clear()
    }
}
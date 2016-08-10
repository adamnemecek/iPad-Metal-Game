//
//  VertexDefinitions.swift
//  iPadGame
//
//  Created by Andrew Clear on 8/8/16.
//  Copyright © 2016 Andrew Clear. All rights reserved.
//

import Foundation
import simd

struct Vertex_PositionNormalColor
{
    var position: vector_float3
    var color: vector_float4
    var normal: vector_float3
    
    init()
    {
        position = vector_float3(0,0,0)
        normal = vector_float3(0,0,0)
        color = vector_float4(0,0,0,0)
    }
    
    func ConvertToFloatArray() -> [Float]
    {
        return [position.x, position.y, position.z,
                color.x, color.y, color.z, color.w,
                normal.x, normal.y, normal.z]
    }
    
    //func GetSize() -> Int
    //{
    //    return sizeof(position) + sizeof(color) + sizeof(normal)
    //}
}
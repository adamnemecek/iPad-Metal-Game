//
//  MathHelpers.swift
//  iPadGame
//
//  Created by Andrew Clear on 8/9/16.
//  Copyright © 2016 Andrew Clear. All rights reserved.
//

import Foundation

import simd

func degrees_from_radians(radians:Float) -> Float
{
    return (radians / Float(M_PI)) * 180;
}

func radians_from_degrees(degrees:Float) -> Float
{
    return (degrees / 180) * Float(M_PI)
}

func matrix_perspective(fovyRadians:Float, aspectRatio:Float, nearZ:Float, farZ:Float) -> matrix_float4x4
{
    let ys:Float = 1 / tanf(fovyRadians * 0.5)
    let xs:Float = ys / aspectRatio
    let zs:Float = farZ / (nearZ - farZ)

    let matrix:matrix_float4x4 = matrix_from_columns([xs, 0.0, 0.0, 0.0],
                                  [0.0, ys, 0.0, 0.0],
                                  [0.0, 0.0, zs, -1.0],
                                  [0.0, 0.0, zs * nearZ, 0.0])
    
    return matrix
    
}

func matrix_look_at(eyeX:Float, eyeY:Float, eyeZ:Float, centerX:Float, centerY:Float, centerZ:Float,
                    upX:Float, upY:Float, upZ:Float) -> matrix_float4x4
{
    let eye = vector_float3(eyeX, eyeY, eyeZ)
    let center = vector_float3(centerX, centerY, centerZ)
    let up = vector_float3(upX, upY, upZ)
    
    let z = vector_normalize(eye - center)
    let x = vector_normalize(vector_cross(up, z))
    let y = vector_cross(z, x)
    let t = vector_float3(-vector_dot(x, eye), -vector_dot(y, eye), -vector_dot(z, eye))
    
    let matrix:matrix_float4x4 = matrix_from_columns([x.x, y.x, z.x, 0],
                                                  [x.y, y.y, z.y, 0],
                                                  [x.z, y.z, z.z, 0],
                                                  [t.x, t.y, t.z, 1])
    
    return matrix
}
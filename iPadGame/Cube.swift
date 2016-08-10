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
        
        numberOfVertices = 8
    }
    
    override internal func CreateIndexData(inout indices:[Int32])
    {
        indices = [Int32](count:36, repeatedValue: 0)
        
        //Front
        indices[0] = vertexOffset + 0
        indices[1] = vertexOffset + 1
        indices[2] = vertexOffset + 2
        
        indices[3] = vertexOffset + 0
        indices[4] = vertexOffset + 2
        indices[5] = vertexOffset + 3
        
        //Back
        indices[6] = vertexOffset + 5
        indices[7] = vertexOffset + 7
        indices[8] = vertexOffset + 6
        
        indices[9] = vertexOffset + 4
        indices[10] = vertexOffset + 5
        indices[11] = vertexOffset + 6
        
        //Left
        indices[12] = vertexOffset + 4
        indices[13] = vertexOffset + 6
        indices[14] = vertexOffset + 1
        
        indices[15] = vertexOffset + 4
        indices[16] = vertexOffset + 1
        indices[17] = vertexOffset + 0
        
        //Right
        indices[18] = vertexOffset + 3
        indices[19] = vertexOffset + 2
        indices[20] = vertexOffset + 7
        
        indices[21] = vertexOffset + 3
        indices[22] = vertexOffset + 7
        indices[23] = vertexOffset + 5
        
        //Top
        indices[24] = vertexOffset + 4
        indices[25] = vertexOffset + 0
        indices[26] = vertexOffset + 3
        
        indices[27] = vertexOffset + 4
        indices[28] = vertexOffset + 3
        indices[29] = vertexOffset + 5
        
        //Bottom
        indices[30] = vertexOffset + 1
        indices[31] = vertexOffset + 6
        indices[32] = vertexOffset + 7
        
        indices[33] = vertexOffset + 1
        indices[34] = vertexOffset + 7
        indices[35] = vertexOffset + 2
    }
    
    //I use a custom struct to create the vertex data, so it is easier to read.
    //I then convert it to an array of float arrays so that it is more universal, and
    //allows derived classes from the RenderableObject class to be able to have different
    //vertex structues.  Since this is done once, when loading the data, the performance hit
    //is negligable.
    override internal func CreateVertexData(inout vertices:[[Float]])
    {
        //Create the vertices for the cube.
        var cubeVertexData = [Vertex_PositionNormalColor!](count: numberOfVertices, repeatedValue: Vertex_PositionNormalColor())
        
        //Top Front Left
        cubeVertexData[0].position = vector_float3(-0.5, 0.5, 1.0)
        cubeVertexData[0].color = vector_float4(1.0, 1.0, 0.0, 1.0)
        //Bottom Front Left
        cubeVertexData[1].position = vector_float3(-0.5, -0.5, 1.0)
        cubeVertexData[1].color = vector_float4(1.0, 1.0, 0.0, 1.0)
        //Bottom Front Right
        cubeVertexData[2].position = vector_float3(0.5, -0.5, 1.0)
        cubeVertexData[2].color = vector_float4(1.0, 1.0, 0.0, 1.0)
        //Top Front Right
        cubeVertexData[3].position = vector_float3(0.5, 0.5, 1.0)
        cubeVertexData[3].color = vector_float4(1.0, 1.0, 0.0, 1.0)
        
        //Top Back Right
        cubeVertexData[4].position = vector_float3(-0.5,  0.5, -1.0)
        cubeVertexData[4].color = vector_float4(1.0, 1.0, 0.0, 1.0)
        //Top Back Left
        cubeVertexData[5].position = vector_float3(0.5, 0.5, -1.0)
        cubeVertexData[5].color = vector_float4(1.0, 1.0, 0.0, 1.0)
        //Bottom Back Right
        cubeVertexData[6].position = vector_float3(-0.5, -0.5, -1.0)
        cubeVertexData[6].color = vector_float4(1.0, 1.0, 0.0, 1.0)
        //Bottom Back Left
        cubeVertexData[7].position = vector_float3(0.5, -0.5, -1.0)
        cubeVertexData[7].color = vector_float4(1.0, 1.0, 0.0, 1.0)
 
        //Store the vertex data into the vertices array.
        vertices = [[Float]](count: numberOfVertices, repeatedValue: [])
        
        for (index, vertex) in cubeVertexData.enumerate()
        {
            vertices[index] = vertex!.ConvertToFloatArray()
        }
        
    }
    
    override func GetIndexData() -> [Int32] {
        var indices:[Int32] = []
        CreateIndexData(&indices)
        
        return indices
    }
    
    
    override func GetVertexData() -> [[Float]] {
        var vertices:[[Float]] = []
        CreateVertexData(&vertices)
        
        return vertices
    }
    
}
//
//  RenderableObject.swift
//  iPadGame
//
//  Created by Andrew Clear on 5/24/16.
//  Copyright © 2016 Andrew Clear. All rights reserved.
//

import Foundation
import simd

class RenderableObject:BaseObject
{
    //var colorData:[Float] = []
    //var vertices:[[Float]] = []
    
    internal var numberOfIndices:Int = 0;
    internal var numberOfVertices:Int = 0;
    internal var vertexOffset:Int = 0;
    internal var indexOffset:Int = 0;
    
    override init()
    {
        super.init()
    }
    
    internal func CreateIndexData(inout indices:[Int32])
    {
        
    }
    
    internal func CreateVertexData(inout vertices:[[Float]])
    {

    }
    
    
    ///////////////////////////////////////////////////
    // ACCESSORS
    //////////////////////////////////////////////////
    
    func GetNumberOfIndices() ->Int
    {
        return numberOfIndices
    }
    
    func GetNumberOfVertices() ->Int
    {
        return numberOfVertices
    }
    
    //func GetVertexData() -> UnsafeMutablePointer<Float>
    //{
    //    return UnsafeMutablePointer(vertices)
    //}
    
    func GetIndexData() -> [Int32]
    {
        return []
    }
    
    func GetVertexData() -> [[Float]]
    {
        return []
    }
    
    
    ///////////////////////////////////////////
    // MUTATORS
    //////////////////////////////////////////
    
    func SetIndexOffset(offset:Int)
    {
        indexOffset = offset
    }
    
    func SetVertexOffset(offset:Int)
    {
        vertexOffset = offset
    }
    
    /////////////////////////////////////////////
    // Debug functions
    /////////////////////////////////////////////
    func PrintOffsets()
    {
        print("Vertex offset is \(vertexOffset), Index offset is \(indexOffset)")
    }
}
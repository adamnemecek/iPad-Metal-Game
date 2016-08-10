//
//  MetalRenderer.swift
//  iPadGame
//
//  Created by Andrew Clear on 5/24/16.
//  Copyright © 2016 Andrew Clear. All rights reserved.
//

import Foundation
import Metal
import MetalKit
import simd
//import UIKit
//import QuartzCore

struct Constants
{
    var modelViewProjectionMatrix = matrix_identity_float4x4
    var normalMatrix = matrix_identity_float3x3
}

@objc
class MetalRenderer : IRenderer, MTKViewDelegate
{
    weak var metalView: MTKView!
    var commandQueue : MTLCommandQueue! = nil
    var depthStencilState : MTLDepthStencilState! = nil
    var device : MTLDevice! = nil
    var metalLayer : CAMetalLayer! = nil
    var pipelineState : MTLRenderPipelineState! = nil
    var vertexDescriptor : MTLVertexDescriptor! = nil
    
    var vertices : [[Float]] = []
    var indices : [Int32] = []
    var vertArray : Array<Float> = Array<Float>()
    
    var vertexBuffer : MTLBuffer! = nil
    var indexBuffer : MTLBuffer! = nil
    
    var constants = Constants()
    
    var fragmentProgram : MTLFunction! = nil
    var vertexProgram : MTLFunction! = nil

    init?(mtkView: MTKView)
    {
        metalView = mtkView
        metalView.sampleCount = 4 //4x MSAA multisampling
        metalView.clearColor = MTLClearColorMake(1, 0, 1, 1)
        metalView.colorPixelFormat = .BGRA8Unorm
        //metalView.depthStencilPixelFormat = MTLPixelFormat.Depth32Float
        //metalView.depthStencilPixelFormat = .Depth32Float
        //print(metalView.depthStencilPixelFormat)
        
        if let defaultDevice = MTLCreateSystemDefaultDevice()
        {
            device = defaultDevice
        }
        else
        {
            print("Metal is not supported")
            return nil
        }
        
        commandQueue = device.newCommandQueue()
        
        super.init()
        
        vertexDescriptor = MTLVertexDescriptor()
        vertexDescriptor.attributes[0].format = .Float3;
        vertexDescriptor.attributes[0].bufferIndex = 0;
        vertexDescriptor.attributes[0].offset = 0;
        
        vertexDescriptor.attributes[1].format = .Float4;
        vertexDescriptor.attributes[1].bufferIndex = 0;
        vertexDescriptor.attributes[1].offset = sizeof(Float) * 3;
        
        vertexDescriptor.attributes[2].format = .Float3;
        vertexDescriptor.attributes[2].bufferIndex = 0;
        vertexDescriptor.attributes[2].offset = sizeof(Float) * 7;
        
        vertexDescriptor.layouts[0].stride = sizeof(Float) * 10;
        vertexDescriptor.layouts[0].stepFunction = .PerVertex
        
        CreatePipelineState()
        
        depthStencilState = CreateDepthStencilState(.Less, isWriteEnabled: true)
        
        metalView.delegate = self
        metalView.device = device
        
        let viewSize = self.metalView.bounds.size
        let aspectRatio = Float(viewSize.width / viewSize.height)
        let verticalViewAngle = radians_from_degrees(65)
        let nearZ:Float = 0.1
        let farZ: Float = 100.0
        let projectionMatrix = matrix_perspective(verticalViewAngle, aspectRatio: aspectRatio, nearZ: nearZ, farZ: farZ)
        
        let viewMatrix = matrix_look_at(0, eyeY: 0, eyeZ: 2.5, centerX: 0, centerY: 0, centerZ: 0, upX: 0, upY: 1, upZ: 0)
        
        let modelViewMatrix = matrix_multiply(viewMatrix, matrix_identity_float4x4)
        constants.modelViewProjectionMatrix = matrix_multiply(projectionMatrix, modelViewMatrix)
        
        
    }
    
    override func AddRenderableObjectData (object:RenderableObject)
    {
        object.SetVertexOffset(vertices.count)
        object.SetIndexOffset(indices.count)
        
        let vertData:[[Float]] = object.GetVertexData()
        
        for vert in vertData {
            print(vert)
            vertArray.appendContentsOf(vert)
        }
        
        //vertices.appendContentsOf(object.GetVertexData())
        indices.appendContentsOf(object.GetIndexData())
    }
    
    override func AddToVertexBuffer(vertexData:UnsafeMutablePointer<Float>, count:Int)
    {
        vertexBuffer.contents().assignFrom(vertexData, count: count)
    }
    
    override internal func CreateBuffers()
    {
        var bufferLength = 40//sizeof(Vertex_PositionNormalColor)
        bufferLength *= vertices.count;
        
        vertexBuffer = device.newBufferWithBytes(vertArray, length: vertArray.count * sizeof(Float) , options: MTLResourceOptions.CPUCacheModeDefaultCache)
        vertexBuffer.label = "Vertex Buffer"
        
        indexBuffer = device.newBufferWithBytes(indices, length: indices.count * sizeof(Int32), options: MTLResourceOptions.CPUCacheModeDefaultCache)
        indexBuffer.label = "Index Buffer"
    }
    
    internal func CreateCommandQueue ()
    {
        commandQueue = device.newCommandQueue()
    }
    
    internal func CreateDepthStencilState(compareFunc: MTLCompareFunction, isWriteEnabled: Bool) -> MTLDepthStencilState
    {
        let depthStencilDescriptor = MTLDepthStencilDescriptor()
        depthStencilDescriptor.depthCompareFunction = compareFunc
        depthStencilDescriptor.depthWriteEnabled = isWriteEnabled
        
        return device.newDepthStencilStateWithDescriptor(depthStencilDescriptor)
    }
    
    internal func CreatePipelineState ()
    {
        let defaultLibrary = device.newDefaultLibrary()!
        fragmentProgram = defaultLibrary.newFunctionWithName("passThroughFragment")
        vertexProgram = defaultLibrary.newFunctionWithName("passThroughVertex")
        
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.label = "Render Pipeline"
        pipelineStateDescriptor.sampleCount = metalView.sampleCount
        pipelineStateDescriptor.vertexFunction = vertexProgram
        pipelineStateDescriptor.fragmentFunction = fragmentProgram
        pipelineStateDescriptor.vertexDescriptor = vertexDescriptor
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = metalView.colorPixelFormat
        //pipelineStateDescriptor.depthAttachmentPixelFormat = metalView.depthStencilPixelFormat
        
        do
        {
            try(pipelineState = device.newRenderPipelineStateWithDescriptor(pipelineStateDescriptor))
        }
        catch
        {
            print("Failed to create pipeline state")
        }
        
       
        
    }
    
    func render(view: MTKView)
    {
        let commandBuffer = commandQueue.commandBuffer()
        
        let renderPassDescriptor = metalView.currentRenderPassDescriptor
        
        if let renderPassDescriptor = renderPassDescriptor
        {
            let renderEncoder = commandBuffer.renderCommandEncoderWithDescriptor(renderPassDescriptor)
            
            renderEncoder.pushDebugGroup("Draw Cube")
            renderEncoder.setFrontFacingWinding(.CounterClockwise)
            //renderEncoder.setDepthStencilState(depthStencilState)
            renderEncoder.setRenderPipelineState(pipelineState)
            renderEncoder.setVertexBuffer(vertexBuffer, offset:0, atIndex:0)
            renderEncoder.setVertexBytes(&constants, length: sizeof(Constants.self), atIndex: 1)
            renderEncoder.drawIndexedPrimitives(MTLPrimitiveType.Triangle, indexCount: 36/*indices.count*/, indexType: MTLIndexType.UInt32, indexBuffer: indexBuffer, indexBufferOffset: 0)
            
            renderEncoder.popDebugGroup()
            renderEncoder.endEncoding()
        
        
            if let drawable = view.currentDrawable
            {
                commandBuffer.presentDrawable(drawable)
            }
        }
        
        commandBuffer.commit()
        
    }
    
    func mtkView(_view: MTKView, drawableSizeWillChange size: CGSize)
    {
        //respond to resize
    }
    
    func drawInMTKView(view: MTKView)
    {
        //print("DrawInMTKView")
        render(view)
    }
}
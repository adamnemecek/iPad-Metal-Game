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
import UIKit
import QuartzCore
/*
let MaxBuffers = 3
let ConstantBufferSize = 1024*1024
*/
class MetalRenderer : IRenderer
{
    var commandQueue : MTLCommandQueue! = nil
    var device : MTLDevice! = nil
    var metalLayer : CAMetalLayer! = nil
    var pipelineState : MTLRenderPipelineState! = nil
    var vertexBuffer : MTLBuffer! = nil
    
    var fragmentProgram : MTLFunction! = nil
    var vertexProgram : MTLFunction! = nil
    /*
    var vertexColorBuffer: MTLBuffer! = nil
    
    let inflightSemaphore = dispatch_semaphore_create(MaxBuffers)
    var bufferIndex = 0
    */
    override func Init(view: UIView!)
    {
        
        device = MTLCreateSystemDefaultDevice()
        
        /*
        guard device != nil else { // Fallback to a blank UIView, an application could also fallback to OpenGL ES here.
            print("Metal is not supported on this device")
            self.view = UIView(frame: self.view.frame)
            return
        }
        */
        
        let metalView = view as! MTKView
        
        metalLayer = CAMetalLayer()
        metalLayer.device = device;
        metalLayer.pixelFormat = .BGRA8Unorm;
        metalLayer.framebufferOnly = true;
        metalLayer.frame = metalView.layer.frame;
        //view.layer.addSubLayer(metalLayer);
        
        CreatePipelineState()
        
        commandQueue = device.newCommandQueue()
    }
    
    func CreateCommandQueue ()
    {
        commandQueue = device.newCommandQueue();
    }
    
    func CreatePipelineState ()
    {
        let defaultLibrary = device.newDefaultLibrary()
        fragmentProgram = defaultLibrary!.newFunctionWithName("passThroughFragment")
        vertexProgram = defaultLibrary!.newFunctionWithName("passThroughVertex")
        
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = vertexProgram;
        pipelineStateDescriptor.fragmentFunction = fragmentProgram;
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = .BGRA8Unorm
        
        do
        {
            try(pipelineState = device.newRenderPipelineStateWithDescriptor(pipelineStateDescriptor))
        }
        catch
        {
            print("Failed to create pipeline state")
        }
        
    }
    
    override func CreateVertexBuffer(vertexData:[Float])
    {
        var dataSize : Int
        dataSize = vertexData.count * sizeofValue(vertexData[0])
        vertexBuffer = device.newBufferWithBytes(vertexData, length: dataSize, options: [])
    }
    
    override func Render()
    {
        let drawable = metalLayer.nextDrawable()!
        
        let renderPassDescriptor = MTLRenderPassDescriptor()
        renderPassDescriptor.colorAttachments[0].texture = drawable.texture
        renderPassDescriptor.colorAttachments[0].loadAction = .Clear
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColor(red: 128.0, green: 1.0, blue: 0.0, alpha: 1.0)
        
        let commandBuffer = commandQueue.commandBuffer()
        let renderEncoder = commandBuffer.renderCommandEncoderWithDescriptor(renderPassDescriptor)
        //let renderEncoder = renderEncoderOpt
        
        renderEncoder.setRenderPipelineState(pipelineState)
        //renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, atIndex: 0)
        //renderEncoder.drawPrimitives(.Triangle, vertexStart: 0, vertexCount: 3, instanceCount: 1)
        renderEncoder.endEncoding()
        
        commandBuffer.presentDrawable(drawable)
        commandBuffer.commit()
        
    }
}
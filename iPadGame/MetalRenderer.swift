//
//  MetalRenderer.swift
//  iPadGame
//
//  Created by Andrew Clear on 5/24/16.
//  Copyright © 2016 Andrew Clear. All rights reserved.
//

//import Foundation
import Metal
import MetalKit
//import UIKit
//import QuartzCore
/*
let MaxBuffers = 3
let ConstantBufferSize = 1024*1024
*/
@objc
class MetalRenderer : IRenderer, MTKViewDelegate//IRenderer, MTKViewDelegate
{
    weak var metalView: MTKView!
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
    init?(mtkView: MTKView)
    {
        
        if let defaultDevice = MTLCreateSystemDefaultDevice()
        {
            device = defaultDevice
        }
        else
        {
            print("Metal is not supported")
            return nil
        }
        
        metalView = mtkView
        //metalView.sampleCount = 4 //4x MSAA multisampling
        metalView.clearColor = MTLClearColorMake(1, 0, 1, 1)
        metalView.colorPixelFormat = .BGRA8Unorm
        
        //metalLayer = CAMetalLayer()
        //metalLayer.device = device
        //metalLayer.pixelFormat = .BGRA8Unorm
        //metalLayer.framebufferOnly = true
        //metalLayer.frame = metalView.layer.frame
        //metalView.layer.addSublayer(metalLayer)
        
        commandQueue = device.newCommandQueue()
        
        super.init()
        
        CreatePipelineState()
        
        metalView.delegate = self
        metalView.device = device
    }
    
    func CreateCommandQueue ()
    {
        commandQueue = device.newCommandQueue()
    }
    
    func CreatePipelineState ()
    {
        let defaultLibrary = device.newDefaultLibrary()!
        fragmentProgram = defaultLibrary.newFunctionWithName("passThroughFragment")
        vertexProgram = defaultLibrary.newFunctionWithName("passThroughVertex")
        
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.label = "Render Pipeline"
        pipelineStateDescriptor.sampleCount = metalView.sampleCount
        pipelineStateDescriptor.vertexFunction = vertexProgram
        pipelineStateDescriptor.fragmentFunction = fragmentProgram
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
    
    //override func CreateVertexBuffer(vertexData:[Float])
    //{
    //    var dataSize : Int
    //    dataSize = vertexData.count * sizeofValue(vertexData[0])
    //    vertexBuffer = device.newBufferWithBytes(vertexData, length: dataSize, options: [])
    //}
    
    /*override*/ func render(_view: MTKView)
    {
        let commandBuffer = commandQueue.commandBuffer()
        
        let renderPassDescriptor = metalView.currentRenderPassDescriptor
        
        if let renderPassDescriptor = renderPassDescriptor
        {
            let renderEncoder = commandBuffer.renderCommandEncoderWithDescriptor(renderPassDescriptor)
            renderEncoder.pushDebugGroup("Render")
            renderEncoder.setFrontFacingWinding(.CounterClockwise)
            renderEncoder.setRenderPipelineState(pipelineState)
            
            renderEncoder.popDebugGroup()
            renderEncoder.endEncoding()
        
        
        //let drawable = metalLayer.nextDrawable()!
        
        
        //renderPassDescriptor.colorAttachments[0].texture = drawable.texture
        //renderPassDescriptor.colorAttachments[0].loadAction = .Clear
        //renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColor(red: 128.0, green: 1.0, blue: 0.0, alpha: 1.0)
        
        
        //let renderEncoder = commandBuffer.renderCommandEncoderWithDescriptor(renderPassDescriptor)
        //let renderEncoder = renderEncoderOpt
        
        //renderEncoder.setRenderPipelineState(pipelineState)
        //renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, atIndex: 0)
        //renderEncoder.drawPrimitives(.Triangle, vertexStart: 0, vertexCount: 3, instanceCount: 1)
        //renderEncoder.endEncoding()
        
            if let drawable = metalView.currentDrawable
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
    
    //@objc(drawInMTKView:)
    //func draw(in view: MTKView)
    //{
    //    render(view)
    //}
    
    func drawInMTKView(view: MTKView)
    {
        print("DrawInMTKView")
        render(view)
    }
}
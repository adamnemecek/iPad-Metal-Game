//
//  GameViewController.swift
//  iPadGame
//
//  Created by Andrew Clear on 5/24/16.
//  Copyright © 2016 Andrew Clear. All rights reserved.
//

import UIKit
import Metal
import MetalKit

class GameViewController:UIViewController {
    
    var renderer : IRenderer! = nil
    var timer : CADisplayLink! = nil
    
    var vertexColorBuffer: MTLBuffer! = nil
    
    //let inflightSemaphore = dispatch_semaphore_create(MaxBuffers)
    //var bufferIndex = 0
    
    //TEST CODE
    var character : BaseCharacter = BaseCharacter()
    var skill : BaseSkill = BaseSkill()
    var battleSystem : BattleSystem = BattleSystem()
    
    var testTriangle:Cube! = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //renderer = MetalRenderer()
        
        let metalView = self.view as! MTKView
        renderer = MetalRenderer(mtkView:metalView)
        
        //renderer.Init(self.view)
        //view.delegate = self
        
        timer = CADisplayLink(target: self, selector: #selector(GameViewController.gameLoop))
        timer.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
        
        loadAssets()
        
        var battleCommand : BattleCommand! = nil
        battleCommand = BattleCommand(characterToUse: character, skillToUse: skill)
        battleSystem.AddBattleCommnad(battleCommand)
    }
    
    func gameLoop()
    {
        //battleSystem.DebugPrint()
    }
    
    func loadAssets() {
        testTriangle = Cube()
        
        renderer.AddRenderableObjectData(testTriangle)
        testTriangle.PrintOffsets()
        
        renderer.CreateBuffers()
    }
    
    func update() {
        

    }
    
}

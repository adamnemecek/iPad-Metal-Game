//
//  BaseCharacter.swift
//  iPadGame
//
//  Created by Andrew Clear on 7/26/16.
//  Copyright © 2016 Andrew Clear. All rights reserved.
//

import Foundation

class BaseCharacter : BaseAttributes
{
    var renderableObjectComponent : RenderableObject
    
    var name : String
    
    override internal init()
    {
        renderableObjectComponent = RenderableObject()
        name = "Name"
        
        super.init()
    }

}

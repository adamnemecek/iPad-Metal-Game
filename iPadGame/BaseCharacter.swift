//
//  BaseCharacter.swift
//  iPadGame
//
//  Created by Andrew Clear on 7/26/16.
//  Copyright © 2016 Andrew Clear. All rights reserved.
//

import Foundation

class BaseCharacter : RenderableObject
{
    //Components
    var attributesComponent : BaseAttributes
    
    //Character specific attributes
    var health : Int
    var job : BaseJob! = nil
    var name : String
    var mana : Int
    
    
    override init()
    {
        attributesComponent = BaseAttributes()
        name = "Name"
        health = 30
        mana = 15
        
        super.init()
    }

}

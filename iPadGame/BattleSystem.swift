//
//  BattleSystem.swift
//  iPadGame
//
//  Created by Andrew Clear on 7/26/16.
//  Copyright © 2016 Andrew Clear. All rights reserved.
//

import Foundation

struct BattleCommand
{
    var characterToUse : BaseCharacter
    var skillToUse : BaseSkill
    
    //func CreateBattleCommand (character : BaseCharacter, skill : BaseSkill)
    //{
     //   characterToUse = character
      //  skillToUse = skill
    //}
}

public class BattleSystem
{
    private var commandList : LinkedList<BattleCommand>! = nil
    
    func AddBattleCommnad (command : BattleCommand)
    {
        commandList.add(command)
    }

    func DebugPrint()
    {
        let command : BattleCommand = commandList.first()!.value
        
        print(command.characterToUse.name)
        print(command.skillToUse)
    }
    
    internal init()
    {
        commandList = LinkedList<BattleCommand>()
    }
}
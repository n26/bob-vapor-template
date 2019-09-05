//
//  Bonjour.swift
//  BobTheBuilder
//
//  Created by Jan Chaloupecky on 17.10.18.
//

import Foundation
import Bob

/**
 Sample custom command
 */
public class BonjourCommand: Command {
    
    public init() {
        
    }
    
    public var name: String {
        return "bonjour"
    }
    
    public var usage: String {
        return "Just say `bonjour` to me. I'll reply back"
    }
    
    public func execute(with parameters: [String], replyingTo sender: MessageSender) throws {
        sender.send("Bonjour 👋")
    }
    
}

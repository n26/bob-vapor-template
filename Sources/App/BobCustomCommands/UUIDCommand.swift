//
//  HTTPCommand.swift
//  App
//
//  Created by Jan Chaloupecky on 06.09.19.
//

import Foundation
import Bob
import protocol Vapor.Container
import protocol Vapor.Content
import typealias Vapor.Future

/// Command showing a async http command
public class UUIDCommand: Command {

    struct UUIDResponse: Content {
        let uuid: String
    }

    let container: Container
    public init(container: Container) {
        self.container = container
    }

    public var name: String {
        return "uuid"
    }

    public var usage: String {
        return "Just say `uuid` to me, I'll send back a uuid"
    }

    public func execute(with parameters: [String], replyingTo sender: MessageSender) throws {
        sender.send("Fetching some UUID")
        try fetchUUID().map { uuid in
            sender.send("`\(uuid.uuid)`")
        }.catch { error in
            sender.send("Something went wrong: \(error)")
        }
    }

    private func fetchUUID() throws -> Future<UUIDResponse> {
        return try container.client().get("https://httpbin.org/uuid")
    }

}
